<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_mensagem.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<%
Dim objSP, i
Dim auxusernameCadastro, auxIPCadastro, auxNAg
Dim auxNome, auxTelefone, auxEmail
Dim auxorgaoEmpresa, auxorigem
Dim auxR1, auxR2, auxR3, auxR4, auxR5, auxR6 
Dim auxR7, auxR8, auxR9, auxR10, auxR11
Dim auxC1, auxC2, auxC3, auxC4, auxC5, auxC6 
Dim auxC7, auxC8, auxC9, auxC10, auxC11
Dim auxC_3, auxC_4, pesqid
Dim bln_EnviaEmailRtGq
Dim iTot_AS : iTot_AS = 0

'auxusernameCadastro=UCase(trim(mid(Request.ServerVariables("REMOTE_USER"),10)))
auxusernameCadastro=UCase(Trim(Request("fUsername")))
auxIPCadastro = UCase(request.ServerVariables("REMOTE_ADDR"))

pesqid = request("pesqID")
if pesqid = "" or pesqid = "0" then 
	pesqid = null
	bln_EnviaEmailRtGq = True
Else
	bln_EnviaEmailRtGq = False
End If

auxNAg = request("ag_numero")

arrAG = Split(auxNAg, ",")		'### Array de AS´s

auxNome =  trocaPlic2Aspas(request("fNome"))
if auxNome = "" then auxNome = null
auxTelefone= trocaPlic2Aspas(request("fRamal"))
if auxTelefone = "" then auxTelefone = null
auxEmail =  trocaPlic2Aspas(request("fEmail"))
if auxEmail = "" then auxEmail = null
auxOrgaoEmpresa = request("fOrgao")
if auxOrgaoEmpresa = "" then auxOrgaoEmpresa = null
auxOrigem= trocaPlic2Aspas(request("opttipousu"))
if auxOrigem = "" then auxOrigem = null

auxR1 = trocaPlic2Aspas(request("comunica"))
if auxR1 = "" then auxR1 = null
auxR2= trocaPlic2Aspas(request("cortesia"))
if auxR2 = "" then auxR2 = null
auxR3= trocaPlic2Aspas(request("presteza"))
if auxR3 = "" then auxR3 = null
auxR4= trocaPlic2Aspas(request("flexibilidade"))
if auxR4 = "" then auxR4 = null
auxR5= trocaPlic2Aspas(request("rapidez"))
if auxR5 = "" then auxR5 = null
auxR6= trocaPlic2Aspas(request("iniciativa"))
if auxR6 = "" then auxR6 = null
auxR7= trocaPlic2Aspas(request("confiabilidade"))
if auxR7 = "" then auxR7 = null
auxR8= trocaPlic2Aspas(request("infraestrutura"))
if auxR8 = "" then auxR8 = null
auxR9= trocaPlic2Aspas(request("ambiente"))
if auxR9 = "" then auxR9 = null
auxR10= trocaPlic2Aspas(request("acesso"))
if auxR10 = "" then auxR10 = null
auxR11= trocaPlic2Aspas(request("geral"))
if auxR11 = "" then auxR11 = null
auxC1= trocaPlic2Aspas(request("com_comunica"))
if auxC1 = "" then auxC1 = null
auxC2= trocaPlic2Aspas(request("com_cortesia"))
if auxC2 = "" then auxC2 = null
auxC3= trocaPlic2Aspas(request("com_presteza"))
if auxC3 = "" then auxC3 = null
auxC4= trocaPlic2Aspas(request("com_flexibilidade"))
if auxC4 = "" then auxC4 = null
auxC5= trocaPlic2Aspas(request("com_rapidez"))
if auxC5 = "" then auxC5 = null
auxC6= trocaPlic2Aspas(request("com_iniciativa"))
if auxC6 = "" then auxC6 = null
auxC7= trocaPlic2Aspas(request("com_confiabilidade"))
if auxC7 = "" then auxC7 = null
auxC8= trocaPlic2Aspas(request("com_infraestrutura"))
if auxC8 = "" then auxC8 = null
auxC9= trocaPlic2Aspas(request("com_ambiente"))
if auxC9 = "" then auxC9 = null
auxC10= trocaPlic2Aspas(request("com_acesso"))
if auxC10 = "" then auxC10 = null
auxC11= trocaPlic2Aspas(request("com_geral"))
if auxC11 = "" then auxC11 = ""

