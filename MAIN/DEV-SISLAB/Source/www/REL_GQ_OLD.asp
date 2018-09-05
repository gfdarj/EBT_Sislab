<!--#include file="includes/Sislab_Lib.asp"-->
<%
Server.ScriptTimeout = 5000

Dim dataIniCad, dataFimCad, dataIniCadRealSol, dataFimCadSol, Participante
Dim tempesquisa

sSQL  = "Select CG.*, " & VbCrLf & _
		"/* RETIRAR ESTA PARTE QUANDO COLOCAR ALGO DE SQL NA PRODUCAO !!!! */" & VbCrLf & _
		"CASE CG.AG_NECESSITA_OS" & VbCrLf & _
		"	WHEN 1 THEN " & VbCrLf & _
		"		CASE " & VbCrLf & _
		"		WHEN	/* N. Testes certificados = N. Testes) */" & VbCrLf & _
		"			(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = CG.num_AG_M AND t1.TIT_ID = 3 /*CERTIFICADO*/) > 0" & VbCrLf & _
		"			AND" & VbCrLf & _
		"			(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = CG.num_AG_M AND t1.TIT_ID = 3 /*CERTIFICADO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = CG.num_AG_M)" & VbCrLf & _
		"		THEN 'TESTE ACREDITADO'" & VbCrLf & _
		"		WHEN	/* N. Testes certificados = N. Testes) */" & VbCrLf & _
		"			(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = CG.num_AG_M AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) > 0" & VbCrLf & _
		"			AND" & VbCrLf & _
		"			(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = CG.num_AG_M AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = CG.num_AG_M)" & VbCrLf & _
		"		THEN 'TESTE PADRONIZADO'" & VbCrLf & _
		"		ELSE" & VbCrLf & _
		"			CASE" & VbCrLf & _
		"			WHEN	(" & VbCrLf & _
		"				select count(arq_codarqtipo)" & VbCrLf & _
		"				from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq " & VbCrLf & _
		"				WHERE (arq_codarqtipo = 33) " & VbCrLf & _
		"				and d.AG_NUMERO = CG.num_AG_M) >= 1" & VbCrLf & _
		"			THEN 'RELATÓRIO ELABORADO' " & VbCrLf & _
		"			ELSE 'RELATÓRIO NÃO ELABORADO' " & VbCrLf & _
		"			END" & VbCrLf & _
		"		END" & VbCrLf & _
		"	ELSE 'N/A'" & VbCrLf & _
		"END AS 'Relatório_de_Ensaio_M'" & VbCrLf & _
		"from vw_ConsultaGerencial CG where CG.num_AG_M = CG.num_AG_M  "

'response.write sSQL & "<BR>"
'response.end

soldias = request("sol_dias")
auxSituacaoteste = request("situacao")
auxRT = request("rt")
sigilo = request("tiposigilo")
ini_dias = request("ini_dias")
tempesquisa = request("tempesquisa")

auxLaudo = (request.form("chkLaudo")="on")
auxRoteiro = (request.form("chkRoteiro")="on")
auxEquipSis = (request.form("chkEquipSis")="on")
auxRelEnsaio = (request.form("chkRelEnsaio")="on")
tip_te = request.form("tip_te")

Participante = UCase(Trim(request("Participante")))

if soldias <> "" then
	sSQL = sSQL & " AND DATEDIFF(day, Data_da_Solicitação_pelo_Cliente_M, getDate()-" & soldias & ")<0 "
end if

if ini_dias <> "" then
	sSQL = sSQL & " AND DATEDIFF(day, Data_de_Início_Real_M,getDate()-" & ini_dias & ")<0 "
end if

if auxSituacaoteste<>"" And auxSituacaoteste<>"NC" then
    sSQL = sSQL & " AND ID_SITUACAO=" & auxsituacaoteste & ""
end if

If tempesquisa <> "" Then
    sSQL = sSQL & " AND Pesquisa_de_Satisfação_M = '" & tempesquisa & "'"
End IF

if auxSituacaoteste="NC" then
    sSQL = sSQL & " AND ID_SITUACAO IN(1,2,3,6,7) "
end if

if auxRT <> "" then
    sSQL = sSQL & " AND Responsável_Técnico_M='" & auxRT & "' "
end if

'-- necessidade de roteiro/laudo se da pela necessidade de criacao de OS já que
'-- agendamentos com OS SEMPRE possuem roteiro/laudo
if auxEquipSis then
	'sSQL = sSQL & " AND TIPO_TESTE IN (1,2,3,5,10,11)"
	sSQL = sSQL & " AND AG_NECESSITA_OS = 1"
end if
IF auxLaudo THEN
    sSQL = sSQL & " AND LAUDO_M = 'LAUDO NÃO ELABORADO' AND AG_NECESSITA_OS = 1"
END IF
IF auxRoteiro THEN
    sSQL = sSQL & " AND ROTEIRO_M = 'ROTEIRO NÃO ELABORADO' AND AG_NECESSITA_OS = 1"
END IF
If chkRelEnsaio Then
    sSQL = sSQL & " AND [Relatório_de_Ensaio_M] = 'RELATÓRIO NÃO ELABORADO' AND AG_NECESSITA_OS = 1"
End If

if tip_te <> "" then
    sSQL = sSQL & " AND TIPO_TESTE_M= '" & tip_te & "'"
end if

if sigilo <> "" then
    sSQL = sSQL & " AND AG_SIGILO=" & sigilo & ""
end if

