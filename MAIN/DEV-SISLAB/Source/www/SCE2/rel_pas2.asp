<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim s_orig, s_dest, w, rec, s

Tela.SetNomeTela = "SCE > Relatório > Passagem de Carga"
Tela.SetCaminhoRelativo = "../"

Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()

    s =	"SELECT p.AG_NUMERO_ORIG, p.AG_NUMERO_DEST, ao.AG_RESPONSAVEL AS AG_RESPONSAVEL_ORIG, " & _
	    "ad.AG_RESPONSAVEL AS AG_RESPONSAVEL_DEST, CONVERT(VARCHAR, PAS_DATAPASSAGEM, 103) AS " & _
	    "PAS_DATAPASSAGEM, CONVERT(VARCHAR, PAS_DATARECEBIMENTO, 103) AS PAS_DATARECEBIMENTO, " & _
	    "PAS_APROVADO, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, e.MOD_DESCRICAO " & _
	    "FROM Agendamento ao, Agendamento ad, SCE_Passagem_Carga p, vw_SCE_Equipamentos_Fabricantes e " & _
	    "WHERE e.EQ_ID = p.EQ_ID AND ao.AG_NUMERO = ad.AG_NUMERO "

    s_orig = s & " AND ao.AG_NUMERO = p.AG_NUMERO_ORIG "
    s_dest = s & " AND ad.AG_NUMERO = p.AG_NUMERO_DEST "

    if request("ag_numero") <> "" then
	    s_orig = s_orig & " AND p.AG_NUMERO_ORIG = " & request("ag_numero")
	    s_dest = s_dest & " AND p.AG_NUMERO_DEST = " & request("ag_numero")
    end if
    if request("ag_responsavel") <> "" then
	    s_orig = s_orig & " AND ao.AG_RESPONSAVEL = '" & request("ag_responsavel") & "' "
	    s_dest = s_dest & " AND ad.AG_RESPONSAVEL = '" & request("ag_responsavel") & "' "
    end if

    s_orig = s_orig & " ORDER BY p.AG_NUMERO_ORIG, p.PAS_DATAPASSAGEM, e.EQ_CODIGOBARRAS"
    s_dest = s_dest & " ORDER BY p.AG_NUMERO_DEST, p.PAS_DATAPASSAGEM, e.EQ_CODIGOBARRAS"
%>
<p class="destaque">Listagem de Passagem de Carga</p>

<p class="texto1b">Cargas Passadas <%=ImprimePassagemAS(request("ag_numero"))%></p>
<%
    Set rec = Env.oConn.Execute(s_orig)
    call ImprimeListaPassagem(conn, rec, "ORIG", request("ag_numero"))
    rec.Close

    if request("ag_numero") <> "" or request("ag_responsavel") <> "" then%>
	<p class="texto1b">Cargas Recebidas <%=ImprimePassagemAS(request("ag_numero"))%></p>
<%
	    Set rec = Env.oConn.Execute(s_dest)
	    call ImprimeListaPassagem(conn, rec, "DEST", request("ag_numero"))
	    rec.Close
    end if

    response.write "<br>" '-- so para ficar com uma linha ao final do resultado
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()



'-- Funcoes auxiliares
Function ImprimePassagemAS(ag)
	if trim(ag) <> "" then ImprimePassagemAS = "<span class='texto1'>(AS " & ag & ")</span>"
End Function

Sub ImprimeListaPassagem(objconn, objRS, tipo, ag)%>
<%	if not (objRS.Eof and objRS.bof) then%>
<table width="100%" cellpadding="2" cellspacing="0" class="texto1" border="1">
<tr>
<%'		if tipo = "ORIG" or ag <> "" then%>
	<th align="left" width="65px">AS Origem</th>
	<th>Respons&aacute;vel Origem</th>
<%'		end if%>
<%'		if tipo = "DEST" or ag <> "" then%>
	<th align="left" width="65px">AS Destino</th>
	<th>Respons&aacute;vel Destino</th>
<%'		end if%>
	<th>Dt.Passagem</th>
	<th>Dt.Recebimento</th>
	<th width="115px">C&oacute;d. Barras</th>
	<th>Modelo</th>
	<th>Descri&ccedil;&atilde;o</th>
	<th width="60px">Aprovado</th>
</tr>
<%		objRS.MoveFirst
		while not objRS.Eof%>
<tr>
<%'			if tipo = "ORIG" or ag <> "" then%>
	<td><%=objRS("AG_NUMERO_ORIG")%></td>
	<td><%=objRS("AG_RESPONSAVEL_ORIG")%></td>
<%'			end if%>
<%'			if tipo = "DEST" or ag <> "" then%>
	<td><%=objRS("AG_NUMERO_DEST")%></td>
	<td><%=objRS("AG_RESPONSAVEL_DEST")%></td>
<%'			end if%>
	<td align="center"><%=objRS("PAS_DATAPASSAGEM")%></td>
	<td align="center"><%=objRS("PAS_DATARECEBIMENTO")%></td>
	<td align="center"><%=objRS("EQ_CODIGOBARRAS")%></td>
	<td align="center"><%=objRS("MOD_CODNOME")%></td>
	<td align="center"><%=objRS("MOD_DESCRICAO")%></td>
	<td align="center"><%=SimNao(objRS("PAS_APROVADO"))%></td>
</tr>
<%			objRS.MoveNext
		wend%>
</table>
<%	else%>
<p align="center" class="texto1"><i>Nenhuma carga encontrada</i></p>
<%	end if
End Sub
%>
