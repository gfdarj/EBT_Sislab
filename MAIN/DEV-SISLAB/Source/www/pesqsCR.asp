<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/emailHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim RS, objRS, cont, sSQL, auxusername, objRS_Servico
Dim auxidservico, auxag, auxnome, auxOrgao, chr_NomeReduzido
Dim auxRamal, matricula, rst, obj1, linkVoltar, auxEmail
Dim	com_comunica
Dim solicitante_procurado
Dim	com_cortesia
Dim com_presteza
Dim com_flexibilidade
Dim com_rapidez
Dim com_iniciativa
Dim com_confiabilidade
Dim com_infraestrutura
Dim com_ambiente
Dim com_acesso
Dim com_geral
Dim comenta_adicionais
Dim comenta_outros
Dim bln_ExistePesquisa
'### Pega os status do usuario
Dim ehRat : ehRat = Env.EhRAT
Dim ehRT : ehRT = Env.EhRT
Dim EhGQ : EhGQ= Env.EhGQ
Dim ehCrt : ehCrt = Env.UsuarioCRT

'###
Dim data_pesquisa : data_pesquisa = Right("0"&day(date()),2) & "/" & Right("0"&month(date()),2) & "/" & year(date()) & " " & Right("0"&Hour(Now),2) & ":" & Right("0"&Minute(Now),2)

Dim Ebt
Set Ebt = New TEbt


bln_ExistePesquisa = False

auxidservico = 0
auxusername = Env.Usuario
auxEmail = Env.Usuario
auxag = ""

auxag = Request("num_ag")

