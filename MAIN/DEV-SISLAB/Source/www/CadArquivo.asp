<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
'Verifico se estou apenas validando o documento, varias opcoes sao desabilitadas
ehValidacao = (request("ehValidacao") = "1")

If not Env.usuarioCRT Then
	response.redirect "msgAcessoNA.asp"
End if

Dim objSiteRS, sSQL,i,auxi, rs_Agenda
Dim auxnomearq,auxlink,auxcodtipo
Dim auxarqresponsavel,auxidorgao,auxobservacao,auxvinculado
Dim auxdataatualiz, auxdescricao,auxversao,auxdataatual
Dim auxdiaatualiz,auxmesatualiz,auxanoatualiz
Dim auxaltera,auxselecao,cbano,auxidsituacao, auxo1, auxo2, auxo3,auxAS,auxOS

auxselecao = 0

If request("Arquivos") <> "0" and request("Arquivos") <> "" and IsNumeric(request("Arquivos")) Then
	auxselecao = CInt(trim(request("Arquivos")))
End If


sSQL = "Select * from vw_ARQRes Where ARQ_CodArq = " & trim(auxselecao)
' trazer os dados de Informacoes do arquivo selecionado
Call Env.RecordSet( true, objSiteRS, sSQL)

If Not objSiteRS.EOF Then
	objSiteRS.Movefirst

	sSQL = "select distinct g.ag_numero,a.arq_os from arquivos a left join diagramas d on a.arq_codarq=d.arq_codarq left join agendamento g on g.ag_numero = d.ag_numero where a.arq_codarq=" & auxselecao
	call Env.RecordSet( true, rsAS, sSQL)
	if not (rsAS.eof and rsAS.bof) then
		auxAS = rsAS("Ag_numero")
		auxOS = rsAS("arq_os")
	end if

	auxnomearq = objSiteRS( "ARQ_NomeArq" )
	auxlink = objSiteRS( "ARQ_link" )
	'auxvinculado = objSiteRS("ARQ_vinculacao")
	auxversao = objSiteRS( "ARQ_versao" )
	auxcodtipo = objSiteRS( "ARQ_codarqtipo" )
	auxobservacao = objSiteRS( "ARQ_observacao" )
	auxdescricao = objSiteRS( "ARQ_descricao" )
	auxidsituacao = objSiteRS( "ARQ_idsituacao" )
	auxconfidencial = objSiteRS( "ARQ_OCULTAR" )

	'auxidorgao=objSiteRS("ARQ_idorgao")
	if ehValidacao then 
		auxaltera = "Validar"
	else
		auxaltera = "Alterar"
	end if

	auxarqresponsavel = objSiteRS( "ARQ_responsavel" )
	if len( day( objSiteRS( "ARQ_DATAAPROVACAO" ) ) ) = 1 then
		auxdiaatualiz = "0" & day( objSiteRS( "ARQ_DATAAPROVACAO" ) )
	else
		auxdiaatualiz = day( objSiteRS( "ARQ_DATAAPROVACAO" ) )
	end if
	if len( month( objSiteRS( "ARQ_DATAAPROVACAO" ) ) ) = 1 then
		auxmesatualiz = "0" & month( objSiteRS( "ARQ_DATAAPROVACAO" ) )
	else
		auxmesatualiz = month( objSiteRS( "ARQ_DATAAPROVACAO" ) )
	end if
	auxanoatualiz = year( objSiteRS( "ARQ_DATAAPROVACAO" ) )

	auxo1 = objSiteRS( "ARQ_O1" )
	auxo2 = objSiteRS( "ARQ_O2" )
	auxo3 = objSiteRS( "ARQ_O3" )

	'Fechar Objetos abertos

	objSiteRS.Close
	Set objSiteRS = Nothing
else
	auxdataatual = Date()
	auxaltera = "Inserir"
End if

%>
<script type="text/javascript" src="includes/anexo.js"></script>

