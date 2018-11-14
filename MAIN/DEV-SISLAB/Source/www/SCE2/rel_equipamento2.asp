<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
'-- GERA UMA LISTAGEM DE EQUIPAMENTOS
'-- RELATORIO DE EQUIPAMENTOS

Tela.SetNomeTela = "SCE > Relatório > Equipamento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Server.ScriptTimeout = 10000

    Call Tela.ImprimeMenuSce()

    dim ssql, where, dt_ini, dt_fim, rec, recInst, totRec
    dim descricaoeq : descricaoeq = "Equipamento"

    if request("diaIni") <> "" and request("mesIni") <> "" and request("anoIni") <> "" and _
	    request("diaFim") <> "" and request("mesFim") <> "" and request("anoFim") <> "" then
	    dt_ini = request("diaIni") & "/" & request("mesIni") & "/" & request("anoIni")
	    dt_fim = request("diaFim") & "/" & request("mesFim") & "/" & request("anoFim")
    else
	    dt_ini = ""
	    dt_fim = ""
    end if

    'Tem que alterar a view vw_SCE_Equipamentos_Fabricantes
    ssql =	"SELECT DISTINCT e.EQ_ID, e.EQ_CODIGOBARRAS, e.EQ_PROPRIEDADE, e.MOD_CODNOME, e.MOD_DESCRICAO, e.EQ_INSTRUMENTAL, " & _
		    "CASE WHEN e.STATUS = " & STATUS_EXPEDIDO_SUBST & " THEN 'Substituído' ELSE e.DESC_STATUS END AS DESC_STATUS, e.EQ_NUMEROSERIE, e.EQ_CONFORME, e.STATUS, e.EQ_LOCALIZACAO, e.FAB_NOME, e.EQ_OPER_DELTA, " & _
		    "e.EQ_OPER_UMIDADE, e.EQ_OPER_WARMUP, e.EQ_ARMA_DELTA, e.EQ_ARMA_UMIDADE, CAST(e1.EQ_OBS AS VARCHAR(8000)) AS EQ_OBS, CAST(e1.EQ_MANUT_PREVENTIVA AS VARCHAR(8000)) AS EQ_MANUT_PREVENTIVA " & _
		    "FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN SCE_Equipamentos e1 ON e.EQ_ID = e1.EQ_ID  LEFT JOIN SCE_Equipamentos_Controle ec " & _
		    "ON e.EQ_ID = ec.EQ_ID "
    where = ""

    if request("instrumental") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"e.EQ_INSTRUMENTAL = " & request("instrumental")
	    descricaoeq = "Instrumental"
    end if
    if request("codbarras") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"e.EQ_CODIGOBARRAS like '%"& trim(request("codbarras")) &"%' "
    end if
    if request("fabricante") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"FAB_ID = " & request("fabricante") & " "
    end if
    if request("propriedade") <> "" then
	    ssql = ssql &"and e.EQ_PROPRIEDADE IN ('" & request("propriedade") & "') "
    end if

    If request("plataforma") <> "" Then
	    if where <> "" then where = where & " AND "
	    where = where & "EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
		    "WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = e.EQ_ID) "
    End If

    if request("modelo") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"MOD_CODNOME like '%"& trim(request("modelo")) &"%' "
    end if
    if request("desc_modelo") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"MOD_DESCRICAO like '%"& trim(request("desc_modelo")) &"%' "
    end if
    if request("numeroserie") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"e.EQ_NUMEROSERIE like '%" & trim(request("numeroserie")) &"%' "
    end if
    if request("conforme") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"e.EQ_CONFORME = " & request("conforme") & " "
    end if
    if request("status") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"e.STATUS = " & request("status") & " "
    end if

    '-- Tive q repetir este codigo abaixo, alem de fazer um JOIN neste select pois
    '-- acabei implementando de forma incorreta esta busca (Fazendo 2 select´s)
    if request("controle") <> "" then
	    if where <> "" then where = where & " AND "
	    where = where &"ec.EQC_TIPO = '" & request("controle") & "' "
    end if
    if dt_ini <> "" and dt_fim <> "" then
	    if where <> "" then where = where & " AND "
	    where = where & "ec.EQC_DATA BETWEEN CONVERT(datetime, '" & dt_ini & "', 103) AND CONVERT(datetime, '" & dt_fim & "', 103) "
    end if

    if request("cde_equip") <> "" then  '-- registro de controle do equipamento
	    if where <> "" then where = where & " AND "
	    where = where & "EXISTS (SELECT eqc.EQC_REGISTRO FROM SCE_Equipamentos_Controle eqc WHERE eqc.EQ_ID = e.EQ_ID AND UPPER(eqc.EQC_REGISTRO) LIKE '" & UCase(request("cde_equip")) & "') "
    end if

    if where <> "" then where = "WHERE " & where
    ssql = ssql & where & " order by e.EQ_CODIGOBARRAS;"

    'response.write ssql
    'response.end

    Set rec = Env.oconn.execute(ssql)
