<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objSiteRS, sSQL,auxaltera,auxdataauxilio,auxocorrencia,auxselecao,auxcodocorrencia, rs_Temp
Dim auxcadastrado, auxusername,i,auxi,cbhora,cbano,auxconcluidooco, auxtipoocovalor,auxvalor, auxvalordesc, auxEficacia
Dim auxdiaoco,auxanooco,auxmesoco,auxhoraoco,auxminutooco,auxtipooco, auxresponsavel, auxnomeresponsavel
Dim auxdescricaooco, auxdocassociado,auxobservacaooco,auxprovidenciasoco,auxexecutor
Dim lb_crit : lb_crit = null
Dim ehRAT
Dim ehCRT

call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de eventos - Log Book", "location.href='sel_cad_logbook.asp'", "")

Call Env.ArmazenaCaminhoAnterior()

auxusername = Env.usuario
ocorrencia = request("ocorrencia")

ehRAT = env.EhRat()
ehCRT = env.UsuarioCRT()


if Not VVVNZ(ocorrencia) then
	ssql = "select * from LB_LogBook where lb_id = " & ocorrencia
	call Env.RecordSet( true, objSiteRS, sSQL)
	auxcadastrado = objSiteRS("LB_UsernameCad")
else
	auxcadastrado = Env.Usuario
end if
%>

<script type="text/javascript">
    function selexcluir(){
      document.formulario.tipocomando.value="Excluir"	
      document.formulario.submit()
    }

    function isDate(pdata){
	    var dia, mes, ano;
	    var meses = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	    dia = pdata.substr(0, 2);
	    mes = pdata.substr(3, 2);
	    ano = pdata.substr(6, 4);
	    if (ano%4 == 0)
		    meses[1] = 29;
	    return(mes>=1 && mes<=12 && dia>=1 && dia<=meses[mes-1]);
    }

    function volta(){
	    frm.action = "sel_cad_logbook.asp"
	    frm.method = "post";
	    frm.submit();
    }
</script>
<script language="javascript" src="includes/anexo.js"></script>

<div class="margem-10">

<form method="post" action="insCad_evLogBook.asp" name="formulario">
<input type="hidden" name="modo" value="CADASTRAR">
<input type="hidden" name="resp" value="0">
<input type="hidden" name="concluidoGQ" value="0">
<input type="hidden" name="ocorrencia" value="<%=ocorrencia%>">

<table width="100%">
<tr> 
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="7%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="6%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="17%" height="0"></td>
</tr>
<tr> 
	<td colspan="10">
		<strong>
			&nbsp;&nbsp;<span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório
		</strong>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr> 
	<td colspan="3">
			<span class="texto-vermelho-bold">*</span>&nbsp; Data da Ocorrência:
        <br>
		<%call comboData("ocorrencia")%>
	</td>
	<td colspan="3">
			<span class="texto-vermelho-bold">*</span>&nbsp; Hora da Ocorrência:
		<br>
		<%call comboHorario("ocorrencia")%>
	</td>
	<td colspan="<%if ocorrencia <> "" then response.write 2 else response.write 5 end if%>" >
		Cadastrado por:&nbsp;<br>
<%		If ehRAT And VVVNZ(ocorrencia) Then
			Call comboUSERCRTVIVOEMORTOSSomenteID("hdusername", Env.oConn, auxcadastrado, "N")
		Else
%>		&nbsp;&nbsp;&nbsp;&nbsp;<%=auxcadastrado%>
		<input type="hidden" name="hdusername" value="<%=auxcadastrado%>">
<%		End If%>
	</td>
		<%if ocorrencia <> "" then%>
		<td colspan="2" >
			Número da Ocorrência:<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=ocorrencia%>
		</td>
		<%end if%>
</tr>

<tr valign="middle"> 
	<td colspan="10">
		<span class="texto-vermelho-bold">*</span>&nbsp;Descrição de ocorrência:<br>
		<textarea name="descricao" cols="140" rows="4"></textarea>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10">
		Observações:<br>
		<textarea name="observacoes" cols="140" rows="4"></textarea>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10">
		Ação imediata já tomada:<br>
		<textarea name="providencias" cols="140" rows="4"></textarea>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10">
		Colaboradoes Associados / Ocorrência:&nbsp;<br>
		<textarea name="executor" cols="140" rows="4"></textarea>
	</td>
</tr>
<% if ehRAT or ocorrencia <> "" then%>
<tr><td>&nbsp;</td></tr>
<tr valign="middle">
    <td colspan="10">
		<strong>Área de Controle do RAT</strong>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10" >
		<span class="texto-vermelho-bold">*</span>&nbsp;RAT:
		<%
		'>> Nova ocorrencia
		If VVVNZ(Ocorrencia) Then
			call comboRat("ratResponsavel",Env.oConn,"N")
		Else
			call comboRatTodos("ratResponsavel",Env.oConn,"N")
		End If
		%>
	</td>