<script type="text/javascript">
    function adiciona(chave, item1, lista) {
    // funcao que acrescenta um item em uma lista
	    lista.options[lista.options.length] = new Option(item1, chave);
    }

    function retira(lista) {
    // funcao que retira um item que esteja selecionado em uma lista
	    if (lista.selectedIndex != -1)
		    lista.options[lista.selectedIndex]=null;
    }

    function selecionaItens(lista) {
    //Seleciona todos os itens de uma lista
	    var i
	    for(i=0; i<lista.length; i++)  
  		    lista.options[i].selected = true
    }

    function verificaLista(valor, lista) {
    //Verifica se um valor j� se encontra na lista
	    var i;
	    for(i=0; i<lista.length; i++)
		    if (lista[i].text.indexOf(valor) != -1)
			    return(true);
	    return(false);
    }

    //===================================================================================================

    function montaAtualiza()
    {
	    var frm = document.formulario;
	    if( frm.diaatualiz.value != "0" && frm.mesatualiz.value != "0" && frm.anoatualiz.value != "0" )
		    frm.txtatualiza.value = completa(frm.diaatualiz.value,2) + "/" + completa(frm.mesatualiz.value,2) + "/" + completa(frm.anoatualiz.value,4);
	    else
		    frm.txtatualiza.value = "";
    }
    function ValidaCampos() {
    <% if  ehValidacao then%>
    if( !( ValidaDataMesAno( completa(document.formulario.diavalidacao.value,2) + "/" + completa(document.formulario.mesvalidacao.value,2) + "/" + completa(document.formulario.anovalidacao.value,4), "Data Valida��o" ) ) ) {
		    return false;
	    }
    <%end if%>
    <% if not ehValidacao then%>
	    if( document.formulario.titulo.value == "" ) {
		    alert( "Título do arquivo não informado.\nInforme o título do arquivo." );
		    document.formulario.titulo.focus();
		    return false;
	    }
	    if( AchaAspas( document.formulario.titulo.value ) )
	    {
		    alert( "Título do arquivo não pode conter Aspas ou apóstrofes.\nCorrija o Título do arquivo." );
		    document.formulario.titulo.focus();
		    return false;
	    }
	    if( !( ValidaDataMesAno( completa(document.formulario.diaatualiz.value,2) + "/" + completa(document.formulario.mesatualiz.value,2) + "/" + completa(document.formulario.anoatualiz.value,4), "Data Atualiza��o" ) ) ) {
		    return false;
	    }
	    if( document.formulario.tipoarquivo.value == "" ) {
		    alert( "Tipo de arquivo não informado.\nInforme o tipo de arquivo." );
		    document.formulario.tipoarquivo.focus();
		    return false;
	    }
	    if( document.formulario.situacao.value == "" ) {
		    alert( "Situação do arquivo não informada.\nInforme a situação do arquivo." );
		    document.formulario.situacao.focus();
		    return false;
	    }
	    if( document.formulario.responsavel.value == "" ) {
		    alert( "Responsável pelo arquivo não informado.\nInforme o Responsável pelo o arquivo." );
		    document.formulario.responsavel.focus();
		    return false;
	    }
	    if( (document.formulario.o1.value != "") && (isNaN(document.formulario.o1.value)) ) {
		    alert( "Valor da Versão incorreto." );
		    document.formulario.o1.focus();
		    return false;
	    }
	    if( (document.formulario.o2.value != "") && (isNaN(document.formulario.o2.value)) ) {
		    alert( "Valor da Versão incorreto." );
		    document.formulario.o2.focus();
		    return false;
	    }
	    if( (document.formulario.o3.value != "") && (isNaN(document.formulario.o3.value)) ) {
		    alert( "Valor da Versão incorreto." );
		    document.formulario.o3.focus();
		    return false;
	    }

	    if( formulario.cmbAgendamento[ 0 ].checked ){
		    if(document.formulario.auxOS.value == "0"){
			    var resp
			    resp=confirm("Você não selecionou nenhuma OS, deseja realmente vincular o arquivo somente ao Agendamento?");
			    if (!resp){
				    document.formulario.cmbOs.focus();
				    return resp;
			    }
		    }
	    }
	    //selecionaItens(document.formulario.lstAgendamento);
    <%end if%>	

    //	alert(document.formulario.FILE1.value);
    //	alert(extractFileName(document.formulario.FILE1.value));
    //	alert(validaNomeArquivo(extractFileName(document.formulario.FILE1.value)));
    //	return false;

    <% if auxselecao = 0 then %>
	    if( document.formulario.FILE1.value == '' ) {
		    alert( 'Nome do arquivo não informado. Informe o nome do arquivo.' );
		    document.formulario.FILE1.focus();
		    return false;
	    }
	    if( AchaAspas( document.formulario.FILE1.value ) ) {
		    alert("Nome do Arquivo não pode conter Aspas ou apóstrofes.\nCorrija o Nome do arquivo.");
		    document.formulario.FILE1.focus();
		    return false;
	    }
	    if( !validaNomeArquivo(extractFileName(document.formulario.FILE1.value)) ) {
		    alert("O nome do arquivo está inválido. Retire acentuação e espaços antes de prosseguir.");
		    document.formulario.FILE1.focus();
		    return false;
	    }
    <% end if%>

	    resposta = confirm("Deseja que este upload seja comunicado via e-mail aos usuarios CRT?")
	    if (resposta)
		    frm.resp.value = "1";

	    frm.chkconfidencial.disabled = false;
	    frm.responsavel.disabled = false;
	    frm.action = "CadArquivoA.asp"
	    frm.method = "post";
	    frm.target = "";
	    return true;
    }

    function sugereNome()
    {
	    var frm = document.forms[0];

	    if( formulario.cmbAgendamento[ 0 ].checked )
	    {
		    var numAS = frm.auxAS.value;
		    var numOS = frm.auxOS.value;
		    var tipoDoc = frm.auxTipo.value;

		    if ( tipoDoc == ''){
			    frm.tipoarquivo.value = '';
			    frm.titulo.value = '';
			    frm.titulo.readOnly = false;
			    frm.titulo.style.backgroundColor = "#FFFFFF";
		    }

		    if (numAS == ''){
			    alert('Escolha primeiro a AS');
			    frm.tipoarquivo.value = '';
			    frm.txAS.focus();		
			    return false;
		    }
	    }
	    frm.titulo.value = '';
	    frm.titulo.readOnly = false;
	    frm.titulo.style.backgroundColor = "#FFFFFF";

	    if( formulario.cmbAgendamento[ 0 ].checked ){
		    if (numOS != '0')
			    numOS = '-' + completa(numOS,2);
		    else
			    numOS = '';
	    }

	    //Este tipo � para Relat�rio de Ensaios
	    if (tipoDoc == '33'){
		    if(formulario.cmbAgendamento[ 0 ].checked)
			    frm.titulo.value = 'REL-' + completa(numAS,4) + numOS;
		    frm.versao.value = '00';
		    frm.o1.value = '0';
		    frm.o2.value = '0';
		    frm.o3.value = '0';
		    frm.mesatualiz.value = completa('<%=month(date)%>',2);
		    frm.diaatualiz.value = completa('<%=day(date)%>',2);
		    frm.anoatualiz.value = completa('<%=year(date)%>',4);
		    montaAtualiza();
		    frm.situacao.value = 2;
		    frm.titulo.readOnly = true;
		    frm.titulo.style.backgroundColor = "#EEEEEE";
	    }
	    //Laudo
	    if (tipoDoc == '7'){
		    if(formulario.cmbAgendamento[ 0 ].checked)
			    frm.titulo.value = 'LD-' + completa(numAS,4) + numOS
		    frm.versao.value = '00';
		    frm.o1.value = '0';
		    frm.o2.value = '0';
		    frm.o3.value = '0';
		    frm.mesatualiz.value = completa('<%=month(date)%>',2);
		    frm.diaatualiz.value = completa('<%=day(date)%>',2);
		    frm.anoatualiz.value = completa('<%=year(date)%>',4);
		    montaAtualiza();
		    frm.situacao.value = 2;
		    frm.titulo.readOnly = true;
		    frm.titulo.style.backgroundColor = "#EEEEEE";
	    }
	    //Roteiros
	    if (tipoDoc == '20'){
		    if( formulario.cmbAgendamento[ 0 ].checked )
			    frm.titulo.value = 'ROE-' + completa(numAS,4) + numOS;
		    frm.versao.value = '00';
		    frm.o1.value = '0';
		    frm.o2.value = '0';
		    frm.o3.value = '0';
		    frm.mesatualiz.value = completa('<%=month(date)%>',2);
		    frm.diaatualiz.value = completa('<%=day(date)%>',2);
		    frm.anoatualiz.value = completa('<%=year(date)%>',4);
		    montaAtualiza();
		    frm.situacao.value = 2;
		    frm.titulo.readOnly = true;
		    frm.titulo.style.backgroundColor = "#EEEEEE";
	    }
	    //Diagramas
	    if (tipoDoc == '8'){
		    if( formulario.cmbAgendamento[ 0 ].checked )
			    frm.titulo.value = 'DIAGRAMA-' + completa(numAS,4) + ' (' + completa(frm.contdia.value,2) + ')'
		    frm.versao.value = '00';
		    frm.o1.value = '0';
		    frm.o2.value = '0';
		    frm.o3.value = '0';
		    frm.mesatualiz.value = completa('<%=month(date)%>',2);
		    frm.diaatualiz.value = completa('<%=day(date)%>',2);
		    frm.anoatualiz.value = completa('<%=year(date)%>',4);
		    montaAtualiza();
		    frm.situacao.value = 2;
		    frm.titulo.readOnly = true;
		    frm.titulo.style.backgroundColor = "#EEEEEE";
	    }
    }

    function completa(valor,tam){
	    var i=0,buf=''
	    for(;i < tam - valor.length ; i++){
		    buf = '0' + buf
	    }
	    valor = buf + valor;
	    return valor
    }
    function atualizaOS(){
	    var frm = document.forms[0];
	    var comboOS = frm.cmbOs;
	    var numOS = comboOS.selectedIndex;
	    frm.auxOS.value = numOS;
	    sugereNome();
    }

    function atualizaTipoDoc(){
	    var frm = document.forms[0];
	    var comboTipo = frm.tipoarquivo;
	    var tipoDoc = comboTipo[comboTipo.selectedIndex].value;	
	    //alert(tipoDoc);
	    frm.auxTipo.value = tipoDoc;
    }
    function preencheAS(){
	    frm = document.forms[0];
	    var combo = frm.agendamento
	    frm.txAS.value = combo[combo.selectedIndex].value
    }
    function janelaespecial(link1)
    {
        window.open(link1,'Arquivos_CRT','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=800,height=600,top=0,left=0');
    }
