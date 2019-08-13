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

Tela.SCE = True
Tela.SetNomeTela = "Relatório > Equipamento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Server.ScriptTimeout = 10000

    'Call Tela.ImprimeMenuSce()

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
    ssql =	"SELECT DISTINCT top 30 e.EQ_ID, e.EQ_CODIGOBARRAS, e.EQ_PROPRIEDADE, e.MOD_CODNOME, e.MOD_DESCRICAO, e.EQ_INSTRUMENTAL, " & _
		    "CASE WHEN e.STATUS = " & STATUS_EXPEDIDO_SUBST & " THEN 'Substituído' ELSE e.DESC_STATUS END AS DESC_STATUS, e.EQ_NUMEROSERIE, e.EQ_CONFORME, e.STATUS, e.AMB_NOME, e.FAB_NOME, e.EQ_OPER_DELTA, " & _
		    "e.EQ_OPER_UMIDADE, e.EQ_OPER_WARMUP, e.EQ_ARMA_DELTA, e.EQ_ARMA_UMIDADE, CAST(e1.EQ_OBS AS VARCHAR(8000)) AS EQ_OBS, CAST(e1.EQ_MANUT_PREVENTIVA AS VARCHAR(8000)) AS EQ_MANUT_PREVENTIVA, eqp.NM_PROPRIEDADE " & _
		    "FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN SCE_Equipamentos e1 ON e.EQ_ID = e1.EQ_ID LEFT JOIN SCE_Equipamentos_Controle ec " & _
		    "ON e.EQ_ID = ec.EQ_ID " & VbCrLf

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

    ssql = ssql & VbCrLf & _
            "LEFT JOIN SCE_Equipamentos_Propriedade eqp ON e.EQ_PROPRIEDADE = eqp.ID_PROPRIEDADE " & VbCrLf

    if where <> "" then where = "WHERE " & where
    ssql = ssql & where & " order by e.EQ_CODIGOBARRAS;"

    'response.write ssql
    'response.end

    Set rec = Env.oconn.execute(ssql)
%>
<div class="margem-10">

<p><strong>Listagem de <%=descricaoeq%></strong></p>

<table class="largura-total">
<tr>
    <td colspan="2" width="40px">&nbsp;</td>
</tr>
<%
    If Not (rec.eof and rec.bof) Then
        totRec = 0
	    While Not rec.eof
%>
<tr>
    <td colspan="2" style="border-bottom: thin solid gray;" class="">
        <h4 class="text-info"><%=rec("EQ_CODIGOBARRAS")%></h4>
    </td>
</tr>
<tr>
	<td colspan="2">
		<table width="100%"  cellpadding="0" cellspacing="0">
		<tr>
			<td width="*"><%=rec("MOD_CODNOME")%> <b>-</b> <%=rec("MOD_DESCRICAO")%> <b>-</b> <%=rec("FAB_NOME")%></td>
			<td class="texto-direito">Situa&ccedil;&atilde;o: <%=rec("DESC_STATUS")%></td>
		</tr>
		<tr><td></td></tr>
		<tr>
			<td colspan="2">Número de Série:&nbsp;<%=rec("EQ_NUMEROSERIE")%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td colspan="2">
		<table  cellpadding="0" cellspacing="0">
			<tr>
				<td>Localiza&ccedil;&atilde;o: <%=rec("AMB_NOME")%></td>
				<td width="40px">&nbsp;</td>
				<td width="40px">&nbsp;</td>
				<td>Propriedade:&nbsp;
<%
		    If Not IsNull(rec("NM_PROPRIEDADE")) Then
			    Response.Write rec("NM_PROPRIEDADE")
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

<tr><th colspan="2">Dados do <%=descricaoeq%></th></tr>

<tr>
	<td style="width: 20px;">&nbsp;</td>
	<td>
		<table>
			<tr><td colspan="6">Opera&ccedil;&atilde;o</td><td colspan="3">Armazenagem</td></tr>
			<tr>
				<td>Delta: <%=rec("EQ_OPER_DELTA")%></td>
				<td style="width: 40px;">&nbsp;</td>
				<td>Umidade: <%=rec("EQ_OPER_UMIDADE")%></td>
				<td style="width: 40px;">&nbsp;</td>
				<td>Warm Up: <%=rec("EQ_OPER_WARMUP")%></td>
				<td style="width: 60px;">&nbsp;</td>
				<td>Delta: <%=rec("EQ_ARMA_DELTA")%></td>
				<td style="width: 40px;">&nbsp;</td>
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

