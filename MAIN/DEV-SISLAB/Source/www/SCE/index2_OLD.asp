<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/Abre.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/bib_str.asp"-->
<%
Dim chr_User
Dim int_nfid
Dim int_AgNum
Dim chr_agnumero
Dim chr_agrespon
Dim chr_nf
Dim chr_dtvenc
Dim chr_empresa

chr_User = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")

call ImprimeCabecalho ("", MENU_ON, true, "", "", "")
%>
<table width="100%" class="texto" cellpadding="2" cellspacing="2" border="0">
<tr>
	<td valign="top">
		<table width="100%" class="texto" border="0" cellpadding="4" cellspacing="0">
		<tr valign="top">
			<td><%Call ImprimeControles(CONTROLE_CALIBRACAO, "Cód. Barras", "Vencimento")%></td>
			<td><%Call ImprimeControles(CONTROLE_MANUTENCAO, "Cód. Barras", "Vencimento")%></td>
			<td><%Call ImprimeControles2("Cód. Barras", "Modelo", "Status")%></td>
		</tr>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td valign="top">
		<table width="100%" class="texto" border="0" cellpadding="4" cellspacing="0">
		<tr valign="top">
			<td><%Call ImprimeControlesNotaFiscalVencida()%></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%
call ImprimeRodape (RODAPE_OFF)

Sub ImprimeControles(tipo, chr_Titulo1, chr_Titulo2)
	Dim s, rec
%>				<table width="100%" class="texto" border="1" cellpadding="2" cellspacing="0">
				<tr>
					<td>
						<b>
<%
	if tipo = CONTROLE_CALIBRACAO then
		response.write "Calibração e Qualificação<br></b>&nbsp;<i>(Vencidas ou &agrave; vencer)</i><br>"
	elseif tipo = CONTROLE_MANUTENCAO then
		response.write "Manutenção<br></b>&nbsp;<i>(Vencidas ou &agrave; vencer)</i><br>"
	else
		response.write "<font color='#ff0000'>Não Conformidades</font><br></b><br>"
	end if
%>
						
						<div style="overflow: auto; height: 140px;">
							<table width="100%" class="texto">
<%

	If (tipo = CONTROLE_CALIBRACAO) Or (tipo = CONTROLE_MANUTENCAO) then
		s =	"SELECT EQ_CODIGOBARRAS, CONVERT(varchar, EQC_VENCIMENTO, 103) AS EQC_VENCIMENTO " & _
			"FROM vw_SCE_EQ_CONTROLE_ATUAL " & _
			"WHERE STATUS <> " & STATUS_EXPEDIDO & " AND EQC_TIPO = '" & tipo & "' AND EQC_VENCIMENTO <= GETDATE() + 21 "

		'-- pega os equipamentos que nao estao conforme quando for manutencao
		If tipo = CONTROLE_MANUTENCAO Then
			s = s & "AND EQ_CONFORME = 0 "
		End If

		s = s & "ORDER BY EQC_VENCIMENTO, EQ_CODIGOBARRAS"
	Else
		s =	"SELECT EQ_CODIGOBARRAS, DESC_STATUS /*CASE WHEN LEN(MOD_CODNOME)>10 THEN LEFT(MOD_CODNOME, 7) + '...' ELSE MOD_CODNOME END*/ " & _
			"FROM vw_SCE_Equipamentos_Fabricantes " & _
			"WHERE STATUS <> " & STATUS_EXPEDIDO & " AND EQ_CONFORME = 0"

		s = s & "ORDER BY EQ_CODIGOBARRAS"
 	End If


	'response.write s
	Set rec = conn.Execute(s)
	if not (rec.eof and rec.bof) then%>
							<tr><th align="left"><%=chr_Titulo1%></th><th align="left"><%=chr_Titulo2%></th></tr>
<%		while not rec.eof%>
							<tr><td><%=ConverteNuloHTML(rec(0))%></td><td><%=ConverteNuloHTML(rec(1))%></td></tr>
<%			rec.moveNext
		wend%>
							<tr><td colspan="2" align="right"><i>Total de itens: <%=rec.recordcount%></i></td></tr>
<%	else
%>							<tr><td colspan="2"><i>Nenhum item encontrado</i></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table><%
End Sub


Sub ImprimeControles2(chr_Titulo1, chr_Titulo2, chr_Titulo3)
	Dim s, rec