</script>

<% 
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - " & auxaltera & " " & auxlink, "", "")
%>
<div class="margem-10">
    <form method="post" action="CadArquivoA.asp"  ENCTYPE="multipart/form-data" name="formulario"  onsubmit="return ValidaCampos();">
    <!--
	    Preciso deste campo para saber pra onde vou redirecionar quando der o submit,
	    porque este form é usado tanto para validar quanto para editar um arquivo.
    -->
    <input type="hidden" name="eh_validacao" value="<%=ehValidacao%>">

    <input type="hidden" name="username" value="<%=Env.usuario()%>" />
    <input type="hidden" name="ip" value=" <%= UCase( request.ServerVariables( "REMOTE_ADDR" ) ) %>" />
    <input type="hidden" name="tipocomando" value="<%=auxaltera%>" />
    <input type="hidden" name="codArquivo" value="<%=auxselecao%>" />
    <input type="hidden" name="txtatualiza" size="20" />
    <input type="hidden" name="contdia" value="0"/>
    <input type="hidden" name="resp" value="0" />
    <input type="hidden" name="auxAS">
    <input type="hidden" name="auxOS">
    <input type="hidden" name="auxTipo">

    <table width="100%" height="236" >
	    <tr> 
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
		    <td width="10%" height="0"></td>
	    </tr>
	    <tr valign="middle">
		    <th align="left" colspan="10">&nbsp;Agendamento</th>
	    </tr>
	    <tr valign="middle"> 
		    <td colspan="10" align="center">
			    <table width="90%" >
			    <tr>
				    <td colspan="10">
					    Agendamento vinculado:&nbsp;
					    <input type="radio" name="cmbAgendamento" onClick="PreparaCampos();" value="1" tabindex="13" checked>&nbsp;Sim&nbsp;&nbsp;
					    <input type="radio" name="cmbAgendamento" onClick="PreparaCampos();" value="0" tabindex="14">&nbsp;N&atilde;o
                        <script type="text/javascript">
                            function BuscaAS()
                            {
                                var frm = document.forms[0];
                                var combo = frm.agendamento

                                indice = -1;
                                for(i=0; i<combo.length; i++)
                                    if (combo[i].value == frm.txAS.value)
                                        indice = i;

                                if (indice != -1)
                                    combo.options[indice].selected = true
                                else
                                    combo.options[0].selected = true
                                //		combo.selectedindex = indice;
                                //		alert(indice);
                            }

                            function mudaAS(campo,labelCampo)
                            {
                                frm = document.forms[0];
                                frm1 = document.all;
                                var combo = frm.agendamento;

                                document.getElementById("OSCelula").style.display = "block";
                                document.getElementById("OSCelula").innerHTML = "<font face='verdana, arial' style='font-size:12px;'><b>Processando... </b></font>";

                                frm.action = "eventosInternos.asp?hdnevento=<%=1%>&label="+ labelCampo +"&as="+combo[combo.selectedIndex].value+"&campo="+campo;
                                frm.method = "post";
                                frm.target = "escondido";
                                frm.auxAS.value = combo[combo.selectedIndex].value;
                                frm.submit();
                            }

                            function mudaAS2(campo,labelCampo,auxas,auxOS)
                            {
                                frm = document.forms[0];
                                frm1 = document.all;

                                if (auxas == ""){
                                    document.getElementById("tabAgendamento").style.display = "none";
                                    frm1.cmbAgendamento[1].checked = true;
                                    //frm1.cmbAgendamento.value = 0;
                                    return false;
                                }
	
                                //alert(lista[lsta.selectedIndex].value)
                                //alert(lista[lista.selected].value);
                                document.getElementById("OSCelula").innerHTML = "<h6>Processando... </h6>"

                                frm.action = "eventosInternos.asp?hdnevento=<%=2%>&label="+ labelCampo +"&os=" + auxOS + "&as="+ auxas + "&campo="+campo;
                                frm.method = "post";
                                frm.target = "escondido";
                                frm.auxAS.value = auxas;
                                frm.submit();
                            }

                            function limpaTipo()
                            {
                                var frm = document.forms[0];
                                frm.tipoarquivo.value = '';
                                frm.titulo.value = '';
                                frm.titulo.readOnly = false;
                                frm.titulo.style.backgroundColor = "#FFFFFF";
                                document.getElementById("OSCelula").innerHTML = "<input type='Hidden' name='cmbOs' value ='-1'/>";
                            }

                            function PreparaCampos()
                            {
                                if( document.forms[0].cmbAgendamento[0].checked )
                                {
                                    document.getElementById("tabAgendamento").style.display = 'block';
                                    document.forms[0].txAS.value ='';
                                    document.forms[0].tipoarquivo.value = '';
                                    BuscaAS();
                                    document.getElementById("OSCelula").innerHTML = "<input type='Hidden' name = 'cmbOs' value ='-1'/>";
                                }
                                else{
                                    document.getElementById("tabAgendamento").style.display = 'none';
                                    document.forms[0].titulo.value = '';
                                    document.forms[0].titulo.readOnly = false;
                                    document.forms[0].titulo.style.backgroundColor = "#FFFFFF";
                                }
                            }
                        </script>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <div id="tabAgendamento"style="display: none;">
                            <br />
                            <strong>Agendamento:</strong><br />
    					    <input type="text" name="txAS" size="4"/ onKeyUp="BuscaAS();" onfocus="limpaTipo();">
	    				    <select name="agendamento" onFocus='limpaTipo();' onBlur="mudaAS('Os','OS Associada:');" onchange="preencheAS()">
		    				    <option value="">Escolha uma AS...</option><%
				sSQL = "Select A.AG_NUMERO, a.AG_TITULO, A.AG_DATAINICIO, A.AG_DATATERMINO, A.AG_USERNAME "
				sSQL = sSQL & " from vw_Agendamento a "
				sSQL = sSQL & " ORDER BY A.AG_NUMERO DESC"	' trazer os dados de Informacoes dos usuarios
				call Env.RecordSet( true, objSiteRS, sSQL)

				If Not objSiteRS.EOF Then 
						objSiteRS.Movefirst
					Do while not( objSiteRS.EOF ) %>
    						    <option value="<%= objSiteRS( "AG_Numero" ) %>">N<sup>o</sup>&nbsp;AS:&nbsp;<%= objSiteRS( "AG_NUMERO" ) %>&nbsp;-&nbsp;<%= Left( objSiteRS( "AG_TITULO" ), 50 ) %></option><%
					objSiteRS.MoveNext
					Loop
					'Fechar Objetos abertos
					objSiteRS.Close
					Set objSiteRS = Nothing
				End If
				%>
                            </select>
                        </div>

    				    <div id="OSCelula" style="display: none;">
	            		    <input type="hidden" name="cmbOs" value="-1"/>
				        </div>

				    </td>
			    </tr>
			    </table>
		    </td>
	    </tr>

        <tr><td>&nbsp;</td></tr>

	    <tr valign="middle">
		    <th colspan="10" align="left">&nbsp;Dados do Arquivo</th>
	    </tr>
	    <tr valign="middle"> 
		    <td colspan="10" align="center"> 
			    <table width="90%">
			    <tr> 
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
				    <td width="10%" height="0"></td>
			    </tr>

			<%if ehValidacao then%>
				    <tr> 
					    <td colspan="5">
						    <b>Data Validação :</b><br>
						    <%call comboData("validacao")%>
					    </td>
					    <td colspan="5">
						    <b>Responsável Validação :</b><br>
						    <%call comboUSERCRTcDefault("validador", Env.oConn, Env.usuario(),false)%>
					    </td>
				    </tr>
			<%end if%>

			    <tr> 
				    <td colspan="10">
					    <b>Tipo de Arquivo:</b><br>
					    <select name="tipoarquivo" onchange="atualizaTipoDoc();sugereNome();">
					    <%call comboBD(Env.oConn,"Select tar_codtipoarquivo as valor,tar_tipoarquivo as descricao from tipoarquivo where tar_codtipoarquivo <> " & Application("SISLAB_id_TipoArquivo_Imagem") & " order by tar_tipoarquivo asc")%>
					    </select>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="10">
					    <b>Título do Link do arquivo:</b><br>
					    <input type="text" name="titulo" size="60" maxlength="200" value="<%= auxlink %>" style="display: block;" />
				    </td>
			    </tr>
			    <tr>
				    <td colspan="10">
					    <b>Nome do arquivo:</b><br>
					    <div id="arqatu">
						    <input type="text" name="nome" size="80" maxlength="90" readonly value="<%=auxnomearq%>">&nbsp;
						    <button onclick="javascript:window.open('muda_arq.asp?ag_numero=<%=auxAS%>&codarq=<%=auxselecao%>&ant=<%=Replace(auxnomearq, "\", "\\")%>', 'muda_arq', 'height=120, width=450, toolbars=1no, directory=1no' );">&nbsp;Alterar&nbsp;</button>&nbsp;&nbsp;
						    <button onclick="javascript:visualizaArquivo();">Visualizar Arquivo</button>
					    </div>
					    <input id="arqcad" TYPE="File" size="60" name="FILE1">
					    <script type="text/javascript">
					    <% if auxselecao = 0 then %>
						    document.all.arqatu.style.display="none";
						    formulario.arqcad.style.display="block";
					    <% else %>
						    document.all.arqatu.style.display="block";
						    formulario.arqcad.style.display="none";
						    function muda_arq( novo )
						    {
							    if( novo != "" )
								    formulario.nome.value = novo;
						    }
					    <% end if %>

						    /* abro uma janela para visualizar o arquivo */
						    function visualizaArquivo() {
							    janelaespecial('arquivos/' + document.all.nome.value);
						    }
					    </script>
				    </td>
			    </tr>
			    <tr> 
				    <td colspan="5">
					    <b> Data de Aprovação do arquivo:</b><br>
					    <select name="diaatualiz" onchange="montaAtualiza()">
						    <option value="">Dia</option><%
								    for i = 1 to 31
									    if i < 10 then
										    auxi = "0" & i
									    else
										    auxi = i
									    end if %>
						    <option value="<%=auxi%>"><%=auxi%></option><%
								    next %>
					    </select>
					    <select name="mesatualiz" onchange="montaAtualiza()">
						    <option value="">Mês</option>
						    <option value=01>Janeiro</option>
						    <option value=02>Fevereiro</option>
						    <option value=03>Março</option>
						    <option value=04>Abril</option>
						    <option value=05>Maio</option>
						    <option value=06>Junho</option>
						    <option value=07>Julho</option>
						    <option value=08>Agosto</option>
						    <option value=09>Setembro</option>
						    <option value=10>Outubro</option>
						    <option value=11>Novembro</option>
						    <option value=12>Dezembro</option>
					    </select>
					    <select name="anoatualiz" onchange="montaAtualiza()">
						    <option value="">Ano</option><%
							    for i = -1 to 5 '-- pego o ano seguinte e 5 anos para trás
								    cbano = year( now ) - i %>
						    <option value="<%=cbano%>"><%=cbano%></option><%
							    next%>
					    </select>
				    </td>
				    <td colspan="1">
					    <b>Revis&atilde;o:</b><br>
					    <input type="text" name="versao" size="5" />
				    </td>
				    <td colspan="3" align="right">
					    <b>Confidencial:</b><br>
				    </td>
				    <td colspan="2">
					    &nbsp;&nbsp;<input type="checkbox" name="chkconfidencial" value="1"><br>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="2" valign="top">
					    <b>Vers&atilde;o do Documento:</b><br>
					    <input type="text" name="o1" value="<%=auxo1%>" maxlength="2" size="2" >&nbsp;.&nbsp;
					    <input type="text" name="o2" value="<%=auxo2%>" maxlength="2" size="2" >&nbsp;.&nbsp;
					    <input type="text" name="o3" value="<%=auxo3%>" maxlength="3" size="3" >
				    </td>
				    <td>&nbsp;</td>

				    <td colspan="2" valign="top">
					    <b>Situa&ccedil;&atilde;o:</b><br>
					    <select name="situacao">
						    <option value="">--</option>
						    <%call comboBD(Env.oConn,"Select SAR_CodSitArquivo as valor,left(SAR_SitArquivo,40) as descricao from situacaoarquivo order by SAR_CodSitArquivo asc;")%>
					    </select>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="10">
					    <b>Responsável:</b><br>
					    <%call comboUSERCRT("responsavel",Env.oConn,false)%>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="5" valign="top">
					    <b>Descri&ccedil;&atilde;o:</b><br>
					    <textarea name="descricao" cols="45" rows="3"><%= auxdescricao %></textarea>
				    </td>
				    <td colspan="5" valign="top">
					    <b>Observa&ccedil;&atilde;o:</b><br>
					    <textarea  name="observacao" cols="45" rows="3"><%= auxobservacao %></textarea>
				    </td>
			    </tr>
			    <tr><td colspan="10">&nbsp;</td></tr>
		        <tr valign="middle">
				    <td colspan="10"> 
					    <input type="submit" name="Submit" value=" Atualizar " />
					    &nbsp;&nbsp;&nbsp;<%
		if auxaltera="Alterar" then %>
    					<input type="button" name="Excluir" value="  Excluir  " onclick="selexcluir();" />
	    				&nbsp;&nbsp;<%
		end if %>
				    </td>
			    </tr>
			    </table>
		    </td>
	    </tr>
    </table>
    </form>

    <iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
