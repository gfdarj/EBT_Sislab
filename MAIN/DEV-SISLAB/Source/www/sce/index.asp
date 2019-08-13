<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Sce.asp"-->
<%
Dim chr_User
Dim int_nfid
Dim int_AgNum
Dim chr_agnumero
Dim chr_agrespon
Dim chr_nf
Dim chr_dtvenc
Dim chr_empresa
Dim chr_UsuarioSCE

chr_User = Env.Usuario
chr_UsuarioSCE = Env.UsuarioSCE()

'response.write "<BR><BR><BR><BR>" & env.UsuarioSCE() & "<BR>"
'response.write env.PerfilSCE()

Tela.SetNomeTela = ""
Tela.SetCaminhoRelativo = "../"
Tela.SCE = True

Call Tela.MostraCabecalho()

If chr_UsuarioSCE Then
    Dim Sce

    Set Sce = New TSce

    'Call Tela.ImprimeMenuSce()

    Dim sqlSaidaParaManutencao, sqlSaidaCalibracao, sqlControles2, sqlNotaFiscalVencida

    sqlSaidaCalibracao = _
			"SELECT E.EQ_ID, E.EQ_CODIGOBARRAS AS EQ_CODIGOBARRAS_M, amb.AMB_NOME AS EQ_LOCALIZACAO_M, M.CDE AS CDE_M, " & _
			"		CONVERT(VARCHAR, (m.MOV_DATA + ISNULL(e.EQ_FREQ_CALIBRACAO, 0)), 103) AS DT_PROX_CALIBRACAO_M " & _
			"FROM SCE_Equipamentos e " & _
            "   LEFT JOIN Ambientes amb ON e.AMB_ID = amb.AMB_ID " & _
            "   INNER JOIN SCE_Movimentacao m ON e.EQ_ID = m.EQ_ID  INNER JOIN ( " & _
			"	SELECT m1.EQ_ID, MAX(m1.MOV_ID) AS MOV_ID FROM SCE_Movimentacao m1 " & _
			"	INNER JOIN ( " & _
			"	SELECT EQ_ID, MAX(MOV_DATA) AS MOV_DATA FROM SCE_Movimentacao " & _
			"		WHERE (CDE IS NOT NULL OR LTRIM(RTRIM(CDE)) <> '' OR CDE <> ' ') AND FL_CALIBRACAO = 1 AND TIPO = " & MOV_ENTRADA & " " & _
			"		GROUP BY EQ_ID) m2 ON (m1.EQ_ID = m2.EQ_ID AND m1.MOV_DATA = m2.MOV_DATA) " & _
			"   WHERE m1.CDE IS NOT NULL AND LTRIM(RTRIM(m1.CDE)) <> '' AND m1.CDE <> ' ' AND m1.FL_CALIBRACAO = 1 AND m1.TIPO = " & MOV_ENTRADA & " " & _
			"   GROUP BY m1.EQ_ID) mm ON (m.MOV_ID = mm.MOV_ID) " & _
			"WHERE ((m.MOV_DATA + e.EQ_FREQ_CALIBRACAO) <= GETDATE() + 90) AND e.EQ_FREQ_CALIBRACAO IS NOT NULL " & _
			"ORDER BY CONVERT(VARCHAR, (m.MOV_DATA + ISNULL(e.EQ_FREQ_CALIBRACAO, 0)), 103) ASC"

    sqlSaidaParaManutencao = _
			"SELECT E.EQ_ID, E.EQ_CODIGOBARRAS AS EQ_CODIGOBARRAS_M, M.CDE AS CDE_M, CONVERT(VARCHAR, M.MOV_DATA, 103) AS DT_SAIDA_M, " & _
			"	DATEDIFF(day, M.MOV_DATA, GETDATE()) AS QTD_DIAS_M, FL_CALIBRACAO " & _
			"FROM vw_SCE_Movimentacao_Atual AS M INNER JOIN SCE_Equipamentos AS E ON M.EQ_ID = E.EQ_ID " & _
			"     LEFT JOIN SCE_Equipamentos AS EAnt ON E.EQ_CODIGOBARRAS = EAnt.EQ_CODIGOBARRASANTERIOR " & _
			"WHERE EAnt.EQ_CODIGOBARRASANTERIOR IS NULL AND M.CDE IS NOT NULL AND LTRIM(RTRIM(M.CDE)) <> '' AND LTRIM(RTRIM(M.CDE)) <> ' ' AND (M.TIPO = " & MOV_EXPEDICAO & ") " & _
			"      AND GETDATE() > m.MOV_DATA + 90"

    sqlControles2 = "SELECT EQ_ID, EQ_CODIGOBARRAS AS [Código Barras_M], MOD_CODNOME AS [Modelo_M], CASE WHEN STATUS = 0 THEN 'Cadastrado' ELSE DESC_STATUS END AS [Status_M], STATUS AS [Cod. Status], AMB_NOME AS EQ_LOCALIZACAO_M " & _
		            "FROM vw_SCE_Equipamentos_Fabricantes " & _
		            "WHERE STATUS <> " & STATUS_EXPEDIDO & _
		            " AND STATUS <> " & STATUS_EXPEDIDO_SUBST & _
		            " AND EQ_CONFORME = 0 " & _
	                "ORDER BY DESC_STATUS, EQ_CODIGOBARRAS"

	sqlNotaFiscalVencida = ""
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "SELECT DISTINCT " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	e.EQ_ID, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	ag.AG_NUMERO AS [AG_NUMERO_M], " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	ag.AG_RESPONSAVEL AS [AG_RESPONSAVEL_M], " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	nf.nf_id, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	m.mov_id, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	nf.nf_numeronota AS [NF_NUMERONOTA_M], " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	e.EQ_CODIGOBARRAS AS [EQ_CODIGOBARRAS_M], amb.AMB_NOME AS [EQ_LOCALIZACAO_M], md.MOD_CODNOME AS [MOD_CODNOME_M], " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	CONVERT(varchar, nf.nf_dataemissao, 103) AS nf_dataemissao_M, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	CONVERT(varchar, nf.nf_recebimento, 103) AS nf_recebimento_M, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	CASE WHEN nf.NF_VALIDADE IS NULL THEN NULL ELSE CONVERT(varchar, nf.nf_dataemissao + CAST(nf.nf_validade AS INT), 103) END AS nf_datavencimento_M, " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	emp.enf_nome AS [ENF_NOME_M] " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "FROM " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	sce_nota_fiscal nf " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "INNER JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	sce_Natureza_Operacao no on nf.no_id = nf.no_id " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "LEFT JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	sce_empresa_nota_fiscal emp on nf.enf_id = emp.enf_id " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "LEFT JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	SCE_Movimentacao m ON m.NF_ID = nf.NF_ID " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "LEFT JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	Agendamento ag ON ag.AG_NUMERO = m.ASA " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "INNER JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	SCE_Equipamentos e ON m.EQ_ID = e.EQ_ID " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "INNER JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	SCE_Modelos md ON e.MOD_ID = md.MOD_ID " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "LEFT JOIN " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	Ambientes amb ON e.AMB_ID = amb.AMB_ID " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "WHERE " & VbCrLf
	'# Notas Vencidas
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	( ((nf.nf_dataemissao + CAST(nf.nf_validade AS INT)) <= GETDATE()) " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	OR ((nf.nf_dataemissao + CAST(nf.nf_validade AS INT)) <= GETDATE()+30)) " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "AND " & VbCrLf
	'# Notas de Entrada
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	nf.NF_TIPO = 1 " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "AND " & VbCrLf
	'# Natureza de Operação Possui prazo para retorno
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	no.PRAZO = 1 " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "AND " & VbCrLf
	'# Nao existe nota de Saída com devolucao completa
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	NOT EXISTS ( " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "		SELECT " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "			nf1.nf_id " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "		FROM " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "			sce_nota_fiscal nf1 " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "		WHERE " & VbCrLf
	'# Nota Pai é a de entrada
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "			nf1.nf_id_pai = nf.nf_id " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "		AND " & VbCrLf
	'# Saida
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "			nf1.NF_TIPO = 2 " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "		AND " & VbCrLf
	'# devolucao completa
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "			NF_DEVOLUCAOCOMPLETA = 1 " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	) " & VbCrLf
    '#Order by
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "ORDER BY " & VbCrLf
	sqlNotaFiscalVencida = sqlNotaFiscalVencida & "	ag.AG_RESPONSAVEL, ag.AG_NUMERO DESC, emp.ENF_NOME, nf.NF_NUMERONOTA, e.EQ_CODIGOBARRAS" & VbCrLf

%>
<table class="largura-total table-condensed">
<tr>
	<td style="vertical-align: top;">
		<table class="largura-total table-condensed">
		<tr style="vertical-align: top;">
			<td>
				<%Call ImprimeControleSaidaParaManutencao()%>
				<%'Call ImprimeControles(CONTROLE_CALIBRACAO, "Cód. Barras", "Vencimento")%>
			</td>
			<td>
				<%Call ImprimeControlesSaidaCalibracao()%>
				<%'Call ImprimeControles(CONTROLE_MANUTENCAO, "Cód. Barras", "Vencimento")%>
			</td>
			<td><%Call ImprimeControles2("Cód. Barras", "Modelo", "Status", "Local")%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td style="vertical-align: top;">
		<table class="largura-total table-condensed">
		<tr valign="top">
			<td><%Call ImprimeControlesNotaFiscalVencida()%></td>
		</tr>
		</table>
	</td>
</tr>
</table>

<form name="formulario" method="post" action="../excel.asp">
    <input type="hidden" name="titulo" value="" />
    <input type="hidden" name="sql" value="" />
    <input type="hidden" name="sqlSaidaParaManutencao" value="<%=sqlSaidaParaManutencao%>" />
    <input type="hidden" name="sqlSaidaCalibracao" value="<%=sqlSaidaCalibracao%>" />
    <input type="hidden" name="sqlControles2" value="<%=sqlControles2%>" />
    <input type="hidden" name="sqlNotaFiscalVencida" value="<%=sqlNotaFiscalVencida%>" />
</form>

<script>
    function GerarXLS(titulo, qualSQL)
    {
        var f = document.forms[0];

        f.titulo.value = titulo;

        if (qualSQL == "SaidaParaManutencao")
            f.sql.value = f.sqlSaidaParaManutencao.value;
        else if (qualSQL == "SaidaCalibracao")
            f.sql.value = f.sqlSaidaCalibracao.value;
        else if (qualSQL == "Controles2")
            f.sql.value = f.sqlControles2.value;
        else if (qualSQL == "NotaFiscalVencida")
            f.sql.value = f.sqlNotaFiscalVencida.value;

        f.submit();
    }
</script>


<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()


'#############################################################################################
Sub ImprimeControlesSaidaCalibracao()
	Dim sSql
	Dim RS
	Dim url_xls
	Dim sTitulo
	Dim total
 
	sTitulo = "Próximas Calibrações (Venc. até 90 dias)"

    sSql = sqlSaidaCalibracao
	Set RS = Env.oConn.Execute(sSql)

	url_xls = Link2Xls(sTitulo, "SaidaCalibracao")
%>
				<table class="largura-total table-condensed table-bordered fonte px11">
				<tr>
					<td>
						<table class="largura-total table-condensed fonte px11">
						<tr>
                            <td><strong class="text-info"><%=sTitulo%></strong></td>
                            <td class="texto-direito"><%=url_xls%></td>
						</tr>
						</table>

						<div style="overflow: auto; height: 140px;">
							<table class="largura-total">
<%
	If Not (RS.eof And RS.bof) Then%>
							<tr><th>Cód. Barras</th><th>Local</th><th class="texto-centralizado">CDE</th><th>Dt.Prox.Calib.</th></tr>
<%      total = 0 %>
<%		While Not RS.Eof%>
							<tr>
								<td><%=Sce.LinkEquipamento(RS("EQ_ID"), RS("EQ_CODIGOBARRAS_M"), False)%></td>
								<td class="texto-centralizado"><%=ConverteNuloHTML(RS("EQ_LOCALIZACAO_M"))%></td>
								<td class="texto-centralizado"><%=ConverteNuloHTML(RS("CDE_M"))%></td>
								<td class="texto-centralizado"><%=ConverteNuloHTML(RS("DT_PROX_CALIBRACAO_M"))%></td>
							</tr>
<%			RS.MoveNext
            total = total + 1
		WEnd%>
							<tr><td colspan="4" class="texto-direito"><small>Total de itens: <%=total%></small></td></tr>
<%	Else
%>							<tr><td colspan="4" class="texto-centralizado"><small>Nenhum item encontrado</small></td></tr><%
	End if%>				</table>
						</div>
					</td>
				</tr>
				</table>
<%
End Sub


'#############################################################################################
Sub ImprimeControleSaidaParaManutencao()
	Dim sSql
	Dim RS
	Dim url_xls
	Dim sTitulo
	Dim total

	sTitulo = "Pendencias de retorno Manut./Calibração (90 dias)"

    'sinalizar os items com mais de 90 dias
	sSql = sqlSaidaParaManutencao
	Set RS = Env.oConn.Execute(sSql)

	url_xls = Link2Xls(sTitulo, "SaidaParaManutencao")
%>
				<table class="largura-total table-condensed table-bordered fonte px11">
				<tr>
					<td>
						<table class="largura-total table-condensed">
						<tr>
                            <td><strong class="text-info"><%=sTitulo%></strong></td>
                            <td class="texto-direito"><%=url_xls%></td>
						</tr>
						</table>

						<div style="overflow: auto; height: 140px;">
							<table class="largura-total">
<%
	If Not (RS.eof And RS.bof) Then%>
							<tr><th>&nbsp;</th><th>Cód. Barras</th><th class="texto-centralizado">CDE</th><th>Dt. Saída</th><th class="texto-direito">Dias</th></tr>
<%      total = 0 %>
<%		While Not RS.Eof%>
							<tr>
								<td><%=IIf(RS("FL_CALIBRACAO") = 1, "<span class='text-warning'>c</span>", "<span class='text-success'>m</span>")%></td>
								<td><%=Sce.LinkEquipamento(RS("EQ_ID"), RS("EQ_CODIGOBARRAS_M"), False)%></td>
								<td class="texto-centralizado"><%=ConverteNuloHTML(RS("CDE_M"))%></td>
								<td><%=ConverteNuloHTML(RS("DT_SAIDA_M"))%></td>
								<td class="texto-direito"><%=ConverteNuloHTML(RS("QTD_DIAS_M"))%></td>
							</tr>
<%			RS.MoveNext
            total = total + 1
		WEnd%>
							<tr><td colspan="5" class="texto-direito"><small>Total de itens: <%=total%></small></td></tr>
<%	Else
%>							<tr><td colspan="5" class="texto-centralizado"><small>Nenhum item encontrado</small></td></tr><%
	End if%>				</table>
						</div>
					</td>
				</tr>
				</table>
<%
End Sub


'#############################################################################################
Sub ImprimeControles(tipo, chr_Titulo1, chr_Titulo2)
	Dim s, rec
	Dim Titulo
	Dim url_xls
	Dim total

	If (tipo = CONTROLE_CALIBRACAO) Or (tipo = CONTROLE_MANUTENCAO) Then
		s =	"SELECT EQ_ID, EQ_CODIGOBARRAS AS [Código Barras_M], MOD_CODNOME AS [Modelo_M], CONVERT(varchar, EQC_VENCIMENTO, 103) AS [Vencimento_M], EQC_TIPO AS [Tipo] " & _
			"FROM vw_SCE_EQ_CONTROLE_ATUAL " & _
			"WHERE STATUS <> " & STATUS_EXPEDIDO & _
			" AND STATUS <> " & STATUS_EXPEDIDO_SUBST & " AND "

		If (tipo = CONTROLE_MANUTENCAO) Then
			Titulo = "Controle Manutenção"
			s = s & "EQC_TIPO IN ('" & CONTROLE_MANUTENCAO & "', '" & CONTROLE_MANUTENCAO_PREVENTIVA & "')"
		Else
			Titulo = "Controle Calibração e Qualificação"
			s = s & "EQC_TIPO = '" & tipo & "'"
		End If

		s = s & " AND EQC_VENCIMENTO <= GETDATE()+21"

		'-- pega os equipamentos que nao estao conforme quando for manutencao
		If tipo = CONTROLE_MANUTENCAO Then
			s = s & "AND EQ_CONFORME = 0 "
		'-- caso contrario pega somente os itens conforme
		Else
			s = s & "AND EQ_CONFORME = 1 "
		End If

		s = s & "ORDER BY CAST(EQC_VENCIMENTO AS DATETIME) DESC, EQ_CODIGOBARRAS ASC"
	Else
		s =	"SELECT EQ_ID, EQ_CODIGOBARRAS  AS [Código Barras_M], MOD_CODNOME AS [Modelo_M], DESC_STATUS AS [Status_M] /*CASE WHEN LEN(MOD_CODNOME)>10 THEN LEFT(MOD_CODNOME, 7) + '...' ELSE MOD_CODNOME END*/ " & _
			"FROM vw_SCE_Equipamentos_Fabricantes " & _
			"WHERE STATUS <> " & STATUS_EXPEDIDO & " " & _
			"AND STATUS <> " & STATUS_EXPEDIDO_SUBST & " " & _
			"AND EQ_CONFORME = 0"

		s = s & "ORDER BY EQ_CODIGOBARRAS"
 	End If

	'response.write s
	'response.end
	'exit sub
	Set rec = Env.oConn.Execute(s)

	url_xls = Link2Xls(sTitulo, "Controles")
%>
				<table class="largura-total table-condensed table-bordered fonte px11">
				<tr>
					<td>
						<table class="largura-total table-condensed">
<%
	if tipo = CONTROLE_CALIBRACAO then %>
						<tr><td><b>Calibração e Qualificação</b></td><td class="texto-direito"><%=url_xls%></td></tr>
						<tr><td colspan="2"><i>(Vencidas ou &agrave; vencer)</i></td></tr>
<%	elseif tipo = CONTROLE_MANUTENCAO then %>
						<tr><td><b>Manut. <font color='red'>C</font>orretiva/<font color='blue'>P</font>reventiva</b></td><td class="texto-direito"><%=url_xls%></td></tr>
						<tr><td colspan="2"><i>(Vencidas ou &agrave; vencer)</i></td></tr>
<%	else %>
						<tr><td><b><font color='#ff0000'>Não Conformidades</font></b></td><td class="texto-direito"><%=url_xls%></td></tr>
						<tr><td colspan="2">&nbsp;</td></tr>
<%	end if %>
						</table>

						<div style="overflow: auto; height: 140px;">
							<table class="largura-total">
<%
	if not (rec.eof and rec.bof) then%>
							<tr><th><%=chr_Titulo1%></th><th><%=chr_Titulo2%></th></tr>
<%      total = 0 %>
<%		while not rec.eof%>
							<tr>
                                <td><%=ImprimeTipoManutencaoHTML(rec("TIPO"))%><%=ConverteNuloHTML(rec("Código Barras_M"))%></td><td><%=ConverteNuloHTML(rec("Status_M"))%></td>
							</tr>
<%			rec.moveNext
            total = total + 1
		wend%>
							<tr><td colspan="2" class="texto-direito"><i>Total de itens: <%=total%></i></td></tr>
<%	else
%>							<tr><td colspan="2"><i>Nenhum item encontrado</i></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table>
<%
End Sub


Sub ImprimeControles2(chr_Titulo1, chr_Titulo2, chr_Titulo3, chr_Titulo4)
	Dim s, rec
	Dim Titulo
	Dim url_xls
	Dim total

	Titulo = "Não Conformidades"

    s = sqlControles2
	url_xls = Link2Xls(sTitulo, "Controles2")

	'response.write s
%>				<table class="largura-total table-condensed table-bordered fonte px11">
				<tr>
					<td>
						<table class="largura-total table-condensed">
						<tr>
                            <td><strong class="text-danger"><%=Titulo%></strong></td>
                            <td class="texto-direito"><%=url_xls%></td>
						</tr>
						</table>
						
						<div style="overflow: auto; height: 140px;">
							<table class="largura-total">
<%
	Set rec = Env.oConn.Execute(s)
	if not (rec.eof and rec.bof) then%>
							<tr><th><%=chr_Titulo1%></th><th><%=chr_Titulo2%></th><th><%=chr_Titulo3%></th><th><%=chr_Titulo4%></th></tr>
<%      total = 0 %>
<%		while not rec.eof%>
							<tr>
								<td><%=Sce.LinkEquipamento(rec("EQ_ID"), ConverteNuloHTML(rec("Código Barras_M")), False)%></td>
								<td><%=ConverteNuloHTML(IIf(Len(rec("Modelo_M")) > 10 , Left(rec("Modelo_M"), 10) & "...", rec("Modelo_M")))%></td>
								<td><%
									If CStr(rec("Cod. Status")) = CStr(STATUS_EM_USO) Then 
										Response.Write "<span class='text-danger'>"
                                    Else
										Response.Write "<span>"
									End If
									Response.Write ConverteNuloHTML(rec("Status_M")) & "</span>"
									%>
								</td>
								<td><%=ConverteNuloHTML(rec("EQ_LOCALIZACAO_M"))%></td>
							</tr>
<%			rec.moveNext
            total = total + 1
		wend %>
							<tr><td colspan="3" class="texto-direito"><small>Total de itens: <%=total%></small></td></tr>
<%	else
%>							<tr><td colspan="3"><small>Nenhum item encontrado</small></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table><%
End Sub


Sub ImprimeControlesNotaFiscalVencida()
	Dim s, s_xls, rec, int_TotalNota, url_xls, Titulo
	Dim sAvisoVenc
	Dim total

	Titulo = "Notas Fiscais Vencidas"
	int_TotalNota = 0

'vinculacao de equipamento com a nota é pela movimentacao - entrada logistica
	s = sqlNotaFiscalVencida
    s_xls = sqlNotaFiscalVencida

	url_xls = Link2Xls(Titulo, "NotaFiscalVencida")
%>
				<table class="largura-total table-condensed table-bordered">
				<tr>
					<td>
						<table class="largura-total table-condensed">
						<tr>
							<td><strong class="text-info">Notas Fiscais Vencidas</strong></td>
							<td class="texto-direito"><%=url_xls%>	</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<div style="overflow: auto; height: 190px;">
							<table class="largura-total table-bordered table-striped table-hover table-condensed">
<%	'response.write s
	Set rec = Env.oConn.Execute(s)
	if not (rec.eof and rec.bof) then
		int_AgNum = -1
		int_nfid = -1
%>
							<tr>
								<th>AS</th>
								<th>RT</th>
								<th>NF</th>
								<th>Vencimento</th>
								<th>Empresa</th>
								<th>Equipamento</th>
								<th>Descrição</th>
								<th>Local</th>
							</tr>
<%      total = 0
		'chr_User = "CTERRA"   'debug
		While Not rec.eof
			If (int_AgNum <> rec("AG_NUMERO_M")) Then
				chr_agnumero = rec("AG_NUMERO_M")
				chr_agrespon = rec("AG_RESPONSAVEL_M")
			Else
				chr_agnumero = "&nbsp;"
				chr_agrespon = "&nbsp;"
			End If
			If (int_nfid <> rec("NF_ID")) Then
				chr_nf = rec("NF_NUMERONOTA_M")
				chr_dtvenc = rec("NF_DATAVENCIMENTO_M")
				chr_empresa = ConverteNuloHTML(rec("ENF_NOME_M"))
				int_TotalNota = int_TotalNota + 1
			Else
				chr_nf = "&nbsp;"
				chr_dtvenc = "&nbsp;"
				chr_empresa = "&nbsp;"
			End If
			
			If CDate(rec("NF_DATAVENCIMENTO_M")) >= Date() Then
				sAvisoVenc = "bgcolor='#CCFF00' title='Nota fiscal à vencer em até 30 dias'"
			Else
				sAvisoVenc = ""
			End If
%>
							<tr <%If chr_User = UCase(rec("AG_RESPONSAVEL_M")) Then Response.Write "style= color:red;"%>>
								<td><%=chr_agnumero%></td>
								<td><%=chr_agrespon%></td>
								<td <%=sAvisoVenc%>><%=chr_nf%></td>
								<td <%=sAvisoVenc%>><%=chr_dtvenc%></td>
								<td><%=chr_empresa%></td>
								<td><%=Sce.LinkEquipamento(rec("EQ_ID"), rec("EQ_CODIGOBARRAS_M"), False)%></td>
								<td><%=ConverteNuloHTML(rec("MOD_CODNOME_M"))%></td>
								<td><%=ConverteNuloHTML(rec("EQ_LOCALIZACAO_M"))%></td>
							</tr>
<%
			int_AgNum = rec("AG_NUMERO_M")
			int_nfid = rec("NF_ID")
			rec.moveNext
			total = total + 1
		WEnd
%>
							<tr>
								<td colspan="8" class="texto-direito">
									<small>Total de Notas Fiscais: <%=int_TotalNota%></small>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<small>Total de itens: <%=total%></small>
								</td>
							</tr>
<%	else
%>							<tr><td colspan="8"><i>Nenhum item encontrado</i></td></tr><%
	end if%>				</table>
						</div>
					</td>
				</tr>
				</table><%
End Sub

Function ImprimeTipoManutencaoHTML(tipo)
	If tipo = CONTROLE_MANUTENCAO Then
		ImprimeTipoManutencaoHTML = "<strong class='text-danger' title='Corretiva'>c</strong>"
	ElseIf tipo = CONTROLE_MANUTENCAO_PREVENTIVA Then
		ImprimeTipoManutencaoHTML = "<strong class='text-warning' title='Preventiva'>p</strong>"
	End If
End Function


Function Link2Xls(titulo, qualSQL)
    'Link2Xls = "<div class='texto-direito'><a class='text-success' href='../excel.asp?titulo=" & titulo & "&sql=" & Server.UrlEncode(sql) & "' target='_blank' alt='Exporta esta listagem para o Excel'><strong>XLS</strong></a></div>"
    Link2Xls = "<div class='texto-direito'>" & _
               "     <a class='text-success' onclick='GerarXLS(""" & titulo & """, """ & qualSQL & """);' target='_blank' alt='Exporta esta listagem para o Excel'><strong>XLS</strong></a>" & _
               "</div>"
End Function
%>