</tr>
<tr valign="middle">
	<td colspan="5">
		<span class="texto-vermelho-bold">*</span>&nbsp;Tipo da ocorrência:
		&nbsp;
		<%call comboBDSQL( "tipoOcorrencia", Env.oConn,"select LBTO_ID AS VALOR,lBTO_DESCRICAO AS DESCRICAO from LB_TipoOcorrencia", "", "N")%>
	</td>
	<td colspan="5">
		<span class="texto-vermelho-bold">*</span>&nbsp;Prazo Solicitado p/ Resolução:
		<input name="prazo" size="4" onKeyPRess="onlynum(this)"> (em dias)
	</td>
</tr>
<tr valign="middle">
	<td colspan="5">
		Responsável pela Ocorrência:&nbsp;
		<%
		'>> Nova ocorrencia
		If VVVNZ(Ocorrencia) Then
			call comboUSERCRT("responsavel",Env.oConn,"N")
		Else
			call comboUserCRTVivoEMortos("responsavel",Env.oConn,"N")
		End If
		%>
	</td>
	<td colspan="5">
		Criticidade:
		&nbsp;
		<%call comboCriticidade("lb_criticidade")%>
	</td>
</tr>
<tr>
	<td colspan="10">
		Análise das Causas:<br>
		<textarea name="analisegq" cols="140" rows="4"></textarea>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10">
		Requisito da Norma ou Documento Associado :<br>
		<textarea name="norma" cols="140" rows="4"></textarea>
	</td></tr>
<tr valign="middle"> 
	<td colspan="10">
		Observações :<br>
		<textarea name="observacoesgq" cols="140" rows="4"></textarea>
	</td>
</tr>
<tr valign="middle"> 
	<td colspan="10">
		É uma Oportunidade de Melhoria: <input type="Checkbox" name="chkOPM">
	</td></tr>

<tr valign="middle"> 
	<td colspan="5">
		Ações Tomadas:<br>
	<td colspan="5" align="right">
		<%if ehRat then%>
			<input type="button" name="btAcao" value="Tomar Nova Ação" onClick="NovaAcao()">
		<%end if%>
		&nbsp;&nbsp;
	</td>
</tr>
<tr>
	<td colspan="10">
		<table width="100%">
		<tr>
			<td width="10px">&nbsp;</td>
			<td>
				<div class="largura-total" style="height:90px; border: solid thin silver; marginheight:0; marginwidth:0;">
				<iframe id="frame_LB_acao" width="100%" height="90px" vspace="0" hspace="0" marginheight="0" marginwidth="0" src="cad_evLogBookAcoes.asp?ocorrencia=<%=ocorrencia%>"  frameborder="0" scrolling="Auto"></iframe>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>


<tr valign="middle"> 
	<td colspan="10" >
		Ocorrência Finalizada : <input type="Checkbox" name="chkConcGQ" onclick="mudaDataFim()">
		<br>Data e Hora da Finalização: <%call comboData("dtFim")%>&nbsp;&nbsp;&nbsp;<%call comboHorario("dtFim")%>
	</td>
</tr>
<%end if%>
<tr valign="middle" height=45>
		<td colspan="10">
			&nbsp;
			<%if ocorrencia = "" and not ehRat then%>
				<input type="button" onClick="ValidaCampos()" name="bt" value="&nbsp;Cadastra&nbsp;" />
			<%elseif ocorrencia <> "" and not ehRat then%>
				<input type="button" onClick="volta()" name="bt" value="&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;" />
			<%elseif ehRat then%>
				<input type="button" onClick="document.forms[0].concluidoGQ.value='1';ValidaCampos()" name="bt" value="Salvar Ocorrência" />
			<%end if%>
		</td>
	</tr>
</table>
</form>
<br>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
</div>

