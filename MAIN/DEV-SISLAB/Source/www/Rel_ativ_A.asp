<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
dim objConn
Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL_Dados, tot,auxbarq, objsiteCRT
Dim auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, auxorgao, auxtecnologia, auxorgaosel,auxAs
Dim dataIniCad, dataFimCad
Dim auxTeste, auxServico
Dim auxcmbTipoTeste

Dim auxAmbiente
Dim auxcodigobarras
Dim auxPlataforma
Dim auxExecutante
Dim auxRepeticao
Dim auxSigilo
Dim auxTemOS
Dim auxTemComentario
Dim auxNomeCliente

EH_CRT = Env.UsuarioCRT()

contte=0
contat=0

if (request.QueryString("rat")<>"") then
	auxRAT=Ucase(request.QueryString("rat"))
	auxdiasteste=90
end if

auxAmbiente = Trim(request("ambiente"))
auxcodigobarras = Trim(request("codigobarras"))
auxPlataforma = request("plataforma")
auxExecutante = request("chkexecutanteCRT")
auxRepeticao = request("chkrepeticao")
auxSigilo = request("sigilo")

auxRT = request("rt")
auxRAT = request("rat")
auxtipoteste = request("tipoteste")
auxsituacaoteste = request("situacaoteste")
auxdiasteste = request("diasteste")
auxdescricao = Trim(request("descricao"))
auxsolicitante = UCase(request("solicitante"))
auxtecnologia = request("tecnologia")
auxorgaosel = request("orgao")
auxAs = Trim(request("auxAs"))
auxClientes = (request("chkClientes")="on")
auxTemOS = (request("chkTemOS")="on")
auxTemComentario = (request("chkTemComentario")="on")
auxNomeCliente = Trim(Request("clientes"))
auxcmbTipoTeste = request("cmbTipoTeste")

auxParticipante = Trim(UCase(Trim(request("Participante"))))
auxTeste = request("teste")
auxServico = request("servico")
chr_TipoTestes = ""
tot=0

sSQL = ""
sSQL_Dados = _
	"Select a.*, CONVERT(VARCHAR, AG_DATAINICIO, 103) AS AG_DATAINICIO_F, CONVERT(VARCHAR, AG_DATATERMINO, 103) AS AG_DATATERMINO_F " & VbCrLf & _
    "From vw_Agendamento a " & VbCrLf

if auxParticipante <> "" then
	sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT pes.AG_NUMERO FROM Participantes_Externos pes WHERE UPPER(pes.PE_NOME) LIKE '%" & auxParticipante & "%' OR UPPER(pes.PE_USERNAME) LIKE '%" & auxParticipante & "%') AS pes ON pes.AG_NUMERO = a.AG_NUMERO " & VbCrLf
end if

if auxTeste <> "" then
	sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT AG_NUMERO FROM Ordem_de_Servico WHERE T_ID = " & auxTeste & ") AS os ON os.AG_NUMERO = a.AG_NUMERO "
end if

If auxcmbTipoTeste <> "" Then
	sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT AG_NUMERO FROM Ordem_de_Servico os INNER JOIN Testes t ON os.T_ID = t.T_ID WHERE t.TIT_ID = " & auxcmbTipoTeste & ") AS os1 ON os1.AG_NUMERO = a.AG_NUMERO "
End If

If auxcodigobarras <> "" Then
	'sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT os.AG_NUMERO FROM Ordem_de_Servico os INNER JOIN SCE_Equipamentos eq1 " & _
	'	"ON os.EQ_ID_AMOSTRA = eq1.EQ_ID WHERE eq1.EQ_CODIGOBARRAS = '" & auxcodigobarras & "') AS os2 ON os2.AG_NUMERO = a.AG_NUMERO "
	sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT ASA FROM SCE_Movimentacao m INNER JOIN SCE_Equipamentos e ON m.EQ_ID = e.EQ_ID WHERE ASA IS NOT NULL AND e.EQ_CODIGOBARRAS = '" & auxcodigobarras & "') AS Eq1 ON Eq1.ASA = a.AG_NUMERO  "
End If

If auxAmbiente <> "" Then
	sSQL_Dados = sSQL_Dados & " INNER JOIN (SELECT DISTINCT RAM_AS FROM Reserva_Ambientes WHERE AMB_ID = " & auxAmbiente & ") AS ram ON ram.RAM_AS = a.AG_NUMERO "
End If


sSQL = "Where 1 = 1 "


if auxdiasteste <> "" then
	sSQL = sSQL & " AND DATEDIFF(day, AG_DATASOLICITACAO, getDate()-" & auxdiasteste & ") < 0 "
end if


If auxTemOS = True then
	sSQL = sSQL & " AND a.AG_NECESSITA_OS = 1"
End If

If auxTemComentario = True Then
	sSQL = sSQL & " AND (a.AG_RELAT_RAT IS NOT NULL OR a.AG_RELAT_RT IS NOT NULL)"
End If

if auxServico <> "" then
	sSQL = sSQL & " AND (" & _
		"(SELECT COUNT(*) FROM Agenda_Servicos_Plataforma os " & _
		"WHERE S_ID = " & auxServico & " AND os.AG_NUMERO = a.AG_NUMERO) > 0 " & _
		"OR " & _
		"(SELECT COUNT(*) FROM Ordem_De_Servico os " & _
		"WHERE S_ID_SERVICO = " & auxServico & " AND os.AG_NUMERO = a.AG_NUMERO) > 0 " & _
		")"
