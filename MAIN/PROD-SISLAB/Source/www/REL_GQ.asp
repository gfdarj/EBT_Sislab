<%
Server.ScriptTimeout = 3500
%>
<!--#include file="includes/Sislab_Lib.asp"-->
<%
Dim dataIniCad, dataFimCad, dataIniCadRealSol, dataFimCadSol, Participante
Dim tempesquisa, dataIniFinalizadoReal, dataFimFinalizadoReal

sSQL = "" & VbCrLf
sSQL = sSQL & "DECLARE @id_situacao INT" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "SET @id_situacao = (SELECT id_situacao  FROM Situacoes WHERE S_OS = 0 AND s_descricao = 'Finalizado')" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "select * from (SELECT" & VbCrLf
sSQL = sSQL & "	a.AG_NUMERO AS Num_AS_M, " & VbCrLf
sSQL = sSQL & "	a.AG_TITULO AS 'Título AS_M', " & VbCrLf
sSQL = sSQL & "	Tot_OS.Total AS 'Nº_OS_Geradas_M'," & VbCrLf
sSQL = sSQL & "	a.AG_DATASOLICITACAO as 'Data_da_Solicitação_pelo_Cliente_M'," & VbCrLf
sSQL = sSQL & "	a.AG_DATAINICIO as 'Data_de_Início_Solicitada_pelo_Cliente_M', " & VbCrLf
sSQL = sSQL & "	a.AG_DATATERMINO as 'Data_de_Término_Solicitada_pelo_Cliente_M'," & VbCrLf
sSQL = sSQL & "	a.TEC_NOME as 'Tecnologia_M'," & VbCrLf
sSQL = sSQL & "	a.TA_ID," & VbCrLf
sSQL = sSQL & "	a.TA_DESCRICAO AS 'Tipo_Teste_M'," & VbCrLf
sSQL = sSQL & "	a.AG_SIGILO," & VbCrLf
sSQL = sSQL & "	a.TS_DESCRICAO as 'Tipo_de_Sigilo_M'," & VbCrLf
sSQL = sSQL & "	a.AG_RAT as 'RAT_M'," & VbCrLf
sSQL = sSQL & "	a.AG_NECESSITA_OS," & VbCrLf
sSQL = sSQL & "	a.ID_SITUACAO," & VbCrLf
sSQL = sSQL & "	a.S_DESCRICAO AS Situação_M," & VbCrLf
sSQL = sSQL & "	a.AG_RESPONSAVEL AS 'Responsável_Técnico_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	Hist_Min.Data_Min AS 'Data_Início_Execução_Real_M'," & VbCrLf
sSQL = sSQL & "	Hist_Max.Data_Max AS 'Data_Término_Execução_Real_M'," & VbCrLf
sSQL = sSQL & "	Hist_Final.Data_Max AS 'Data_Finalização_Real_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	a.AG_USERNAME as 'Solicitante_M'," & VbCrLf
sSQL = sSQL & "	a.AG_CLIENTEEXTERNO as 'Cliente_Externo_M'," & VbCrLf
sSQL = sSQL & "	a.AG_ORGAO as 'Órgão_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	CASE a.AG_NECESSITA_OS" & VbCrLf
sSQL = sSQL & "	WHEN 1 THEN " & VbCrLf
sSQL = sSQL & "		CASE " & VbCrLf
sSQL = sSQL & "		WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "			Tot_C.Total > 0" & VbCrLf
sSQL = sSQL & "			AND" & VbCrLf
sSQL = sSQL & "			Tot_C.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "		THEN 'TESTE ACREDITADO'" & VbCrLf
sSQL = sSQL & "		WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "			Tot_EmC.Total > 0" & VbCrLf
sSQL = sSQL & "			AND" & VbCrLf
sSQL = sSQL & "			Tot_EmC.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "		THEN 'TESTE PADRONIZADO'" & VbCrLf
sSQL = sSQL & "		ELSE" & VbCrLf
sSQL = sSQL & "			CASE" & VbCrLf
sSQL = sSQL & "			WHEN (D7.Diagramas) >= 1" & VbCrLf
sSQL = sSQL & "			THEN 'LAUDO ELABORADO' " & VbCrLf
sSQL = sSQL & "			ELSE 'LAUDO NÃO ELABORADO' " & VbCrLf
sSQL = sSQL & "			END" & VbCrLf
sSQL = sSQL & "		END" & VbCrLf
sSQL = sSQL & "	ELSE 'N/A'" & VbCrLf
sSQL = sSQL & "	END AS 'Laudo_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	CASE a.AG_NECESSITA_OS" & VbCrLf
sSQL = sSQL & "	WHEN 1 THEN " & VbCrLf
sSQL = sSQL & "		CASE" & VbCrLf
sSQL = sSQL & "		WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "			Tot_C.Total > 0" & VbCrLf
sSQL = sSQL & "			AND" & VbCrLf
sSQL = sSQL & "			Tot_C.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "		THEN 'TESTE ACREDITADO'" & VbCrLf
sSQL = sSQL & "		WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "			Tot_EmC.Total > 0" & VbCrLf
sSQL = sSQL & "			AND" & VbCrLf
sSQL = sSQL & "			Tot_EmC.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "		THEN 'TESTE PADRONIZADO'" & VbCrLf
sSQL = sSQL & "		ELSE" & VbCrLf
sSQL = sSQL & "			CASE" & VbCrLf
sSQL = sSQL & "			WHEN (D20.Diagramas) >= 1" & VbCrLf
sSQL = sSQL & "			THEN 'ROTEIRO ELABORADO' " & VbCrLf
sSQL = sSQL & "			ELSE 'ROTEIRO NÃO ELABORADO'" & VbCrLf
sSQL = sSQL & "			END" & VbCrLf
sSQL = sSQL & "		END" & VbCrLf
sSQL = sSQL & "	ELSE 'N/A'" & VbCrLf
sSQL = sSQL & "	END AS 'Roteiro_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	CASE a.AG_NECESSITA_OS" & VbCrLf
sSQL = sSQL & "	WHEN 1 THEN " & VbCrLf
sSQL = sSQL & "	CASE " & VbCrLf
sSQL = sSQL & "	WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "		Tot_C.Total > 0" & VbCrLf
sSQL = sSQL & "		AND" & VbCrLf
sSQL = sSQL & "		Tot_C.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "	THEN 'TESTE ACREDITADO'" & VbCrLf
sSQL = sSQL & "	WHEN	/*N. Testes certificados = N. Testes*/" & VbCrLf
sSQL = sSQL & "		Tot_EmC.Total > 0" & VbCrLf
sSQL = sSQL & "		AND" & VbCrLf
sSQL = sSQL & "		Tot_EmC.Total = Tot_OS.Total" & VbCrLf
sSQL = sSQL & "	THEN 'TESTE PADRONIZADO'" & VbCrLf
sSQL = sSQL & "	ELSE" & VbCrLf
sSQL = sSQL & "		CASE" & VbCrLf
sSQL = sSQL & "		WHEN (D33.Diagramas) >= 1" & VbCrLf
sSQL = sSQL & "		THEN 'RELATÓRIO ELABORADO' " & VbCrLf
sSQL = sSQL & "		ELSE 'RELATÓRIO NÃO ELABORADO' " & VbCrLf
sSQL = sSQL & "		END" & VbCrLf
sSQL = sSQL & "	END" & VbCrLf
sSQL = sSQL & "	ELSE 'N/A'" & VbCrLf
sSQL = sSQL & "	END AS 'Relatório_de_Ensaio_M'," & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "	CASE " & VbCrLf
sSQL = sSQL & "	WHEN a.ID_SITUACAO = id_situacao AND Pesq.Total > 0 THEN" & VbCrLf
sSQL = sSQL & "		'Sim'" & VbCrLf
sSQL = sSQL & "	ELSE " & VbCrLf
sSQL = sSQL & "		'Não'" & VbCrLf
sSQL = sSQL & "	END AS 'Pesquisa_de_Satisfação_M'" & VbCrLf
sSQL = sSQL & "FROM" & VbCrLf
sSQL = sSQL & "	vw_Agendamento a" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	    SELECT AG_NUMERO, MIN(heosR.HE_DATAINICIO) AS DATA_MIN FROM Historico_Eventos heosR " & VbCrLf
sSQL = sSQL & "	    WHERE 	heosR.ID_SITUACAO = 6 /*Em Execucao*/" & VbCrLf
sSQL = sSQL & "		    AND heosR.HE_DATAINICIO IS NOT NULL" & VbCrLf
sSQL = sSQL & "	    GROUP BY heosR.AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Hist_Min ON Hist_Min.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	    SELECT AG_NUMERO, MAX(heosR.HE_DATATERMINO) AS DATA_MAX FROM Historico_Eventos heosR" & VbCrLf
sSQL = sSQL & "	    WHERE	heosR.ID_SITUACAO = 6 /*Em Execucao*/" & VbCrLf
sSQL = sSQL & "		    AND heosR.HE_DATATERMINO IS NOT NULL" & VbCrLf
sSQL = sSQL & "	    GROUP BY heosR.AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Hist_Max ON Hist_Max.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	    SELECT AG_NUMERO, MAX(heosR.HE_DATATERMINO) AS DATA_MAX FROM Historico_Eventos heosR" & VbCrLf
sSQL = sSQL & "	    WHERE	heosR.ID_SITUACAO = 8 /* Finalizado */" & VbCrLf
sSQL = sSQL & "		    AND heosR.HE_DATATERMINO IS NOT NULL" & VbCrLf
sSQL = sSQL & "	    GROUP BY heosR.AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Hist_Final ON Hist_Final.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Pesquisa de satisfacao*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	SELECT PSQ_NAG as AG_NUMERO, COUNT(*) as TOTAL FROM PesquisaSatisfacao GROUP BY PSQ_NAG" & VbCrLf
sSQL = sSQL & "	) AS Pesq ON Pesq.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de Arquivos id=20*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	select AG_NUMERO, count(arq_codarqtipo) AS Diagramas" & VbCrLf
sSQL = sSQL & "	from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq" & VbCrLf
sSQL = sSQL & "	WHERE (arq1.arq_codarqtipo = 20 OR arq1.arq_codarqtipo = 18)" & VbCrLf
sSQL = sSQL & "	GROUP BY AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) D20 ON D20.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de Arquivos id=7*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	select AG_NUMERO, count(arq_codarqtipo) AS Diagramas" & VbCrLf
sSQL = sSQL & "	from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq" & VbCrLf
sSQL = sSQL & "	WHERE (arq1.arq_codarqtipo = 7 OR arq1.arq_codarqtipo = 18)" & VbCrLf
sSQL = sSQL & "	GROUP BY AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) D7 ON d7.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de Arquivos id=33*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	select AG_NUMERO, count(arq_codarqtipo) AS Diagramas" & VbCrLf
sSQL = sSQL & "	from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq" & VbCrLf
sSQL = sSQL & "	WHERE (arq_codarqtipo = 33)" & VbCrLf
sSQL = sSQL & "	GROUP BY AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) D33 ON D33.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de OS para testes Certificados*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	SELECT AG_NUMERO, COUNT(*) AS TOTAL FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE t1.TIT_ID = 3 /*CERTIFICADO*/ GROUP BY AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Tot_C ON Tot_C.AG_NUMERO = a.AG_NUMERO " & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de OS para uma AS*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	SELECT AG_NUMERO, COUNT(*) AS TOTAL FROM Ordem_de_Servico os GROUP BY os.AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Tot_OS ON Tot_OS.AG_NUMERO = a.AG_NUMERO" & VbCrLf
sSQL = sSQL & "" & VbCrLf
sSQL = sSQL & "/*Diz o total de OS para testes em Certificacao*/" & VbCrLf
sSQL = sSQL & "LEFT JOIN" & VbCrLf
sSQL = sSQL & "	(" & VbCrLf
sSQL = sSQL & "	SELECT AG_NUMERO, COUNT(*) AS TOTAL FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE t1.TIT_ID = 2 /*EM CERTIFICACAO*/ GROUP BY AG_NUMERO" & VbCrLf
sSQL = sSQL & "	) AS Tot_EmC ON Tot_EmC.AG_NUMERO = a.AG_NUMERO" & VbCrLf