%>
<table width="100%"  border="0">
<tr>
	<td colspan="2">
		<table class="destaque" width="100%" cellpadding="0" cellspacing="0"><tr><td><b>Listagem de <%=descricaoeq%></td><td align="right" >&nbsp;</td></tr></table>
	</td>
</tr>
<tr><td colspan="2" width="40px">&nbsp;</td></tr>
<%
    If Not (rec.eof and rec.bof) Then
        totRec = 0
	    While Not rec.eof
%>
<tr><td class="titulo" colspan="2"><table width="100%" cellpadding="0" cellspacing="0" style="border-bottom: thin solid gray;"><tr><td><b><%=rec("EQ_CODIGOBARRAS")%></b></td></tr></table></td></tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table width="100%"  cellpadding="0" cellspacing="0">
		<tr>
			<td width="*"><%=rec("MOD_CODNOME")%> <b>-</b> <%=rec("MOD_DESCRICAO")%> <b>-</b> <%=rec("FAB_NOME")%></td>
			<td align="right">Situa&ccedil;&atilde;o: <%=rec("DESC_STATUS")%></td>
		</tr>
		<tr><td></td></tr>
		<tr>
			<td colspan="2">Número de Série:&nbsp;<%=rec("EQ_NUMEROSERIE")%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table  cellpadding="0" cellspacing="0">
			<tr>
				<td>Localiza&ccedil;&atilde;o: <%=rec("EQ_LOCALIZACAO")%></td>
				<td width="40px">&nbsp;</td>
				<td width="40px">&nbsp;</td>
				<td>Propriedade:&nbsp;
<%
		    If rec("EQ_PROPRIEDADE") = EQ_PROPRIEDADE_TER Then
			    Response.Write "Terceiros"
		    ElseIf rec("EQ_PROPRIEDADE") = EQ_PROPRIEDADE_COM Then
			    Response.Write "Embratel - Comodato"
		    ElseIf rec("EQ_PROPRIEDADE") = EQ_PROPRIEDADE_CRT Then
			    Response.Write "Embratel - CRT"
		    ElseIf rec("EQ_PROPRIEDADE") = EQ_PROPRIEDADE_EBT Then
			    Response.Write "Embratel - Outros"
		    Else
			    Response.Write "&nbsp;"
		    End If
%>
				</td>
				<td width="40px">&nbsp;</td>
				<td>Conformidade: <%=SimNao(rec("EQ_CONFORME"))%></td>
<%	    	if request("instrumental") = "" then%>
				<td width="40px">&nbsp;</td>
				<td>Instrumental: <%=SimNao(rec("EQ_INSTRUMENTAL"))%></td>
<%		    end if%>
			</tr>
		</table>
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><td>&nbsp;</td><td><b>Dados do <%=descricaoeq%></b></td></tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table  cellpadding="0" cellspacing="0">
			<tr><td colspan="6"><b><i>Opera&ccedil;&atilde;o</i></b></td><td colspan="3"><i><b>Armazenagem</i></b></td></tr>
			<tr>
				<td>Delta: <%=rec("EQ_OPER_DELTA")%></td>
				<td width="40px">&nbsp;</td>
				<td>Umidade: <%=rec("EQ_OPER_UMIDADE")%></td>
				<td width="40px">&nbsp;</td>
				<td>Warm Up: <%=rec("EQ_OPER_WARMUP")%></td>
				<td width="60px">&nbsp;</td>
				<td>Delta: <%=rec("EQ_ARMA_DELTA")%></td>
				<td width="40px">&nbsp;</td>
				<td>Umidade: <%=rec("EQ_ARMA_UMIDADE")%></td>
			</tr>
		</table>
	</td>
</tr>
<%		    ssql =	"SELECT EQC_TIPO, CONVERT(VARCHAR, EQC_DATA, 103) as EQC_DATA, " & _
				    "EQC_DIAS, EQC_REGISTRO, EQC_RESPONSAVEL, " & _
				    "CASE WHEN EQC_DIAS IS NULL THEN NULL ELSE " & _
				    "CONVERT(VARCHAR, EQC_DATA + EQC_DIAS, 103) END AS EQC_DATA_VENCIMENTO " & _
				    "FROM SCE_Equipamentos_Controle WHERE EQ_ID = " & rec("EQ_ID") & " "
		    if dt_ini <> "" and dt_fim <> "" then
			    ssql = ssql & "AND EQC_DATA BETWEEN CONVERT(datetime, '" & dt_ini & "', 103) AND CONVERT(datetime, '" & dt_fim & "', 103) "
		    end if
		    if request("controle") <> "" then
			    ssql = ssql &"AND EQC_TIPO = '" & request("controle") & "' "
		    end if
		    ssql = ssql & "ORDER BY EQC_TIPO, CAST(EQC_DATA AS DATETIME)"

		    set recInst = Env.oConn.execute(ssql)
    		''response.write ssql

	    	if not (recInst.eof and recInst.bof) then%>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><b>Controle do <%=descricaoeq%></b></td></tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table  cellpadding="2" cellspacing="0" border="1">