<tr><td colspan="2"><b>Controle do <%=descricaoeq%></b></td></tr>
<tr>
    <td>&nbsp;</td>
	<td>
		<table class="table-bordered table-condensed">
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
			<tr><th colspan="5"><small><i><%=nomecontrole%></i></small></th></tr>
			<tr>
				<th style="width: 80px;"><small>Data</small></th>
				<th style="width: 80px;"><small>Prazo (dias)</small></th>
				<th style="width: 80px;"><small>Vencimento</small></th>
				<th style="width: 200px;"><small>Registro</small></th>
				<th style="width: 250px;"><small>Respons&aacute;vel</small></th>
			</tr>
<%  				end if%>
			<tr>
				<td><small><%=recInst("EQC_DATA")%></small></td>
				<td><small><%if IsNull(recInst("EQC_DIAS")) then response.write "&nbsp;" else response.write recInst("EQC_DIAS")%></small></td>
				<td><small><%if IsNull(recInst("EQC_DATA_VENCIMENTO")) then response.write "&nbsp;" else response.write recInst("EQC_DATA_VENCIMENTO")%></small></td>
				<td><small><%=recInst("EQC_REGISTRO")%></small></td>
				<td><small><%=recInst("EQC_RESPONSAVEL")%></small></td>
			</tr>
<%	    			if not recInst.Eof then controle = recInst("EQC_TIPO")
				    recInst.MoveNext
			    wend%>
		</table>
	</td>
</tr>
<%	    	end if%>

<tr><td colspan="2">&nbsp;</td></tr>
<%If Not VVVNZ(rec("EQ_OBS")) Then %>
<tr><th colspan="2">Observações:</th></tr>
<tr><td>&nbsp;</td><%If VVVNZ(rec("EQ_OBS")) Then Response.Write "<td>&nbsp;</td>" Else Response.write "<td>" & Replace(Trim(rec("EQ_OBS")), VbCrLf, "<BR>") & "</td>"%></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%End If %>

<%If Not VVVNZ(rec("EQ_MANUT_PREVENTIVA")) Then %>
<tr><th colspan="2">Dados de manutenção:</th></tr>
<tr><td>&nbsp;</td><%If IsNull(rec("EQ_MANUT_PREVENTIVA")) Then Response.Write "<td>&nbsp;</td>" Else Response.write "<td>" & Replace(Trim(rec("EQ_MANUT_PREVENTIVA")), VbCrLf, "<BR>") & "</td>"%></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%End If %>

<%
		    ssql =	"SELECT Sequencial, Descricao, Status, Conforme " & _
				    "FROM SCE_Acessorios WHERE EQ_ID = " & rec("EQ_ID") & " " & _
				    "ORDER BY Sequencial"
		    set recInst = Env.oConn.execute(ssql)

		    If not (recInst.eof and recInst.bof) then%>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><th colspan="2">Acessórios do Equipamento</th></tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<table style="width: 550px;" class="table-bordered table-condensed">
		<tr>
			<th style="width: 70px;"><small>Sequencial</small></th>
			<th><small>Descrição</small></th>
			<th style="width: 70px;" class="texto-centralizado"><small>Status</small></th>
			<th style="width: 70px;" class="texto-centralizado"><small>Conforme</small></th>
		</tr>
<%	    		while not recInst.eof%>
		<tr>
			<td><small><%=recInst("Sequencial")%><small></td>
			<td><small><%if IsNull(recInst("Descricao")) then response.write "&nbsp;" else response.write recInst("Descricao")%></small></td>
			<td class="texto-centralizado">
                <small>
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
%>              </small>
            </td>
			<td class="texto-centralizado"><small><%=SimNao(recInst("Conforme"))%></small></td>
		</tr>
<%	    			recInst.MoveNext
		    	wend%>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%		    end if %>
<%
		    rec.MoveNext
		    totRec = totRec + 1

            If totRec Mod 100 Then
                Response.Flush 
            End If
	    WEnd
%>
<tr><td colspan="2">&nbsp;</td></tr>
<tr><td colspan="2" class="texto-direito"><small>Total de itens encontrados: <%=totRec%></small></td></tr>
<%
    Else
%>
<tr><td class="texto-centralizado" class="titulo">Nenhum <%=lcase(descricaoeq)%> encontrado !</td></tr>
<tr><td colspan="2">&nbsp;</td></tr>
<%
    End if
%>
</table>

    <br />
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>