sSQL = sSQL & "	) AS XXXX " & VbCrLf

sSQL = sSQL & "	WHERE 1 = 1 " & VbCrLf

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
	'sSQL = sSQL & " AND DATEDIFF(day, AG_DATASOLICITACAO, getDate()-" & soldias & ")<0 "
end if

if ini_dias <> "" then
	sSQL = sSQL & " AND DATEDIFF(day, Data_Início_Execução_Real_M,getDate()-" & ini_dias & ")<0 "
	'sSQL = sSQL & " AND DATEDIFF(day, Data_Min, getDate()-" & ini_dias & ")<0 "
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
    'sSQL = sSQL & " AND AG_RESPONSAVEL='" & auxRT & "' "
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
    sSQL = sSQL & " AND (ROTEIRO_M = 'ROTEIRO NÃO ELABORADO' AND AG_NECESSITA_OS = 1)"
END IF
If chkRelEnsaio Then
    sSQL = sSQL & " AND [Relatório_de_Ensaio_M] = 'RELATÓRIO NÃO ELABORADO' AND AG_NECESSITA_OS = 1"
    'sSQL = sSQL & " AND [Relatório_de_Ensaio_M] = 'RELATÓRIO NÃO ELABORADO' AND AG_NECESSITA_OS = 1"