<%  			controle = ""
			    nomecontrole = ""
			    while not recInst.eof
				    if controle = "" or controle <> recInst("EQC_TIPO") then

					    if recInst("EQC_TIPO") = CONTROLE_CALIBRACAO then
						    nomecontrole = "Calibra&ccedil;&atilde;o"
					    elseif recInst("EQC_TIPO") = CONTROLE_MANUTENCAO then
						    nomecontrole = "Manuten&ccedil;&atilde;o"
					    else
						    nomecontrole = "Qualifica&ccedil;&atilde;o"
					    end if%>
			<tr><td colspan="5"><b><i><%=nomecontrole%></i></b></td></tr>
			<tr>
				<td width="80px"><b><i>Data</i></b></td>
				<td width="80px"><i><b>Prazo (dias)</i></b></td>
				<td width="80px"><i><b>Vencimento</i></b></td>
				<td width="200px"><i><b>Registro</i></b></td>
				<td width="150px"><i><b>Respons&aacute;vel</i></b></td>
			</tr>
<%  				end if%>
			<tr>
				<td><%=recInst("EQC_DATA")%></td>
				<td><%if IsNull(recInst("EQC_DIAS")) then response.write "&nbsp;" else response.write recInst("EQC_DIAS")%></td>
				<td><%if IsNull(recInst("EQC_DATA_VENCIMENTO")) then response.write "&nbsp;" else response.write recInst("EQC_DATA_VENCIMENTO")%></td>
				<td><%=recInst("EQC_REGISTRO")%></td>
				<td><%=recInst("EQC_RESPONSAVEL")%></td>
			</tr>
<%	    			if not recInst.Eof then controle = recInst("EQC_TIPO")
				    recInst.MoveNext
			    wend%>
		</table>
	</td>
</tr>
<%	    	end if%>

<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><b>Observações:</b></td></tr>
<tr><td>&nbsp;</td><%If IsNull(rec("EQ_OBS")) Then Response.Write "<td>&nbsp;</td>" Else Response.write "<td style='border: thin solid gray;'>" & Replace(Trim(rec("EQ_OBS")), VbCrLf, "<BR>") & "</td>"%></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><b>Dados de manutenção:</b></td></tr>
<tr><td>&nbsp;</td><%If IsNull(rec("EQ_MANUT_PREVENTIVA")) Then Response.Write "<td>&nbsp;</td>" Else Response.write "<td style='border: thin solid gray;'>" & Replace(Trim(rec("EQ_MANUT_PREVENTIVA")), VbCrLf, "<BR>") & "</td>"%></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%
		    ssql =	"SELECT Sequencial, Descricao, Status, Conforme " & _
				    "FROM SCE_Acessorios WHERE EQ_ID = " & rec("EQ_ID") & " " & _
				    "ORDER BY Sequencial"
		    set recInst = Env.oConn.execute(ssql)

		    if not (recInst.eof and recInst.bof) then%>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><b>Acessórios do Equipamento</b></td></tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table  cellpadding="2" cellspacing="0" border="1" width="550px">
		<tr>
			<td width="70px"><b><i>Sequencial</i></b></td>
			<td width="*"><i><b>Descrição</i></b></td>
			<td width="70px" align="center"><i><b>Status</i></b></td>
			<td width="70px" align="center"><i><b>Conforme</i></b></td>
		</tr>
<%	    		while not recInst.eof%>
			<tr>
				<td><%=recInst("Sequencial")%></td>
				<td><%if IsNull(recInst("Descricao")) then response.write "&nbsp;" else response.write recInst("Descricao")%></td>
				<td align="center">
<%  				if CStr(recInst("Status")) = CStr(STATUS_EM_ESTOQUE) then
					    response.write "Em estoque"
				    elseIf CStr(recInst("Status")) = CStr(STATUS_EM_USO) then
					    response.write "Em uso"
				    elseIf CStr(recInst("Status")) = CStr(STATUS_EXPEDIDO) then
					    response.write "Expedido"
				    elseIf CStr(recInst("Status")) = CStr(STATUS_EXPEDIDO_SUBST) then
					    response.write "Substituído"
				    else
					    response.write "&nbsp;"
				    end if
%>				</td>
				<td align="center"><%=SimNao(recInst("Conforme"))%></td>
			</tr>
<%	    			recInst.MoveNext
		    	wend%>
		</table>
	</td>
</tr>
<%		    end if %>
<tr><td colspan="2">&nbsp;</td></tr>
<%
		    rec.MoveNext
		    totRec = totRec + 1
	    WEnd
%>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2" align="right">Total de itens encontrados: <%=totRec%></td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%
    Else
%>
<tr><td align="center" class="titulo">Nenhum <%=lcase(descricaoeq)%> encontrado !</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%
    End if
%>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>