%>				<table width="100%" class="texto" border="1" cellpadding="2" cellspacing="0">
				<tr>
					<td>
						<b>
<%
	response.write "<font color='#ff0000'>Não Conformidades</font><br></b><br>"
%>
						<div style="overflow: auto; height: 140px;">
							<table width="100%" class="texto">
<%
	s =	"SELECT EQ_CODIGOBARRAS, CASE WHEN LEN(MOD_CODNOME)>10 THEN LEFT(MOD_CODNOME, 7) + '...' ELSE MOD_CODNOME END, DESC_STATUS, STATUS " & _
		"FROM vw_SCE_Equipamentos_Fabricantes " & _
		"WHERE STATUS <> " & STATUS_EXPEDIDO & " AND EQ_CONFORME = 0"
	s = s & "ORDER BY DESC_STATUS, EQ_CODIGOBARRAS"

	'response.write s
	Set rec = conn.Execute(s)
	if not (rec.eof and rec.bof) then%>
							<tr><th align="left"><%=chr_Titulo1%></th><th align="left"><%=chr_Titulo2%></th><th align="left"><%=chr_Titulo3%></th></tr>
<%		while not rec.eof%>
							<tr>
								<td><%=ConverteNuloHTML(rec(0))%></td>
								<td><%=ConverteNuloHTML(rec(1))%></td>
								<td><%
									If CStr(rec("STATUS")) = CStr(STATUS_EM_USO) Then 
										Response.Write "<font color='red' style='color:red'><b>"
									End If 
									Response.Write ConverteNuloHTML(rec(2)) & "</font>"
									%>
								</td>
							</tr>
<%			rec.moveNext
		wend%>
							<tr><td colspan="3" align="right"><i>Total de itens: <%=rec.recordcount%></i></td></tr>
<%	else
%>							<tr><td colspan="3"><i>Nenhum item encontrado</i></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table><%
End Sub


Sub ImprimeControlesNotaFiscalVencida()
	Dim s, rec
%>				<table width="100%" class="texto" border="1" cellpadding="2" cellspacing="0">
				<tr>
					<td>
						<b>Notas Fiscais Vencidas</b>
					</td>
				</tr>
				<tr>
					<td>
						<div style="overflow: auto; height: 190px;">
							<table width="100%" class="texto">