End If

if tip_te <> "" then
    sSQL = sSQL & " AND TIPO_TESTE_M= '" & tip_te & "'"
    'sSQL = sSQL & " AND TA_DESCRICAO= '" & tip_te & "'"
end if

if sigilo <> "" then
    sSQL = sSQL & " AND AG_SIGILO=" & sigilo & ""
end if

if Participante <> "" then
	sSQL = sSQL & " and (EXISTS (SELECT DISTINCT pes.AG_NUMERO FROM Participantes_Externos pes WHERE (UPPER(pes.PE_NOME) LIKE '%" & Participante & "%' OR UPPER(pes.PE_USERNAME) LIKE '%" & Participante & "%') AND pes.AG_NUMERO = Num_AS_M) "
	sSQL = sSQL & " OR (Solicitante_M LIKE '%" & Participante & "%')) "

	'sSQL = sSQL & " and (EXISTS (SELECT DISTINCT pes.AG_NUMERO FROM Participantes_Externos pes WHERE UPPER(pes.PE_NOME) LIKE '%" & Participante & "%' OR UPPER(pes.PE_USERNAME) LIKE '%" & Participante & "%' AND pes.AG_NUMERO = a.AG_NUMERO) "
	'sSQL = sSQL & " OR (AG_USERNAME LIKE '%" & Participante & "%' )) "