'debug dos tipos de usuario que acessam esta pagina
''''ehRat = False : ehRT = False : EhGQ = False : ehCrt = False : auxusername = "ANIEXP"

if request("emjanela") = "1" then
	Call Tela.ImprimeCabecalho2("", MENU_OFF, false, "100%", "Pesquisa de Satisfação do CRT", "SO_IMPRESSORA", "")
else
	If EhRAT Then
		If Request.form("num_ag") <> "" Then
			linkVoltar = "location.href='pesqsCR.asp'"
		Else
			linkVoltar = "location.href='index.asp'"
		End If
	Else
		linkVoltar = "location.href='index.asp'"
	End If

	Call Tela.ImprimeCabecalho2("", MENU_ON, true, "", "Pesquisa de Satisfação - CRT", linkVoltar, "")
end if


'-- se nao tem agendamento, tenho que selecionar um
If VVVNZ(auxag) Then

	sSQL = _
		"SELECT a.* " & _
		"FROM vw_Agendamento a " & _
		"LEFT JOIN PesquisaSatisfacao p ON p.PSQ_NAg = a.AG_NUMERO " & _
		"WHERE ID_SITUACAO = " & AS_Finalizado & " "

	'### Filtros de quem é o usuario entrando na pagina
	If Not ehCRT Then
		sSQL = sSQL & "and AG_USERNAME = '" & auxusername & "' "
        solicitante_procurado = auxusername
    Else
	    If Not VVVN(RQ("solicitante")) Then
		    sSQL = sSQL & "and AG_USERNAME = '" & RQ("solicitante") & "' "
	    End If
        solicitante_procurado = RQ("solicitante")
	End If
	If RQ("exibir") = "" Then
		sSQL = sSQL & "and p.PSQ_NAg IS NULL "
	End If
	If RQ("exibir") = "R" Then
		sSQL = sSQL & "and p.PSQ_NAg IS NOT NULL "
	End If

	sSQL = sSQL & "ORDER BY a.AG_NUMERO desc"
'RW ssql & "<BR><BR>" & ehCRT & " <---> " & RQ("solicitante")
'RE
	Call Env.RecordSet(true, objRS, sSQL)

	'### escolher multiplos itens se forem agendamentos sem resposta !!!
%>
<div class="margem-10">
    <form name="formulario" method="post" >
    <p><b>Selecione um ou mais agendamento(s):</b><%=IIf(VVVN(RQ("exibir")), "&nbsp;<i>(Para selecionar mais de um agendamento utilize a tecla <u>Shift</u> ou <u>Ctrl</u>)</i>", "")%></p>
    <p><select <%=IIf(VVVN(RQ("exibir")), "multiple", "")%> name="num_ag"  size="15" style="width: 700px;">
<%	while not objRS.Eof%>
        <option value="<%=objRS("AG_NUMERO")%>"><%=objRS("AG_NUMERO")%> (<%=UCase(objRS("AG_USERNAME"))%>) - <%=left(objRS("AG_OBJETIVO"),100)%></option>
<%		objRS.MoveNext
	wend%>
    </select></p>
    <p>
	    <b>Exibir:</b>&nbsp;<select name="exibir"  onchange="javascript:trocaAS();">
	    <option value="" <%=IIf(VVVN(RQ("exibir")), "selected", "")%>>Somente Agendamentos sem Respostas</option>
	    <option value="T" <%=IIf(RQ("exibir") = "T", "selected", "")%>>Todos os Agendamentos</option>
	    <option value="R" <%=IIf(RQ("exibir") = "R", "selected", "")%>>Somente Agendamentos com Respostas</option>
	    </select>
<%	If ehCRT Then
		sSQL = "SELECT DISTINCT AG_USERNAME " & _
			"FROM vw_Agendamento a " & _
			"LEFT JOIN PesquisaSatisfacao p ON p.PSQ_NAg = a.AG_NUMERO " & _
			"WHERE ID_SITUACAO = " & AS_Finalizado & " "

		If (not ehRAT) Or (ehCRT And RQ("exibir") = "") Then sSQL = sSQL & "and p.PSQ_NAg IS NULL "
		If ehCRT And RQ("exibir") = "R" Then sSQL = sSQL & "and p.PSQ_NAg IS NOT NULL "

		sSQL = sSQL & "ORDER BY AG_USERNAME"

		Call Env.RecordSet(true, objRS, sSQL)

		If Not objRS.Eof Then 
%>
	    &nbsp;&nbsp;&nbsp;
	    <b>Exibir Solicitante:</b>
	    <select name="solicitante"  onchange="javascript:trocaAS();">
	    <option value="">Todos os Solicitantes</option>
	    <option value="--">-----------------------</option>
	    <option value="<%=Env.Usuario%>" selected><%=Env.Usuario%></option>
	    <option value="--">-----------------------</option>
<%			While Not objRS.Eof
                Call Ebt.LoginUsuario(objRS("AG_USERNAME"))

				If objRS("AG_USERNAME") <> Env.Usuario Then %>
    	<option value="<%=objRS("AG_USERNAME")%>" <%=IIf(RQ("solicitante") = objRS("AG_USERNAME"), "selected", "")%>><%=objRS("AG_USERNAME") & IIf(VVVN(Ebt.NomeReduzido), "", " - " & Ebt.NomeReduzido)%></option>
<%				End If

				objRS.MoveNext
			WEnd %>
	    </select>
        <script type="text/javascript" language="javascript">
            document.all.solicitante.value = '<%=solicitante_procurado%>';
        </script>
<%
		End If
	Else %>
    	<input type="hidden" name="solicitante" value="<%=auxusername%>">
<%	End If '### EhCRT %>
    </p>
    <p><input type="button"  value="Ver Formulário" onclick="javascript:/*showAguarde();*/ enviaAS();"></p>
    </form>
</div>

<script type="text/javascript">
    function trocaAS()
	{
		var f = document.formulario;
		if (f.solicitante.value != '--')
		{
			location.href = 'pesqscr.asp?exibir=' + f.exibir.value + '&solicitante=' + f.solicitante.value;
		}
	}
	function enviaAS() {
		var i;
		var valor = document.formulario.num_ag;
		var sel = false;
		for(i=0; i<valor.length; i++) {
			if(valor.options[i].selected)
			{
				sel = true;
				break;
			}
		}
		if (sel)
			document.formulario.submit();
		else
			alert('Selecione pelo menos um agendamento');
	}
</script>
<%
	Call Env.RecordSet(false, objRS, sSQL)

Else
	'##############################################################################################
	'### Processa a exibicao e monta o formulario de pesquisa de satisfacao
	'##############################################################################################
	Dim arrAG : arrAG = Split(auxag)
	Dim ta_descricao : ta_descricao = ""
	Dim ag_solicitante : ag_solicitante = ""

	'### Pega os dados do(s) agendamento(s) e verifica se sao AS´s do mesmo solicitante ###
	sSQL = _
		"SELECT AG_NUMERO, TA_DESCRICAO, TEC_NOME, AG_USERNAME " & _
		"FROM vw_Agendamento a " & _
		"WHERE AG_NUMERO IN (" & auxag & ")"
	Call Env.RecordSet(True, RS, sSQL)

	ag_solicitante = IIf(RS.Eof, "", RS("AG_USERNAME"))

	ta_descricao = "<table border='0' class='texto1' width='100%'>"
	ta_descricao = ta_descricao & _
		"<td colspan='2'><span style='font-size:12px;'>1.1 Serviço Utilizado</span></td>" & _
		"<td><span style='font-size:12px;'>1.2 Tecnologia Empregada</span></td>"

	While Not RS.Eof
		ta_descricao = ta_descricao & _
			"<tr><td width='10%' align='center'>" & IIf(UBound(arrAG)=0, "&nbsp;", "<font color='Navy'><b>AS " & RS("AG_NUMERO") & "</b></font>") & "</td><td width='40%'>" & RS("TA_DESCRICAO") & "</td><td width='50%'>" & RS("TEC_NOME") & "</td></tr>"

		RS.MoveNext

		'### Nao deixa prosseguir se os solicitantes forem diferentes
		If Not RS.Eof Then
			If UCase(ag_solicitante) <> UCase(RS("AG_USERNAME")) Then
				Call MensagemSolicitantesInvalidos()
				Call Tela.MostraRodape()
				Response.End
			End If
		End If
	WEnd

	ta_descricao = ta_descricao & "</table>"

	Call Env.RecordSet(False, RS, Null)


	'### Verifica se existe a pesquisa no banco de dados
	sSQL = "SELECT TOP 1 * FROM PesquisaSatisfacao WHERE PSQ_NAg IN (" & auxag & ")"
	Call Env.RecordSet(true, objRS_Pesq, sSQL)

	If Not (objRS_Pesq.Eof and objRS_Pesq.Bof) Then
		com_comunica = objRS_Pesq("PSQ_C1")
		com_cortesia = objRS_Pesq("PSQ_C2")
		com_presteza = objRS_Pesq("PSQ_C3")
		com_flexibilidade = objRS_Pesq("PSQ_C4")
		com_rapidez = objRS_Pesq("PSQ_C5")
		com_iniciativa = objRS_Pesq("PSQ_C6")
		com_confiabilidade = objRS_Pesq("PSQ_C7")
		com_infraestrutura = objRS_Pesq("PSQ_C8")
		com_ambiente = objRS_Pesq("PSQ_C9")
		com_acesso = objRS_Pesq("PSQ_C10")
		com_geral = objRS_Pesq("PSQ_C11")
		comenta_adicionais = objRS_Pesq("PSQ_C_3")
		comenta_outros = objRS_Pesq("PSQ_C_4")
		data_pesquisa = objRS_Pesq("PSQ_DataHoraCadastro")
		data_pesquisa = Right("0"&day(objRS_Pesq("PSQ_DataHoraCadastro")),2) & "/" & Right("0"&month(objRS_Pesq("PSQ_DataHoraCadastro")),2) & "/" & year(objRS_Pesq("PSQ_DataHoraCadastro")) & " " & Right("0"&Hour(objRS_Pesq("PSQ_DataHoraCadastro")),2) & ":" & Right("0"&Minute(objRS_Pesq("PSQ_DataHoraCadastro")),2)

		Matricula = objRS_Pesq("PSQ_C11")
		auxnome = objRS_Pesq("PSQ_Nome")
		auxOrgao = objRS_Pesq("PSQ_OrgaoEmpresa")
		auxRamal = objRS_Pesq("PSQ_Telefone")
		auxEmail = objRS_Pesq("PSQ_Email")
		auxusername = objRS_Pesq("PSQ_UsernameCadastro")

		bln_ExistePesquisa = True

	Else
        Call Ebt.LoginUsuario(ag_solicitante)

		auxusername = ag_solicitante
		auxEmail = ag_solicitante
		Matricula = Ebt.Matricula()
		auxnome = Ebt.NomeReduzido
		auxOrgao = Ebt.SiglaOrgao()
		auxRamal = Ebt.Ramal()
	End If
%>
<script language="javascript" src="includes/anexo.js"></script>
<form name="formulario" method="POST">
<input type="hidden" name="ag_numero" value="<%=auxag%>">
<input type="hidden" name="vDataEmissao" value="25.06.99"><input type="hidden" name="vEmitente" value="EOP-31"><input type="hidden" name="vRamalEmitente" value="6067"><div align="center">
<input type="hidden" name="userId" value="<%=trim(mid(Request.ServerVariables("REMOTE_USER"),10))%>">
<input type="hidden" name="IP" value="<%=Request.ServerVariables("REMOTE_ADDR")%>">
<input type="hidden" name="Hora" value="<%=time()%>">
<input type="hidden" name="Data" value="<%=Right("0"&day(date()),2) & "/" & Right("0"&month(date()),2) & "/" & year(date())%>">
<input type="hidden" name="pesqID" value="">

<p align="left" style="font-size: 12px;">
	Pesquisa do Grau de Satisfação com o Serviço do <%=Env.nomeCRT%> (<%=Env.siglaCRT%>)
</p>

<table border="0" width="100%" cellpadding="2" class="table-bordered">
<tr class="azul1Bg" style="font-size: 12px;">
	<td><span class="azul3b"><b>AS</b></span><br>
		<%=auxag%>
	</td>
	<td><span class="azul3b"><b>Resp. Pesquisa</b></span><br>
		<%=auxnome%>
	</td>
	<td><span class="azul3b">Ramal</span><br>
		<%=auxRamal%>
	</td>
	<td><span class="azul3b">E-mail</span><br>
		<%=auxEmail%>
	</td>
	<td><span class="azul3b">Data da Pesquisa</span><br>
		<%=data_pesquisa%>
	</td>
</tr>
</table>

<p align="center" class="texto-vermelho-bold" style="font-size: 12px;" id="p_aviso">
	<b>Lembre-se: </b>Sua opinião é fundamental para promover a melhoria dos Nossos Processos.
</p>

<table border="0" cellpadding="2" width="100%" class="table-bordered">
<tr>
	<th align="left" colspan="2">1. Perfil de Utilização</th>
</tr>
<tr>
	<td valign="top" width="100%" colspan="2">
		<%=ta_descricao%>
	</td>
</tr>
</table>

<table border="0" width="100%" cellspacing="3" cellpadding="3" class="table-bordered">
<tr>
	<th colspan="2" align="left">2. Por Favor, assinale a opção que melhor representa seu grau de satisfação/insatisfação em relação aos
		aspectos relacionados ao serviço pesquisado, indicando, se desejar comentários
	</th>
</tr>
<tr>
	<td width="100%" valign="middle" colspan="2" style="font-size:12px;">
		2.1 Facilidade de Comunicação (meios de acesso) com a área responsável pela atividade
	</td>
</tr>
	<%Call TR_Opcoes("comunica", "com_comunica", com_comunica)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.2 Atenção e cortesia das pessoas</td>
</tr>
	<%Call TR_Opcoes("cortesia", "com_cortesia", com_cortesia)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.3 Interesse em atender a sua solicitação</td>
</tr>
	<%Call TR_Opcoes("presteza", "com_presteza", com_presteza)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.4 Flexibilidade no atendimento e execução</td>
</tr>
	<%Call TR_Opcoes("flexibilidade", "com_flexibilidade", com_flexibilidade)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.5 Atendimento no prazo combinado</td>
</tr>
	<%Call TR_Opcoes("rapidez", "com_rapidez", com_rapidez)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.6 Iniciativa / pró-atividade</td>
</tr>
	<%Call TR_Opcoes("iniciativa", "com_iniciativa", com_iniciativa)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2"  style="font-size:12px;">2.7 Exatidão e confiabilidade no serviço</td>
</tr>
	<%Call TR_Opcoes("confiabilidade", "com_confiabilidade", com_confiabilidade)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.8 Infra-estrutura do Laboratório</td>
</tr>
	<%Call TR_Opcoes("infraestrutura", "com_infraestrutura", com_infraestrutura)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.9 Ambiente do Centro de Referência Tecnológica (Salas de Apoio, Refeição, Nível de Ruído, Bem-estar no ambiente...)</td>
</tr>
	<%Call TR_Opcoes("ambiente", "com_ambiente", com_ambiente)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.10 Facilidade de Acesso ao Centro de Referência Tecnológica</td>
</tr>
	<%Call TR_Opcoes("acesso", "com_acesso", com_acesso)%>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td colspan="2" style="font-size:12px;">2.11 Seu grau de satisfação geral com os serviços do Centro de Referência Tecnológica</td>
</tr>
	<%Call TR_Opcoes("geral", "com_geral", com_geral)%>
</table>

<br>

<table border="0" cellpadding="2" width="100%" class="table-bordered">
<tr>
	<th align="left">3. Observações e sugestões adicionais relativas aos ítens/serviço acima</th>
</tr>
<tr>
	<td valign="top">
		<textarea  rows="9" name="comenta_adicionais" cols="120"><%=comenta_adicionais%></textarea>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<th align="left">4. Observações e sugestões sobre outros aspectos de nossa área/nossos serviços que não foram abordados acima</th>
</tr>
<tr>
	<td valign="top">
		<textarea  rows="9" name="comenta_outros" cols="120"><%=comenta_outros%></textarea>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<th align="left">5. Respondido por</th>
</tr>
<tr>
	<td valign="top">
		<blockquote><p>
			<input type=radio name="opttipousu" value="E">Empregado <%=Application("SISLAB_NOME_EMPRESA")%> ou Unidade de Negócios<br>
			<input type=radio name="opttipousu" value="V">Visitante Externo<br>
		</blockquote>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<th align="left">6. Dados opcionais</th>
</tr>
<tr>
	<td>
		<table  border="0" width="100%" cellpadding="2" class="table-bordered">
		<tr>
			<td>
				Responsável<br>
				<input  type="text" name="fNome" size="35">
			</td>
			<td>
				Username<br>
				<input  type="text" name="fUsername" size="15">
			</td>
			<td>
				Telefone<br>
				<input  type="text" name="fRamal" size="12">
			</td>
			<td>
				E-mail<br>
				<input  type="text" name="fEMail" size="30">
			</td>
			<td>
				Órgão ou Empresa<br>
				<input  type="text" name="fOrgao" size="15">
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<p align="center" id="p_conifrmaResposta">
<%
If bln_ExistePesquisa And (Not ehRAT) Then%>
	<input type="button" class='texto1' value="Voltar ao início" name="btnConfirma" onclick="javascript:location.href='index.asp';">
<%
Else%>
	<input type="button" class='texto1' value="Confirmar Respostas" name="btnConfirma" onclick="javascript:Confirma();">
<%
End If
%>
</p>
</form>

<script type="text/javascript">
function taPreenchido(obj) {
	var i;
	for(i=0; i<5; i++) {
		if(obj(i).checked) return true;
	}
	return false;
}

function Confirma()
{
	selec=0;

	if (!(formulario.opttipousu(0).checked)&!(formulario.opttipousu(1).checked)) {
		alert('Campo "Respondido por" não preenchido (opções: Empregado EBT, visitante externo....)');
		formulario.opttipousu(0).focus();
	}
	else if (!taPreenchido(formulario.comunica)) {
		alert('Comunicação não foi indicada');
		formulario.comunica(0).focus();
	}
	else if (!taPreenchido(formulario.cortesia)) {
		alert('Cortezia não fo indicada');
		formulario.cortesia(0).focus();
	}
	else if (!taPreenchido(formulario.presteza)) {
		alert('Presteza não foi indicada');
		formulario.presteza(0).focus();
	}
	else if (!taPreenchido(formulario.flexibilidade)) {
		alert('Flexibilidade não foi indicada');
		formulario.flexibilidade(0).focus();
	}
	else if (!taPreenchido(formulario.iniciativa)) {
		alert('Iniciativa não foi indicada');
		formulario.iniciativa(0).focus();
	}
	else if (!taPreenchido(formulario.confiabilidade)) {
		alert('Confiabilidade não foi indicada');
		formulario.confiabilidade(0).focus();
	}
	else if (!taPreenchido(formulario.infraestrutura)) {
		alert('Infraestrutura não foi indicado');
		formulario.infraestrutura(0).focus();
	}
	else if (!taPreenchido(formulario.ambiente)) {
		alert('Ambiente nao foi indicado');
		formulario.ambiente(0).focus();
	}
	else if (!taPreenchido(formulario.acesso)) {
		alert('Acesso não foi indicado');
		formulario.acesso(0).focus();
	}
	else if (!taPreenchido(formulario.geral)) {
		alert('Avaliação geral nao foi indicada');
		formulario.geral(0).focus();
	}
	else { 
<%	'-- se tiver agendamento tenho que habilitar o campo para dar submit
	if auxag <> "" then%>
		desabilitaUserinfo(false);<%
	end if%>
		document.formulario.action = 'inscad_PesqsCR.asp';
		document.formulario.submit();
	}
}
<%
	if not (objRS_Pesq.Eof and objRS_Pesq.Bof) then
%>
	document.formulario.pesqID.value = '<%=objRS_Pesq("PSQ_Id")%>';
	document.formulario.comunica[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R1"))%>].checked = true;
	document.formulario.cortesia[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R2"))%>].checked = true;
	document.formulario.presteza[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R3"))%>].checked = true;
	document.formulario.flexibilidade[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R4"))%>].checked = true;
	document.formulario.rapidez[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R5"))%>].checked = true;
	document.formulario.iniciativa[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R6"))%>].checked = true;
	document.formulario.confiabilidade[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R7"))%>].checked = true;
	document.formulario.infraestrutura[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R8"))%>].checked = true;
	document.formulario.ambiente[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R9"))%>].checked = true;
	document.formulario.acesso[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R10"))%>].checked = true;
	document.formulario.geral[<%=PegaIndiceRespostas(objRS_Pesq("PSQ_R11"))%>].checked = true;
	document.formulario.opttipousu[<%if objRS_Pesq("PSQ_ORIGEM") = "E" then response.write "0" else response.write "1"%>].checked = true;

<%		If Not (ehRAT Or ehGQ) Then%>
	document.all.p_conifrmaResposta.innerHTML = '';
	document.all.p_aviso.innerHTML = '<b>Obrigado! Para alguma alteração entre em contato com o CRT.</b>';
<%		end if

	end if
	call Env.RecordSet(false, objRS_Pesq, null)
%>
function desabilitaUserinfo(hab) {
	document.formulario.fNome.disabled = hab;
	document.formulario.fEMail.disabled = hab;
	document.formulario.fOrgao.disabled = hab;
	document.formulario.fRamal.disabled = hab;
	document.formulario.fUsername.disabled = hab;
}
document.formulario.fNome.value = "<%=auxnome%>";
document.formulario.fEMail.value = "<%=auxEmail%>";
document.formulario.fOrgao.value = "<%=auxOrgao%>";
document.formulario.fRamal.value = "<%=auxRamal%>";
document.formulario.fUsername.value = "<%=auxUsername%>";

desabilitaUserinfo(<%=IIf(ehCRT, "false", "true")%>);
</script>
<%
end if

Set Ebt = Nothing

if request("emjanela") = "1" or auxag = "" then
	Call Tela.MostraRodape()
else
	Call Tela.MostraRodape()
end if

Function PegaIndiceRespostas(valor)
	Dim v
	if IsNull(valor) then v = "" else v = cstr(valor)
	if IsNull(v) or v = "" then
		PegaIndiceRespostas = 0
	else
		PegaIndiceRespostas = 5 - CInt(v)
	end if
End Function

Sub TR_Opcoes(nomeRadio, nomeComent, valor)
%>
<tr>
	<td width="50%" valign="middle">
		<input type="radio" value="5" name="<%=nomeRadio%>"> - Muito Satisfeito<br>
		<input type="radio" value="4" name="<%=nomeRadio%>"> - Satisfeito<br>
		<input type="radio" value="3" name="<%=nomeRadio%>"> - Nem Satisfeito, nem Insatisfeito<br>
		<input type="radio" value="2" name="<%=nomeRadio%>"> - Insatisfeito<br>
		<input type="radio" value="1" name="<%=nomeRadio%>"> - Muito InSatisfeito
	</td>
	<td width="50%" valign="bottom"><em>Comentários:</em><textarea  rows="8" name="<%=nomeComent%>" cols="45"><%=valor%></textarea></td>
</tr>
<%
End Sub


Function MensagemSolicitantesInvalidos
%>
<center>
<div style="width:400px" align="justify">
<p>&nbsp;</p>
<p  align="center"><font color="red"><b>AVISO !</b></font></p>
<p >Você selecionou 2 ou mais solicitantes diferentes.</p>
<p >Para usar a funcionalidade de resposta vários agendamentos é necessário que todos os agendamentos sejam do mesmo solicitante.</p>
<p align="center"><input type="button" class='texto1' value="Voltar" name="btnConfirma" onclick="javascript:history.go(-1);"></p>
</div>
</center>
<%
End Function
%>