if Participante <> "" then
	sSQL = sSQL & " and (EXISTS (SELECT DISTINCT pes.AG_NUMERO FROM Participantes_Externos pes WHERE UPPER(pes.PE_NOME) LIKE '%" & Participante & "%' OR UPPER(pes.PE_USERNAME) LIKE '%" & Participante & "%' AND pes.AG_NUMERO = Num_AG_M) "
	sSQL = sSQL & " OR (Solicitante_M LIKE '%" & Participante & "%' )) "
end if


dataIniCad = Trim(request("diadataIniCad") & "/" & request("mesdataIniCad") & "/" & request("anodataIniCad"))
dataFimCad = Trim(request("diadataFimCad") & "/" & request("mesdataFimCad") & "/" & request("anodataFimCad"))

if dataIniCad <> "//" then
	sSQL = sSQL & " and Data_da_Solicitação_pelo_Cliente_M >= CONVERT(SMALLDATETIME,'" & dataIniCad & "',103) "
end if
if dataFimCad <> "//" then
	sSQL = sSQL & " and Data_da_Solicitação_pelo_Cliente_M < (CONVERT(SMALLDATETIME,'" & dataFimCad & "',103)+1) "
end if

dataIniCadSol = Trim("'" & request("diadataIniCadSol") & "/" & request("mesdataIniCadSol") & "/" & request("anodataIniCadSol") & "'")
dataFimCadSol = Trim("'" & request("diadataFimCadSol") & "/" & request("mesdataFimCadSol") & "/" & request("anodataFimCadSol") & "'")

if dataIniCadSol <> "'//'" then
	sSQL = sSQL & " and Data_de_Início_Solicitada_pelo_Cliente_M >= CONVERT(SMALLDATETIME," & dataIniCadSol & ",103) "
end if
if dataFimCadSol <> "'//'" then
	sSQL = sSQL & " and Data_de_Término_Solicitada_pelo_Cliente_M < CONVERT(SMALLDATETIME," & dataFimCadSol & ",103)+1 "
end if

sSQL = sSQL & " ORDER BY NUM_AG_M"

'RESPONSE.WRITE sSQL
'RESPONSE.END

call Env.RecordSet(true, objSiteRS, sSQL)
call criaExcel("Relatório", objSiteRS, null)

	Public Sub criaExcel( Titulo, objRS, ordenacao)
		Dim str
		if not(isNull(ordenacao) or ordenacao = "") then _
			objRS.SORT = trocaAspasColchetes(ordenacao)
		Call montaListagemExcel( objRS, Titulo, Null, Null,str )
		str = "<HTML><HEAD><META HTTP-EQUIV=""Content-Type"" CONTENT=""application/vnd.ms-excel""><title>teste</title></HEAD><BODY>" & str & "</BODY></HTML>"
		Response.ContentType = "application/excel"
		Response.Clear
		'Se tirarmos o attachment da linha baixo, ele não vai pedir 2 vezes pra abrir, mas vai abrir na própria janela...
		Response.AddHeader "Content-Disposition", "filename=" & chr(34) & "Relatorio.xls" & chr(34)
		Response.Write (str)
		'Response.end
	End Sub

	Sub montaListagemExcel( objRecordSet, Titulo, Link, Acao,str )
		Dim tmp, cont, exibeLink

		cont = 0

		If( NOT( isNull(Acao) ) )Then
			Acao = Left(Acao, inStr(Acao, ")")-1)
		End If

		cont = 0
		str = str & "<TABLE cellspacing=1 cellpadding=1 border=1>"

		If( NOT( isNull( Titulo ) ) )Then
			str = str & "<tr bordercolor=""white""><td align=center colspan=5 bordercolor=""white""><FONT size=2 color""#CCCC00""><b>" & Titulo & "</b></FONT></TD></TR>"
			str = str & "<tr bordercolor=""white""><td colspan=5></tr></td>"
		End If

		If( NOT( objRecordSet.EOF ) )Then
			'<!-- Cabeçalho da tabela -->
			str = str & "<TR>"
			For each tmp in objRecordSet.Fields
				If(tmp.Name <> "ID" and Right(tmp.Name, 2) = "_M")Then
					str = str & "<td bgcolor=""black""><b><FONT color=""white"">" & replace(replace(tmp.Name,"_M",""),"_"," ") & "</b></font></td>"
				End If
			Next
			str = str & "</tr>"

			'<!-- Elementos da tabela -->
			While( NOT( objRecordSet.EOF ) )
				exibeLink = True
				If( (cont Mod 2) = 0)Then
			    	 str = str & "<tr bgcolor=""Silver"">"
				Else
				     str = str & "<tr>"
				End If

				For each tmp in objRecordSet.Fields
					If(tmp.Name <> "ID" and Right(tmp.Name, 2) = "_M")Then
						str = str & "<td>"
						If(isNull(Link) AND isNull(Acao) AND NOT(isNull(tmp.Value)))Then
							If tmp.Type = adCurrency Then
								str = str & FormatCurrency(Replace(trim(tmp.Value), "_¿", ""))
							ElseIf tmp.Type = adNumeric Then
								str = str & FormatNumber(Replace(trim(tmp.Value), "_¿", ""), 2)
							Else
								str = str & Replace(trim(tmp.Value), "_¿", "")
							End If
						End If
						str = str & "&nbsp;</td>"
						exibeLink = False
					End If
				Next
				objRecordSet.MoveNext
				cont = cont + 1
			str = str & "</tr>"
		Wend
	Else
		str = str & "<tr>"
		str = str & "<td>Sua consulta não retornou nenhum registro!</td>"
		str = str & "</tr>"
	End If
	str = str & "</table>"
	End Sub
%>
