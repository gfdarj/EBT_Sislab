<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'-- RELATORIO CONSOLIDADO DA POSICAO DO ESTOQUE
Dim rec, s

Tela.SetNomeTela = "SCE > Relatório > Consolidado do Estoque" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()
%>
<table width="100%"  border="0">
<tr><td class="destaque" colspan="3">Posi&ccedil;&atilde;o consolidada dos itens no Estoque</td></tr>
<tr><td>&nbsp;</td></tr>

<tr><td class="linha_par" colspan="3"><span class="destaque">Equipamentos</span></td></tr>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Geral</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalItens(STATUS_EM_USO, "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalItens(-1, "", "")%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalItens(STATUS_EM_USO, "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "S", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalItens(-1, "S", "")%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em N&atilde;o Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "N", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "N", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalItens(STATUS_EM_USO, "N", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "N", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "N", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalItens(-1, "N", "")%></b></td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td class="linha_par" colspan="3"><span class="destaque">Controle de Equipamentos Vencidos</span></td></tr>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Geral</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "", "")%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "S", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "S", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "S", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "S", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "S", "", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</b></td><td><%=TotalControlesVencidos(-1, "S", "", "")%></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em N&atilde;o Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "N", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "N", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "N", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "N", "", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "N", "", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "N", "", "")%></b></td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Calibra&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "", CONTROLE_CALIBRACAO)%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Manuten&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "", CONTROLE_MANUTENCAO)%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Qualifica&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "", CONTROLE_QUALIFICACAO)%></b></td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td class="linha_par" colspan="3"><span class="destaque">Instrumentais</span></td></tr>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Geral</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "", "S")%></td>
		</tr>
		<tr valign="top">
			<td width="20%">Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "", "S")%></td>
		</tr>
		<tr valign="top">
			<td width="20%">Uso:</td><td><%=TotalItens(STATUS_EM_USO, "", "S")%></td>
		</tr>
		<tr valign="top">
			<td width="20%">Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "", "S")%></td>
		</tr>
		<tr valign="top">
			<td width="20%">Substituídos:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "", "S")%></td>
		</tr>
		<tr valign="top">
			<td width="20%"><b>Total:</b></td><td><%=TotalItens(-1, "", "S")%></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "S", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "S", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalItens(STATUS_EM_USO, "S", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "S", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "S", "S")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</b></td><td><%=TotalItens(-1, "S", "S")%></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em N&atilde;o Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalItens(STATUS_CADASTRADO, "N", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalItens(STATUS_EM_ESTOQUE, "N", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalItens(STATUS_EM_USO, "N", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalItens(STATUS_EXPEDIDO, "N", "S")%></td>
		</tr>
		<tr valign="top">
			<td>Substituído:</td><td><%=TotalItens(STATUS_EXPEDIDO_SUBST, "N", "S")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</b></td><td><%=TotalItens(-1, "N", "S")%></td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td class="linha_par" colspan="3"><span class="destaque">Controle de Instrumentais Vencidos</span></td></tr>
<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Geral</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "S", "")%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "S", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "S", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "S", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "S", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "S", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</b></td><td><%=TotalControlesVencidos(-1, "S", "S", "")%></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Em N&atilde;o Conformidade</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "N", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "N", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "N", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "N", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "N", "S", "")%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "N", "S", "")%></b></td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Calibra&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "S", CONTROLE_CALIBRACAO)%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Manuten&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "S", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "S", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "S", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "S", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "S", CONTROLE_MANUTENCAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "S", CONTROLE_MANUTENCAO)%></b></td>
		</tr>
		</table>
	</td>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><td colspan="2"><b>Qualifica&ccedil;&atilde;o</b></td></tr>
		<tr valign="top">
			<td width="40%">Cadastrados:</td><td><%=TotalControlesVencidos(STATUS_CADASTRADO, "", "S", CONTROLE_CALIBRACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Estoque:</td><td><%=TotalControlesVencidos(STATUS_EM_ESTOQUE, "", "S", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Uso:</td><td><%=TotalControlesVencidos(STATUS_EM_USO, "", "S", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Expedidos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO, "", "S", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td>Substituídos:</td><td><%=TotalControlesVencidos(STATUS_EXPEDIDO_SUBST, "", "S", CONTROLE_QUALIFICACAO)%></td>
		</tr>
		<tr valign="top">
			<td><b>Total:</td><td><%=TotalControlesVencidos(-1, "", "S", CONTROLE_QUALIFICACAO)%></b></td>
		</tr>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()

''''''''''''''''''''''

Function TotalItens(situacao, conforme, instrumental)
	Dim rs, s, w

	s = "SELECT COUNT(*) FROM SCE_Equipamentos"
	w = ""
	if situacao >= 0 then 
		if w <> "" then w = w & " AND "
		w = w & " STATUS = " & situacao
	end if
	if conforme = "S" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_CONFORME = 1 "
	elseif conforme = "N" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_CONFORME = 0 "
	end if
	if instrumental = "S" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_INSTRUMENTAL = 1 "
	elseif instrumental = "N" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_INSTRUMENTAL = 0 "
	end if

	if w <> "" then s = s & " WHERE " & w
	Set rs = Env.oConn.execute(s)
	TotalItens = rs(0)
	rs.Close
	Set rs = Nothing
End Function

Function TotalControlesVencidos(situacao, conforme, instrumental, tipo)
	Dim s, w, rs

	s =	"SELECT COUNT(*) FROM vw_SCE_EQ_CONTROLE_ATUAL "
	w = "GETDATE() > EQC_VENCIMENTO"

	if situacao >= 0 then 
		if w <> "" then w = w & " AND "
		w = w & " STATUS = " & situacao
	end if
	if conforme = "S" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_CONFORME = 1 "
	elseif conforme = "N" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_CONFORME = 0 "
	end if
	if instrumental = "S" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_INSTRUMENTAL = 1 "
	elseif instrumental = "N" then
		if w <> "" then w = w & " AND "
		w = w & " EQ_INSTRUMENTAL = 0 "
	end if
	if tipo = "C" then
		if w <> "" then w = w & " AND "
		w = w & " EQC_TIPO = 'C' "
	elseif tipo = "M" then
		if w <> "" then w = w & " AND "
		w = w & " EQC_TIPO = 'M' "
	elseif tipo = "Q" then
		if w <> "" then w = w & " AND "
		w = w & " EQC_TIPO = 'Q' "
	end if

	if w <> "" then s = s & " WHERE " & w
	Set rs = Env.oConn.execute(s)
	TotalControlesVencidos = rs(0)
	rs.Close
	Set rs = Nothing
End Function
%>