auxC_3= trocaPlic2Aspas(request("comenta_adicionais"))
if auxC_3 = "" then auxC_3 = null

auxC_4 =  trocaPlic2Aspas(request("comenta_outros"))
if auxC_4 = "" then auxC_4 = null

'For i=0 To UBound(arrAG)
'	rw arrAG(i) & "<BR><BR>"
'next
're

Set objSP = Nothing

For i=0 To UBound(arrAG)

	rw arrAG(i) & "<BR><BR>"

	call Env.StoredProcedure(true, objSP, "sp_CadPesquisa")
	With objSP
		.Parameters.item("@pPSQ_ID") = pesqid
		.Parameters.item("@pUSERNAMECADASTRO") = auxusernameCadastro
		.Parameters.item("@pIP_CADASTRO") = auxIPCadastro
		.Parameters.item("@pAG_NUMERO") = arrAG(i)
		.Parameters.item("@pNOME") = auxNome
		.Parameters.item("@pTELEFONE") = auxTelefone
		.Parameters.item("@pEMAIL") = auxEmail
		.Parameters.item("@pORGAOEMPRESA") = auxOrgaoEmpresa
		.Parameters.item("@pORIGEM") = auxOrigem
		.Parameters.item("@pR1") = auxR1
		.Parameters.item("@pR2") = auxR2
		.Parameters.item("@pR3") = auxR3
		.Parameters.item("@pR4") = auxR4
		.Parameters.item("@pR5") = auxR5
		.Parameters.item("@pR6") = auxR6
		.Parameters.item("@pR7") = auxR7
		.Parameters.item("@pR8") = auxR8
		.Parameters.item("@pR9") = auxR9
		.Parameters.item("@pR10") = auxR10
		.Parameters.item("@pR11") = auxR11
		.Parameters.item("@pC1") = auxC1
		.Parameters.item("@pC2") = auxC2
		.Parameters.item("@pC3") = auxC3
		.Parameters.item("@pC4") = auxC4
		.Parameters.item("@pC5") = auxC5
		.Parameters.item("@pC6") = auxC6
		.Parameters.item("@pC7") = auxC7
		.Parameters.item("@pC8") = auxC8
		.Parameters.item("@pC9") = auxC9
		.Parameters.item("@pC10") = auxC10
		.Parameters.item("@pC11") = auxC11
		.Parameters.item("@pC_3") = auxC_3
		.Parameters.item("@pC_4") = auxC_4
'		on error resume next
		.Execute
'		on error goto 0
		pesqid = .Parameters.item("@pPSQ_ID")
	End With
	Call Env.StoredProcedure(False, objSP, "sp_CadPesquisa")
	Set objSP = Nothing

	If pesqid <= 0 Then
		Call MsgGravacaoDados(true, false, "<br><p class='texto1' style='font-size: 12px;'>&nbsp;&nbsp;<b>Erro na gravação desta pesquisa</b>", "pesqsCR.asp?num_ag=" & arrAG(i), "")
		Response.End
	else
		'-- Se foi a primeira resposta a pesquisa de satisfacao entao envio email para  RT/GQ
		If bln_EnviaEmailRtGq Then
			Call EnviaEmailRespostaPesquisa(Env.oConn, arrAG(i))
		End If
	End If

	pesqid = "0"
	iTot_AS = iTot_AS + 1
Next

response.redirect "pesqsCR.asp" & IIf(iTot_AS > 1, "", "?num_ag=" & auxNAg)
%>