<%
'vinculacao de equipamento com a nota é pela movimentacao - entrada logistica
	s = "" & _
		"SELECT DISTINCT " & VbCrLf & _
		"	ag.AG_NUMERO, " & VbCrLf & _
		"	ag.AG_RESPONSAVEL, " & VbCrLf & _
		"	nf.nf_id, " & VbCrLf & _
		"	m.mov_id, " & VbCrLf & _
		"	nf.nf_numeronota, " & VbCrLf & _
		"	e.EQ_CODIGOBARRAS, e.EQ_LOCALIZACAO, md.MOD_CODNOME, " & VbCrLf & _
		"	CONVERT(varchar, nf.nf_dataemissao, 103) AS nf_dataemissao, " & VbCrLf & _
		"	CONVERT(varchar, nf.nf_recebimento, 103) AS nf_recebimento, " & VbCrLf & _
		"	CASE WHEN nf.NF_VALIDADE IS NULL THEN NULL ELSE CONVERT(varchar, nf.nf_dataemissao + CAST(nf.nf_validade AS INT), 103) END AS nf_datavencimento, " & VbCrLf & _
		"	emp.enf_nome " & VbCrLf & _
		"FROM " & VbCrLf & _
		"	sce_nota_fiscal nf " & VbCrLf & _
		"INNER JOIN " & VbCrLf & _
		"	sce_Natureza_Operacao no on nf.no_id = nf.no_id " & VbCrLf & _
		"LEFT JOIN " & VbCrLf & _
		"	sce_empresa_nota_fiscal emp on nf.enf_id = emp.enf_id " & VbCrLf & _
		"LEFT JOIN " & VbCrLf & _
		"	SCE_Movimentacao m ON m.NF_ID = nf.NF_ID " & VbCrLf & _
		"LEFT JOIN " & VbCrLf & _
		"	Agendamento ag ON ag.AG_NUMERO = m.ASA " & VbCrLf & _
		"INNER JOIN " & VbCrLf & _
		"	SCE_Equipamentos e ON m.EQ_ID = e.EQ_ID " & VbCrLf & _
		"INNER JOIN " & VbCrLf & _
		"	SCE_Modelos md ON e.MOD_ID = md.MOD_ID " & VbCrLf & _
		"WHERE " & VbCrLf & _
		"	-- Notas Vencidas " & VbCrLf & _
		"	((nf.nf_dataemissao + CAST(nf.nf_validade AS INT)) <= GETDATE()) " & VbCrLf & _
		"AND " & VbCrLf & _
		"	-- Notas de Entrada " & VbCrLf & _
		"	nf.NF_TIPO = 1 " & VbCrLf & _
		"AND " & VbCrLf & _
		"	-- Natureza de Operação Possui prazo para retorno" & VbCrLf & _
		"	no.PRAZO = 1 " & VbCrLf & _
		"AND " & VbCrLf & _
		"	-- Nao existe nota de Saída com devolucao completa " & VbCrLf & _
		"	NOT EXISTS ( " & VbCrLf & _
		"		SELECT " & VbCrLf & _
		"			nf1.nf_id " & VbCrLf & _
		"		FROM " & VbCrLf & _
		"			sce_nota_fiscal nf1 " & VbCrLf & _
		"		WHERE " & VbCrLf & _
		"			nf1.nf_id_pai = nf.nf_id  -- Nota Pai é a de entrada " & VbCrLf & _
		"		AND " & VbCrLf & _
		"			nf1.NF_TIPO = 2 -- Saida " & VbCrLf & _
		"		AND " & VbCrLf & _
		"			NF_DEVOLUCAOCOMPLETA = 1 -- devolucao completa " & VbCrLf & _
		"	) " & VbCrLf & _
		"ORDER BY " & VbCrLf & _
		"	ag.AG_RESPONSAVEL, ag.AG_NUMERO DESC, emp.ENF_NOME, nf.NF_NUMERONOTA, e.EQ_CODIGOBARRAS" & VbCrLf

	'response.write s
	Set rec = conn.Execute(s)
	if not (rec.eof and rec.bof) then
		int_AgNum = -1
		int_nfid = -1
%>
							<tr>
								<th align="left">AS</th>
								<th align="left">RT</th>
								<th align="left">NF</th>
								<th align="left">Vencimento</th>
								<th align="left">Empresa</th>
								<th align="left">Equipamento</th>
								<th align="left">Descrição</th>
								<th align="left">Local</th>
							</tr>
<%
		'chr_User = "CTERRA"   'debug
		While Not rec.eof
			If (int_AgNum <> rec("AG_NUMERO")) Then
				chr_agnumero = rec("AG_NUMERO")
				chr_agrespon = rec("AG_RESPONSAVEL")
			Else
				chr_agnumero = "&nbsp;"
				chr_agrespon = "&nbsp;"
			End If
			If (int_nfid <> rec("NF_ID")) Then
				chr_nf = rec("NF_NUMERONOTA")
				chr_dtvenc = rec("NF_DATAVENCIMENTO")
				chr_empresa = ConverteNuloHTML(rec("ENF_NOME"))
			Else
				chr_nf = "&nbsp;"
				chr_dtvenc = "&nbsp;"
				chr_empresa = "&nbsp;"
			End If
%>
							<tr <%If chr_User = UCase(rec("AG_RESPONSAVEL")) Then Response.Write "style= color:red;"%>>
								<td><%=chr_agnumero%></td>
								<td><%=chr_agrespon%></td>
								<td><%=chr_nf%></td>
								<td><%=chr_dtvenc%></td>
								<td><%=chr_empresa%></td>
								<td><%=rec("EQ_CODIGOBARRAS")%></td>
								<td><%=ConverteNuloHTML(rec("MOD_CODNOME"))%></td>
								<td><%=ConverteNuloHTML(rec("EQ_LOCALIZACAO"))%></td>
							</tr>
<%
			int_AgNum = rec("AG_NUMERO")
			int_nfid = rec("NF_ID")
			rec.moveNext
		WEnd
%>
							<tr><td colspan="8" align="right"><i>Total de itens: <%=rec.recordcount%></i></td></tr>
<%	else
%>							<tr><td colspan="8"><i>Nenhum item encontrado</i></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table><%
End Sub
%>