</div>


<script type="text/javascript">
    var frm = document.forms[0]
    var	frm1 = document.all;
    <% if auxaltera = "Inserir" then %>
	    document.formulario.Submit.value="  Cadastrar  " ;         
    <% end if %>

    frm.diaatualiz.value="<%=auxdiaatualiz%>";
    frm.mesatualiz.value="<%=auxmesatualiz%>";
    frm.anoatualiz.value="<%=auxanoatualiz%>";
    frm.txtatualiza.value = "<%=auxdiaatualiz%>"+"/"+"<%=auxmesatualiz%>"+"/"+"<%=auxanoatualiz%>";
    //frm.nome.value="<%=auxnomearq%>";
    //document.formulario.orgao.value="<%=auxidorgao%>";
    frm.tipoarquivo.value="<%=auxcodtipo%>";
    frm.versao.value="<%=auxversao%>";
    frm.situacao.value="<%=auxidsituacao%>";

    <% if auxAS <> "" then%>
	    //PreparaCampos()
	    document.getElementById("tabAgendamento").style.display = "block";
	    frm1.cmbAgendamento[0].checked = true;
	    frm.txAS.value = "<%=auxAS%>";
	    BuscaAS();
	    mudaAS2('Os','OS Associada:',frm.txAS.value,'<%=auxOS%>')
    <%else%>
	    document.getElementById("tabAgendamento").style.display = "none";
	    frm1.cmbAgendamento[1].checked = true;
	    //PreparaCampos()
    <%end if%>

    frm.responsavel.value="<%=ucase(auxarqresponsavel)%>"

    <%if auxconfidencial then%>
    frm.chkconfidencial.checked = true;
    <%end if%>

    <%if ehValidacao then%>
	    document.formulario.Submit.value="  Validar  " ;         
	    frm1.cmbAgendamento[1].disabled = true;
	    frm1.cmbAgendamento[0].disabled = true;
	    frm1.tipoarquivo.disabled = true;
	    frm1.titulo.disabled = true;
	    frm1.diaatualiz.disabled = true;
	    frm1.mesatualiz.disabled = true;
	    frm1.anoatualiz.disabled = true;	
	    frm1.o1.disabled = true;	
	    frm1.o2.disabled = true;	
	    frm1.o3.disabled = true;		
	    frm1.situacao.disabled = true;
	    frm1.responsavel.disabled = true;
	    frm1.descricao.disabled = true;
	    frm1.observacao.disabled = true;
	    frm1.chkconfidencial.disabled = true;
	    frm1.versao.disabled = true;

	    frm1.tipoarquivo.style.backgroundColor = "#EEEEEE";	
	    frm1.titulo.style.backgroundColor = "#EEEEEE";	
	    frm1.diaatualiz.style.backgroundColor = "#EEEEEE";	
	    frm1.mesatualiz.style.backgroundColor = "#EEEEEE";	
	    frm1.anoatualiz.style.backgroundColor = "#EEEEEE";	
	    frm1.o1.style.backgroundColor = "#EEEEEE";	
	    frm1.o2.style.backgroundColor = "#EEEEEE";	
	    frm1.o3.style.backgroundColor = "#EEEEEE";	
	    frm1.situacao.style.backgroundColor = "#EEEEEE";	
	    frm1.responsavel.style.backgroundColor = "#EEEEEE";	
	    frm1.descricao.style.backgroundColor = "#EEEEEE";	
	    frm1.observacao.style.backgroundColor = "#EEEEEE";	
	    frm1.chkconfidencial.style.backgroundColor = "#EEEEEE";	
	    frm1.versao.style.backgroundColor = "#EEEEEE";	
    <%end if%>

    function selexcluir() {
	    var frm = document.forms[0]
	    resposta = confirm("Deseja que a exclusão deste arquivo seja comunicado via e-mail aos usuarios CRT?")
	    if (resposta)
		    frm.resp.value = "1";

        frm.tipocomando.value="Excluir";
  	    frm.action = "CadArquivoA.asp";
	    frm.method = "post";
	    frm.target = "";
	    frm.submit();
    }
</script>
<%
Call Tela.MostraRodape()
%>
