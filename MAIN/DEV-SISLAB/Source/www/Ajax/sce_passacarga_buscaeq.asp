<!------- SCE ------->
<!--#include file="../sce2/includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->

<%
Dim agnumero, qual_agendamento, s, rec, SQL

s = ""
qual_agendamento = LCase(request("qual_agendamento"))
agnumero = request("agendamento")

If qual_agendamento = "origem" Then
	'-- pego os equipamentos na qual a ultima movimentacao foi de saida da logistica
	'-- alem disso verificando se existe algum outro agendamento com reserva coincidente com 
	'-- periodos coincidentes
	SQL = "SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, NULL AS [PAS_DATAPASSAGEM], e.NOME_RESPONSAVEL, e.RESERVA " & _
		"FROM vw_SCE_Equipamentos_a_PassarCarga e " & _
		"WHERE e.AG_NUMERO = " & agnumero & " " & _
		"AND " & _
		"e.EQ_ID NOT IN " & _
		"( /* verifico se tem reserva para outros agendamentos no periodo */ " & _
		" 	SELECT re.EQ_ID  " & _
		"        FROM SCE_Reserva_Equipamentos re, SCE_Reserva_Equipamentos re1  " & _
		"        WHERE (re.AG_NUMERO = " & agnumero & ") AND (re.AG_NUMERO <> re1.AG_NUMERO) " & _
		"		AND (re.EQ_ID = re1.EQ_ID) " & _
		" 		AND ( " & _
		"		(re.REQ_DATAINICIO BETWEEN re1.REQ_DATAINICIO  AND re1.REQ_DATATERMINO) " & _
		"		OR (re.REQ_DATATERMINO BETWEEN re1.REQ_DATAINICIO AND re1.REQ_DATATERMINO)  " & _
		"		) " & _
		") " & _
		"ORDER BY e.EQ_CODIGOBARRAS"
Else '-- destino
	SQL = "SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, CONVERT(varchar, p.PAS_DATAPASSAGEM, 103) " & _
		"AS PAS_DATAPASSAGEM, u.NOME AS NOME_RESPONSAVEL, NULL AS [RESERVA] " & _
		"FROM vw_SCE_Equipamentos_Fabricantes e inner join " & _
		"SCE_Passagem_Carga p on e.EQ_ID = p.EQ_ID inner join Agendamento a ON " & _
		"a.AG_NUMERO = p.AG_NUMERO_DEST left join UserCRT u on u.USERID = a.AG_RESPONSAVEL " & _
		"WHERE p.PAS_APROVADO = 0 AND p.AG_NUMERO_DEST = " & agnumero & " ORDER BY EQ_CODIGOBARRAS"
End If

'response.write sql
'response.end

Set rec = Env.oConn.Execute(SQL)

If Not (rec.eof and rec.bof) Then

	While not rec.eof
		s = s & rec("EQ_ID") & "[val]" & rec("EQ_CODIGOBARRAS") & " - " & Trim(Replace(Replace(UCase(rec("MOD_CODNOME")), "<BR>", " "), VbCrLf, " "))
		if qual_agendamento = "destino" then
			s = s & " (solicitado em: " & rec("PAS_DATAPASSAGEM") & ")"
		else
			if rec("RESERVA") then
				s = s & " (Alocado por reserva)"
			end if
		end if
        s = s & "[fim]"

		rec.MoveNext
	WEnd
End If

Set rec = Nothing

'response.write "SQL: " & SQL
'response.end

Response.Write (s)
%>