end if


dataIniCad = Trim(request("diadataIniCad") & "/" & request("mesdataIniCad") & "/" & request("anodataIniCad"))
dataFimCad = Trim(request("diadataFimCad") & "/" & request("mesdataFimCad") & "/" & request("anodataFimCad"))

if dataIniCad <> "//" then
	sSQL = sSQL & " and Data_da_Solicitação_pelo_Cliente_M >= CONVERT(SMALLDATETIME,'" & dataIniCad & "',103) "
	'sSQL = sSQL & " and AG_DATASOLICITACAO >= CONVERT(SMALLDATETIME,'" & dataIniCad & "',103) "
end if
if dataFimCad <> "//" then
	sSQL = sSQL & " and Data_da_Solicitação_pelo_Cliente_M < (CONVERT(SMALLDATETIME,'" & dataFimCad & "',103)+1) "
	'sSQL = sSQL & " and AG_DATASOLICITACAO < (CONVERT(SMALLDATETIME,'" & dataFimCad & "',103)+1) "
end if

dataIniCadSol = Trim("'" & request("diadataIniCadSol") & "/" & request("mesdataIniCadSol") & "/" & request("anodataIniCadSol") & "'")
dataFimCadSol = Trim("'" & request("diadataFimCadSol") & "/" & request("mesdataFimCadSol") & "/" & request("anodataFimCadSol") & "'")

if dataIniCadSol <> "'//'" then
	sSQL = sSQL & " and Data_de_Início_Solicitada_pelo_Cliente_M >= CONVERT(SMALLDATETIME," & dataIniCadSol & ",103) "
	'sSQL = sSQL & " and AG_DATAINICIO >= CONVERT(SMALLDATETIME," & dataIniCadSol & ",103) "
end if
if dataFimCadSol <> "'//'" then
	'SQL = sSQL & " and Data_de_Término_Solicitada_pelo_Cliente_M < CONVERT(SMALLDATETIME," & dataFimCadSol & ",103)+1 "
	'sSQL = sSQL & " and AG_DATATERMINO < CONVERT(SMALLDATETIME," & dataFimCadSol & ",103)+1 "
end if

dataIniFinalizadoReal = Trim(request("diadataIniFinalizadoReal") & "/" & request("mesdataIniFinalizadoReal") & "/" & request("anodataIniFinalizadoReal"))
dataFimFinalizadoReal = Trim(request("diadataFimFinalizadoReal") & "/" & request("mesdataFimFinalizadoReal") & "/" & request("anodataFimFinalizadoReal"))

if dataIniFinalizadoReal <> "//" then
	sSQL = sSQL & " and Data_Finalização_Real_M >= CONVERT(SMALLDATETIME,'" & dataIniFinalizadoReal & "',103) " & VbCrLf
end if
if dataFimFinalizadoReal <> "//" then
	sSQL = sSQL & " and Data_Finalização_Real_M < (CONVERT(SMALLDATETIME,'" & dataFimFinalizadoReal & "',103)+1) " & VbCrLf
end if

sSQL = sSQL & " ORDER BY Num_AS_M" & VbCrLf


'RESPONSE.WRITE replace(sSQL, vbcrlf, "<br>")
'RESPONSE.END

'call Env.RecordSet(true, objSiteRS, sSQL)
'call criaExcel("Relatório", objSiteRS, null)

Session("XLS_EXPORTA_SQL") = sSQL
Response.Redirect "excel.asp?titulo=Relatório de Acompanhamento&sql="


'=============================================================================

Public Sub criaExcel(Titulo, objRS, ordenacao)
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