end if

if auxtipoteste<>"" then
	sSQL=sSQL&" AND TA_ID = " & auxtipoteste & " "
end if

if auxSituacaoteste <> "" And auxSituacaoteste <> "NC" then
    sSQL=sSQL&" AND ID_SITUACAO="&auxsituacaoteste&" "
end if

if auxSituacaoteste = "NC" then
    sSQL=sSQL&" AND ID_SITUACAO IN(1,2,3,6,7) "
end if

if auxRT<>"" then
    sSQL=sSQL&" AND AG_Responsavel = '"&auxRT&"' "
end if

if auxRAT<>"" then
    sSQL=sSQL&" AND AG_RAT='"&auxRAT&"' "
end if

if auxAS<>"" then
    sSQL=sSQL&" AND AG_NUMERO=" & auxAS
end if

if auxsolicitante<>"" then
    sSQL=sSQL&" AND UPPER(AG_USERNAME)='"&auxsolicitante&"' "
end if

if auxtecnologia<>"" then
    sSQL=sSQL&" AND TEC_NOME='"&auxtecnologia&"' "
end if

if auxorgaosel<>"" then
    sSQL=sSQL&" AND AG_ORGAO = '" & auxorgaosel & "' "
end if

if auxdescricao<>"" then
    sSQL = sSQL & " " & _
		"AND ( (AG_TITULO like '%"&auxdescricao&"%') OR (AG_OBJETIVO like '%" & auxdescricao & "%') OR " & _
		"EXISTS (" & _
			"SELECT AG_NUMERO FROM Agenda_Servicos_Plataforma asp INNER JOIN " & _
			"Servicos_Plataformas sp ON asp.S_ID = sp.S_ID WHERE asp.AG_NUMERO = a.AG_NUMERO AND sp.S_DESCRICAO LIKE '%" & auxdescricao & "%') ) "
end if

If auxClientes = True Then
	If auxNomeCliente = "" Then
	    sSQL = sSQL & " AND (AG_CLIENTEEXTERNO Is NOT Null AND AG_CLIENTEEXTERNO <> '')"
	Else
	    sSQL = sSQL & " AND (AG_CLIENTEEXTERNO LIKE '" & auxNomeCliente & "%')"
	End If
End If

'----->>>>>> PARAMETROS INCLUIDOS EM 24/01/2006 	AQUI !!!

If auxPlataforma <> "" Then
	sSQL = sSQL & " AND (" & _
		"(SELECT COUNT(*) FROM Agenda_Servicos_Plataforma os " & _
		"WHERE S_ID = " & auxPlataforma & " AND os.AG_NUMERO = a.AG_NUMERO) > 0 " & _
		"OR " & _
		"(SELECT COUNT(*) FROM Ordem_De_Servico os " & _
		"WHERE S_ID_PLATAFORMA = " & auxPlataforma & " AND os.AG_NUMERO = a.AG_NUMERO) > 0 " & _
		")"
End If

If auxExecutante <> "" Then
	sSQL = sSQL & "AND AG_EXECUTANTE = 1 "
End If

If auxRepeticao <> "" Then
	sSQL = sSQL & "AND AG_REPETIDO = 1 "
End If

If auxSigilo <> "" Then
	sSQL = sSQL & "AND AG_SIGILO = " & auxSigilo & " "
End If
'----->>>>>> FIM: PARAMETROS INCLUIDOS EM 24/01/2006 	AQUI !!!


dataIniCad = Trim(request("diadataIniCad") & "/" & request("mesdataIniCad") & "/" & request("anodataIniCad"))
dataFimCad = Trim(request("diadataFimCad") & "/" & request("mesdataFimCad") & "/" & request("anodataFimCad"))

if dataIniCad <> "//" then
	sSQL = sSQL & " and a.AG_DATASOLICITACAO >= CONVERT(SMALLDATETIME,'" & dataIniCad & "',103) "
end if
if dataFimCad <> "//" then
	sSQL = sSQL & " and a.AG_DATASOLICITACAO < (CONVERT(SMALLDATETIME,'" & dataFimCad & "',103)+1) "
end if

dataIniCadSol = Trim("'" & request("diadataIniCadSol") & "/" & request("mesdataIniCadSol") & "/" & request("anodataIniCadSol") & "'")
dataFimCadSol = Trim("'" & request("diadataFimCadSol") & "/" & request("mesdataFimCadSol") & "/" & request("anodataFimCadSol") & "'")

if dataIniCadSol <> "'//'" then
	sSQL = sSQL & " and AG_DATAINICIO >= CONVERT(SMALLDATETIME," & dataIniCadSol & ",103) "
end if
if dataFimCadSol <> "'//'" then
	sSQL = sSQL & " and AG_DATATERMINO < CONVERT(SMALLDATETIME," & dataFimCadSol & ",103)+1 "
end if

sSQL_Dados = sSQL_Dados & " " & sSQL & " ORDER BY a.AG_NUMERO DESC; "

'response.write sSQL_Dados
'response.end
%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta charset="utf-8" />
    </head>
    <body>
    <form method="post" action="rel_ativ_b.asp">
        <input type="hidden" name="ssql" value="<%=sSQL_Dados%>">
    </form>
    <script type="text/javascript">
        var frm = document.forms[0]
        frm.submit()
    </script>
    </body>
</html>

