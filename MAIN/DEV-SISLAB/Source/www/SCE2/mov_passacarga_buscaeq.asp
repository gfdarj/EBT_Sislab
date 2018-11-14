<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<html>
<body>
<%
'-- PROCURA E PREENCHE O <SELECT> DO FORMULARIO DE MOV. PASSAGEM DE CARGA
'-- PARA O CASO DE SER O AGENDAMENTO ORIGEM OU DESTINO

Dim agnumero, qual_agendamento, s, rec

qual_agendamento = LCase(request("qual_agendamento"))
if qual_agendamento = "" then response.end

agnumero = request("ag_numero_" & qual_agendamento)
%>
<script type="text/javascript">
	var w = window.parent;
	var oOption;

	w.document.forms[0].eq_<%=qual_agendamento%>.length = 0;
	w.document.all.responsavel_<%=qual_agendamento%>.innerText = "";
<%
if agnumero <> "" then
	if qual_agendamento = "origem" then
		'-- pego os equipamentos na qual a ultima movimentacao foi de saida da logistica
		'-- alem disso verificando se existe algum outro agendamento com reserva coincidente com 
		'-- periodos coincidentes
		s =	"SELECT * " & _
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

		'--
		'-- Nao sei por qual razao esta query nao funciona. Resolvi criando a view usada acima
		'--
		's =	"SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_DESCRICAO, u.NOME AS NOME_RESPONSAVEL, RESERVA " & _
		'	"FROM vw_SCE_Movimentacao_Atual m INNER JOIN vw_SCE_Equipamentos_Fabricantes e " & _
		'	"ON m.EQ_ID = e.EQ_ID INNER JOIN SCE_Natureza_Operacao no ON m.NO_ID = no.NO_ID " & _
		'	"INNER JOIN Agendamento a ON a.AG_NUMERO = m.ASA INNER JOIN UserCRT u " & _
		'	"ON u.USERID = a.AG_RESPONSAVEL " & _
		'	"WHERE no.ASA = 1 AND no.NO_TIPO = " & MOV_LOGISTICA_SAIDA & " AND m.ASA = " & agnumero & " " & _
		'	"AND " & _
		'	"e.EQ_ID NOT IN " & _
		'	"( /* verifico se tem reserva para outros agendamentos no periodo */ " & _
		'	"	SELECT EQ_ID " & _
		'	"	FROM SCE_Reserva_Equipamentos re " & _
		'	"	WHERE re.AG_NUMERO <> m.ASA " & _
		'	"		AND ( " & _
		'	"			NOT (re.REQ_DATAINICIO BETWEEN a.AG_DATAINICIO AND a.AG_DATATERMINO) " & _
		'	"			OR NOT (re.REQ_DATATERMINO BETWEEN a.AG_DATAINICIO AND a.AG_DATATERMINO) " & _
		'	"		) " & _
		'	") " & _
		'	"ORDER BY e.EQ_CODIGOBARRAS"
	else '-- destino
		s =	"SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, CONVERT(varchar, p.PAS_DATAPASSAGEM, 103) " & _
			"AS PAS_DATAPASSAGEM, u.NOME AS NOME_RESPONSAVEL " & _
			"FROM vw_SCE_Equipamentos_Fabricantes e inner join " & _
			"SCE_Passagem_Carga p on e.EQ_ID = p.EQ_ID inner join Agendamento a ON " & _
			"a.AG_NUMERO = p.AG_NUMERO_DEST left join UserCRT u on u.USERID = a.AG_RESPONSAVEL " & _
			"WHERE p.PAS_APROVADO = 0 AND p.AG_NUMERO_DEST = " & agnumero & " ORDER BY EQ_CODIGOBARRAS"
	end if

	'response.write s
	'response.end

	Set rec = Env.oConn.Execute(s)
	if not (rec.eof and rec.bof) then%>
	//w.document.all.responsavel_<%'=qual_agendamento%>.innerText = "<%'=rec("NOME_RESPONSAVEL")%>";

<%		While not rec.eof %>

	oOption = w.document.createElement("OPTION");

	w.document.forms[0].eq_<%=qual_agendamento%>.add(oOption);

<%			s = rec("EQ_CODIGOBARRAS") & " - " & Replace(Replace(UCase(rec("MOD_CODNOME")), "<BR>", " "), VbCrLf, " ")
			if qual_agendamento = "destino" then
				s = s & " (solicitado em: " & rec("PAS_DATAPASSAGEM") & ")"
			else
				if rec("RESERVA") then
					s = s & " (Alocado por reserva)"
				end if
			end if
%>
	oOption.innerText = "<%=s%>";
	oOption.value = <%=rec("EQ_ID")%>;

	//oOption.selected = true;

<%			rec.movenext
		wend
	end if
end if
%>
</script>
<!--
<%
response.write s
'response.end
%>
-->
</body>
</html>