<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<%
Dim Ebt

Set Ebt = New TEbt

'Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Validação de Cancelamento/Remarcação de Testes/Ensaios", "", "")
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Validação de Remarcação de Agendamento", "", "")

Response.Buffer = true

Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT" 
Response.Addheader "Cache-Control","no-cache, must-revalidate" 
Response.Addheader "Pragma","no-cache" 

Dim conn, rs_agendamento, strSQL
Dim num_agendamento, num_erro, desc_erro
Dim data_inicio, data_termino, tecnologia, nome_responsavel, matricula
Dim orgao, email, ramal, situacao, motivo, data_inicio_ped, data_termino_ped
Dim cancelou

num_agendamento = request("cmbNumeroAgendamento")

strSQL = "Select *"
strSQL = strSQL & " from HISTORICO_EVENTOS HE, SITUACOES S, HISTORICO_DATAS HD, AGENDAMENTO AG LEFT JOIN TECNOLOGIA AT ON AG.TEC_ID = AT.TEC_ID"
strSQL = strSQL & " where AG.AG_NUMERO = HE.AG_NUMERO"
strSQL = strSQL & " and HE.ID_SITUACAO = S.ID_SITUACAO"
strSQL = strSQL & " and AG.AG_NUMERO = HD.AG_NUMERO"
strSQL = strSQL & " and HE.HE_DATATERMINO is null"
strSQL = strSQL & " and HD.HD_MARCACAO = (select max(HD_MARCACAO) from HISTORICO_DATAS where AG_NUMERO = " & num_agendamento & ")"
strSQL = strSQL & " and AG.AG_NUMERO = " & num_agendamento

call Env.RecordSet( true, rs_agendamento, strSQL)

'response.write strsql
'response.end

if (rs_agendamento.bof and rs_agendamento.eof) then
	Response.Clear
	rs_agendamento.Close
	set rs_agendamento = nothing

	Call MsgGravacaoDados(True, False, "<span class='vermelho2'><b>Inconsistência na base de dados !</b><BR><BR>Este registro não possui data de remarcação.</span>", "javascript: history.go(-1)", "")
else
	data_inicio = rs_agendamento("AG_DATAINICIO")
	data_termino = rs_agendamento("AG_DATATERMINO")
	data_inicio_ped = rs_agendamento("HD_DATAINICIO")
	data_termino_ped = rs_agendamento("HD_DATATERMINO")
	motivo = rs_agendamento("HD_MOTIVO")
	tecnologia = rs_agendamento("TEC_NOME")


	Call Ebt.BuscaDadosEmbratel(rs_agendamento("AG_USERNAME"))

	If Ebt.EhFuncionario Then
		nome_responsavel = Ebt.NomeReduzido
		matricula = Ebt.MATRICULA
		ramal = Ebt.Ramal
	Else
		nome_responsavel = "xxxx"
		matricula = "xxxx"
		ramal = "xxxx"
	End If

	Set Ebt = nothing

	orgao = rs_agendamento("AG_ORGAO")
	email = rs_agendamento("AG_USERNAME")
	
	situacao = rs_agendamento("S_DESCRICAO")
	cancelou = CBool(rs_agendamento("AG_SOLICITOUCANCELAMENTO"))
	if IsNull(cancelou) then cancelou = false
%>

<script language="JavaScript">
function anyChecked(radioSet)
{
	for (i = 0; i < radioSet.length; i++)
		if (radioSet[i].checked)
			return true;
	return false;
}
//=========================================================================================

function validaCampos(form)
//Valida os campos quando o formulário é submetido
{
	if (!anyChecked(form.cmbRemarca)) 
	{
<%	if not cancelou then%>
		alert("O campo 'Remarca o teste/ensaio' deve ser selecionado.");
<%	else%>
		alert("O campo 'Aceitar pedido de cancelamento' deve ser selecionado.");
<%	end if%>
		form.cmbRemarca[0].focus();
		return(false);
	}
	else
		return(true);
}
//=========================================================================================