<script type="text/javascript">
    var str;

    function ValidaCampos(){
	    var frm = document.forms[0]

	    if (!(isDate(frm.diaocorrencia.value+"/"+frm.mesocorrencia.value+"/"+frm.anoocorrencia.value))){
		    alert("A data de ocorrência deve ser uma uma data válida.");
		    formulario.diaocorrencia.focus();
		    return false;
	    }

	    if ((frm.horaocorrencia.value=="")||(frm.minutoocorrencia.value=="")){
		    alert("Hora e/ou minuto da ocorrência não informada.\nInforme a Hora/minuto da ocorrência.");
	        frm.horaocorrencia.focus();
		    return false;
	    }

	    if (AchaAspas(frm.descricao.value))	{
		    alert("Descrição da ocorrência não pode conter Aspas ou apóstrofes.\nCorrija a descrição da ocorrência.");
	        frm.descricao.focus();
		    return false;
	    }

	    if (frm.descricao.value==""){
		    alert("Descrição da ocorrência não informada.\nInforme a descrição da ocorrência.");
	        frm.descricao.focus();
		    return false;
	    }

	    if (AchaAspas(frm.observacoes.value)){
		    alert("Observações não podem conter Aspas ou apóstrofes.\nCorrija as Observações da ocorrência.");
	        frm.observacoes.focus();
		    return false;
	    }

	    if (AchaAspas(frm.providencias.value)){
		    alert("Providências não podem conter Aspas ou apóstrofes.\nCorrija as Providências da ocorrência.");
	        frm.providencias.focus();
		    return false;
	    }

 	    <%if ehRat then%>
	    if (frm.tipoOcorrencia.value==""){
		    alert("Tipo da ocorrência não informada.\nInforme o tipo da ocorrência.");
	        frm.tipoOcorrencia.focus();
		    return false;
	    }

	    if (frm.prazo.value==""){
		    alert("Prazo não informado.\nInforme o prazo da ocorrência.");
	        frm.prazo.focus();
		    return false;
	    }

	    //cria o str de acoes
	    if(frm.chkOPM.checked == false){	
		    if(frm.chkConcGQ.checked == true){
			    if (!(isDate(frm.diadtFim.value+"/"+frm.mesdtFim.value+"/"+frm.anodtFim.value))){
				    alert("A data da finalização da ocorrência deve ser uma uma data válida.");
				    formulario.diadtFim.focus();
				    return false;
			    }
	
			    if ((frm.horadtFim.value=="")||(frm.minutodtFim.value=="")){
				    alert("Hora e/ou minuto da finalização da ocorrência não informada.");
	    		    frm.horadtFim.focus();
				    return false;
			    }
		    }
	    }
	    <%end if%>

	    resposta = confirm("Deseja que este cadastro comunique via e-mail os responsáveis pelo logbook?");
	    if (resposta) {
		    frm.resp.value = "1";
	    }
	    frm.submit();
    }
    <%if ehRat then%>
    function mudaDataFim(){
	    var frm = document.forms[0];	
	    if(frm.chkConcGQ.checked == true){
		    frm.diadtFim.disabled = false;
		    frm.mesdtFim.disabled = false;
		    frm.anodtFim.disabled = false;

		    frm.horadtFim.disabled = false;
		    frm.minutodtFim.disabled = false;

	    }
	    else{
		    frm.diadtFim.disabled = true;
		    frm.mesdtFim.disabled = true;
		    frm.anodtFim.disabled = true;

		    frm.horadtFim.disabled = true;
		    frm.minutodtFim.disabled = true;
	    }
    }

    <%end if%>

    function NovaAcao(){
	    if('<%=ocorrencia%>' == '') {
		    alert('ATENÇÃO !\n\nPara criar uma nova ação é necessário salvar os dados\ndesta nova ocorrência.');
	    }
	    else {
		    var janela;
		    janela = window.open("CAD_acLogBook.asp?acao=cadastrar&ocorrencia=<%=ocorrencia%>", "cad_contato", "width=600, height=410, toolbar=no, status=yes, menubar=no, scrollbars=auto");
		    janela.focus();
	    }
    }


    var frm = document.forms[0]
    frm.diaocorrencia.value='<%=itoa(day(date()),2)%>';
    frm.mesocorrencia.value='<%=itoa(month(date()),2)%>';
    frm.anoocorrencia.value='<%=year(date())%>';

    <%If ehRat THEN%>
	    frm.diadtFim.disabled = true;
	    frm.mesdtFim.disabled = true;
	    frm.anodtFim.disabled = true;

	    frm.horadtFim.disabled = true;
	    frm.minutodtFim.disabled = true;
    <%end if%>
    <%
    if ocorrencia <> "" then
    %>
	    frm.modo.value = "ALTERAR"
	    frm.descricao.value = "<%=replace(objSiteRS("lb_descricao") & "",vbcrlf,"\n")%>"
	    frm.executor.value = "<%=replace(objSiteRS("lb_executor") & "",vbcrlf,"\n")%>"
	    frm.providencias.value = "<%=replace(objSiteRS("lb_providencias") & "",vbcrlf,"\n")%>"
	    frm.observacoes.value = "<%=replace(objSiteRS("lb_observacao") & "",vbcrlf,"\n")%>"
	    frm.horaocorrencia.value = "<%=itoa(HOUR(objSiteRS("LB_DATAHORAOCO")),2)%>"
	    frm.minutoocorrencia.value = "<%=itoa(MINUTE(objSiteRS("LB_DATAHORAOCO")),2)%>"
	    frm.diaocorrencia.value = "<%=itoa(DAY(objSiteRS("LB_DATAHORAOCO")),2)%>"
	    frm.mesocorrencia.value = "<%=itoa(MONTH(objSiteRS("LB_DATAHORAOCO")),2)%>"
	    frm.anoocorrencia.value = "<%=YEAR(objSiteRS("LB_DATAHORAOCO"))%>"
	    frm.lb_criticidade.value = "<%=objSiteRS("LB_CRITICIDADE")%>"
	    <%IF objSiteRS("LB_CONCLUIDOGQ") THEN%>
		    frm.chkConcGQ.checked = true;
		    frm.horadtFim.value = "<%=itoa(HOUR(objSiteRS("LB_DATAHORACONCLUSAO")),2)%>";
		    frm.minutodtFim.value = "<%=itoa(MINUTE(objSiteRS("LB_DATAHORACONCLUSAO")),2)%>";
		    frm.diadtFim.value = "<%=itoa(DAY(objSiteRS("LB_DATAHORACONCLUSAO")),2)%>";
		    frm.mesdtFim.value = "<%=itoa(MONTH(objSiteRS("LB_DATAHORACONCLUSAO")),2)%>";
		    frm.anodtFim.value = "<%=itoa(YEAR(objSiteRS("LB_DATAHORACONCLUSAO")),4)%>";

		    frm.diadtFim.disabled = false;
		    frm.mesdtFim.disabled = false;
		    frm.anodtFim.disabled = false;
		    frm.horadtFim.disabled = false;
		    frm.minutodtFim.disabled = false;

	    <%END IF%>


	    <%IF objSiteRS("LB_OPM") THEN%>frm.chkOPM.checked = true;<%END IF%>
	    frm.tipoOcorrencia.value = "<%=objSiteRS("lbto_id")%>"
	    frm.responsavel.value = "<%=ucase(objSiteRS("LB_RESPEXEC"))%>"
	    <%IF objSiteRS("LB_RATRESPONSAVEL") & "" = "" THEN%>
		    frm.ratResponsavel.value='<%=UCASE(Env.Usuario)%>';	
	    <%else%>
		    frm.ratResponsavel.value='<%=UCASE(objSiteRS("LB_RATRESPONSAVEL"))%>';	
	    <%END IF%>
	    frm.norma.value = "<%=replace(objSiteRS("LB_REQUISITONORMA") & "",vbcrlf,"\n")%>"
	    frm.analisegq.value = "<%=replace(objSiteRS("LB_ANALISEGQ") & "",vbcrlf,"\n")%>"
	    frm.observacoesgq.value = "<%=replace(objSiteRS("LB_OBSERVACOESGQ") & "",vbcrlf,"\n")%>"
	    frm.prazo.value = "<%=objSiteRS("LB_PRAZO")%>"
    <%
    end if%>

    <%if (not ehRAT) and ocorrencia <> "" then%>
	    frm.norma.disabled = true;
	    frm.ratResponsavel.disabled = true;
	    frm.analisegq.disabled = true;
	    frm.observacoesgq.disabled = true;
	    frm.ratResponsavel.style.backgroundColor = "#EEEEEE";
	    frm.norma.style.backgroundColor = "#EEEEEE";	
	    frm.analisegq.style.backgroundColor = "#EEEEEE";	
	    frm.observacoesgq.style.backgroundColor = "#EEEEEE";			
	    frm.prazo.disabled = true;
	    frm.prazo.style.backgroundColor = "#EEEEEE";		
	    frm.tipoOcorrencia.disabled = true;
	    frm.tipoOcorrencia.style.backgroundColor = "#EEEEEE";	
	    frm.responsavel.disabled = true;
	    frm.responsavel.style.backgroundColor = "#EEEEEE";	
	    frm.chkOPM.disabled = true;
	    frm.chkConcGQ.disabled = true;

	    frm.diadtFim.disabled = true;
	    frm.mesdtFim.disabled = true;
	    frm.anodtFim.disabled = true;
	    frm.horadtFim.disabled = true;
	    frm.minutodtFim.disabled = true;

	
	    frm.lb_criticidade.disabled = true;
	    frm.lb_criticidade.style.backgroundColor = "#EEEEEE";	
	    frm.executor.disabled = true;
	    frm.executor.style.backgroundColor = "#EEEEEE";	
	    frm.providencias.disabled = true;
	    frm.providencias.style.backgroundColor = "#EEEEEE";	
	    frm.observacoes.disabled = true;
	    frm.observacoes.style.backgroundColor = "#EEEEEE";	
	    frm.descricao.style.backgroundColor = "#EEEEEE";	
	    frm.descricao.disabled = true;
	    frm.horaocorrencia.disabled = true;
	    frm.minutoocorrencia.disabled = true;
	    frm.diaocorrencia.disabled = true;
	    frm.mesocorrencia.disabled = true;
	    frm.anoocorrencia.disabled = true;
    <%end if%>
</script>
<%
Call Tela.MostraRodape()
%>