function voltar()
{
	location.href = 'SISLAB.ASP';
}
function Cancelar()
{
	document.forms[0].chr_CancelarSolicitacao = 'S';
	document.forms[0].submit();
}
//=========================================================================================

</script>

<body>
<form method="post" action="form_valida_remarcaA.asp" name="frmValidaRemarca" onSubmit="return validaCampos(this);">
<input type="hidden" name="txtNum_agendamento" value="<%= num_agendamento%>">
<input type="hidden" name="chr_CancelarSolicitacao" value="N">
<TABLE border=0 cellSpacing=0 width="100%" class="table-bordered">
	<TR>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
	</TR>
	<TR height="34">
		<TD colSpan=3>&nbsp;&nbsp;Tecnologia:&nbsp;<%=tecnologia%></TD>
		<TD colSpan=3><b>Número do Agendamento:&nbsp;<%= num_agendamento%></b></TD>
		<TD colSpan=4><b>&nbsp;&nbsp;Situação:&nbsp;<%= situacao%></b></TD>
	</TR>
	<TR height="34"> 
		<td colspan="7">
			&nbsp;&nbsp;Nome do Responsável: &nbsp; <%= nome_responsavel%>
	    </td>
	    <td colspan="3">
			&nbsp;&nbsp;Matrícula:&nbsp; <%=matricula%>
		</td>
	</tr>
	<tr height="34">	
		<td  colspan="3">&nbsp;&nbsp;Órgão:&nbsp; <%= orgao%></td>
		<td  colspan="4">&nbsp;&nbsp;E-mail:&nbsp; <%= email%></td>
		<td  colspan="3">&nbsp;&nbsp;Ramal:&nbsp; <%= ramal%></td>
	</tr>
	<tr height="34"> 
		<td  colspan="10">
			&nbsp;&nbsp;Período previsto para teste:&nbsp;
			&nbsp;&nbsp;Início:&nbsp;<%=data_inicio%>
			&nbsp;&nbsp;&nbsp;&nbsp;Fim:&nbsp;<%=data_termino%>
		</td>
	</tr>
	<tr height="34"> 
		<td  colspan="10">
			&nbsp;&nbsp;Novo período pedido para teste:&nbsp;
			&nbsp;&nbsp;Início:&nbsp;<%=data_inicio_ped%>
			&nbsp;&nbsp;&nbsp;&nbsp;Fim:&nbsp;<%=data_termino_ped%>
		</td>
	</tr>
    <tr height="34"> 
        <td valign="top" colspan="10">
			&nbsp;&nbsp;Motivo da Mudança:&nbsp;<BR>
			<table cellpadding="0" cellspacing="0" class="table-bordered">
			<tr>
				<td>&nbsp;&nbsp;</td>
				<td><%=replace(motivo, vbCrLf, "<BR>")%></td>
			</tr>
			</table>
        </td>
    </tr>
	<tr height="34"> 
		<td colspan="10">
			<b>
<%	if not cancelou then %>    
              <p>&nbsp;&nbsp;Remarca o teste/ensaio: &nbsp;
<%	else %>
              <p>&nbsp;&nbsp;Aceitar pedido de cancelamento: &nbsp;
<%	end if %>
			</b>
              <input type="radio" name="cmbRemarca" value="1" tabindex="13">
				Sim&nbsp;
              <input type="radio" name="cmbRemarca" value="0" tabindex="14">
				Não&nbsp;
		</td>
    </tr>
</TABLE>
<br>
<p align="center"> 
    <input class="texto1" type="submit" value="Confirmar" name="btnOk" tabindex="71" style="width: 80px;" title="Confirma solicitação do usuário">&nbsp;
    <input class="texto1" type="button" name="Submit2" value="Voltar" tabindex="72" onclick="voltar()" style="width: 80px;" title="Volta para lista de solicitações">&nbsp;
</p>
<input type="hidden" name="solicitouCancelamento" value="<%=cancelou%>">
</form>

<%
    Call Tela.MostraRodape()
end if

call Env.RecordSet(False, rs_agendamento, Null)
%>
