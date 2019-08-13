<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Sce.asp"-->
<%
'-- GERA UMA LISTAGEM DE EQUIPAMENTOS
'-- RELATORIO DE EQUIPAMENTOS/INSTRUMENTAIS

Dim bln_exportaExcel
Dim ssql, where, dt_ini, dt_fim, rec, recInst, cont, bg
Dim descricaoeq : descricaoeq = "Equipamento"

Server.ScriptTimeout = 10000

bln_exportaExcel = (Request("exportaExcel") = "S")

if request("diaIni") <> "" and request("mesIni") <> "" and request("anoIni") <> "" and _
	request("diaFim") <> "" and request("mesFim") <> "" and request("anoFim") <> "" then
	dt_ini = request("diaIni") & "/" & request("mesIni") & "/" & request("anoIni")
	dt_fim = request("diaFim") & "/" & request("mesFim") & "/" & request("anoFim")
else
	dt_ini = ""
	dt_fim = ""
end if

ssql =	""
where = ""

if request("instrumental") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_INSTRUMENTAL = " & request("instrumental")
	descricaoeq = "Instrumental"
end if
if request("vencimento") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQC_VENCIMENTO <= GETDATE() + " & request("vencimento") & " "
end if
if request("codbarras") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_CODIGOBARRAS like '%"& trim(request("codbarras")) &"%' "
end if
if request("fabricante") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"FAB_ID = " & request("fabricante") & " "
end if
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
	where = where &"EQ_NUMEROSERIE like '%" & trim(request("numeroserie")) &"%' "
end if
if request("conforme") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQ_CONFORME = " & request("conforme") & " "
end if
if request("status") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"STATUS = " & request("status") & " "
end if

If request("plataforma") <> "" Then
	if where <> "" then where = where & " AND "
	where = where & "EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
		"WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = e.EQ_ID) "
End If

if request("controle") <> "" then
	if where <> "" then where = where & " AND "
	where = where &"EQC_TIPO = '" & request("controle") & "' "
end if
if dt_ini <> "" and dt_fim <> "" then
	if where <> "" then where = where & " AND "
	where = where & "EQC_DATA BETWEEN CONVERT(datetime, '" & dt_ini & "', 103) AND CONVERT(datetime, '" & dt_fim & "', 103) "
end if

if where <> "" then where = "WHERE " & where


If Not bln_exportaExcel Then

    Dim Sce

    Set Sce = New TSce

	ssql =	"SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, e.MOD_CODNOME, e.MOD_DESCRICAO, " & _
			"e.EQ_INSTRUMENTAL, EQ_NUMEROSERIE, e.EQ_CONFORME, e.STATUS, e.AMB_NOME, e.FAB_NOME, " & _
			"EQC_TIPO, CONVERT(varchar, EQC_VENCIMENTO, 103) AS EQC_VENCIMENTO FROM vw_SCE_EQ_CONTROLE_ATUAL e "

	ssql = ssql & where & " order by /*EQ_CODIGOBARRAS,*/ EQC_TIPO, CAST(EQC_VENCIMENTO AS DATETIME);"

	Set rec = Env.oconn.execute(ssql)

    Tela.SCE = True
    Tela.SetNomeTela = "Relatório > Controle de Equipamento e Instrumental" : Tela.SetCaminhoRelativo = "../"
    Call Tela.MostraCabecalho()
    'Call Tela.ImprimeMenuSce()
%>
<div class="margem-10">
<table class="largura-total">
<tr>
	<td colspan="2">
		<table class="largura-total">
            <tr>
                <td><strong>Listagem de <%=descricaoeq%></strong></td>
                <td class="texto-direito"><!--Total de itens encontrados: <%'=rec.recordcount%>--></td>
            </tr>
		</table>
	</td>
</tr>
<tr><td colspan="2" width="40px">&nbsp;</td></tr>
<tr><td colspan="2"><small>Os itens em destaque (<span class="bg-danger">&nbsp;&nbsp;</span>) est&atilde;o com vencidos.</small></td></tr>
<%
	if not (rec.eof and rec.bof) then%>
<tr>
	<td colspan="2">
		<table class="largura-total table-condensed table-bordered table-striped table-hover">
		<tr>
			<th>*</th>
			<th>Cód. Barras</th>
			<th>Modelo</th>
			<th>Descrição</th>
			<th>Num.Série</th>
			<th>Fabricante</th>
			<th>Status</th>
			<th>Vencimento</th>
		</tr>
<%		cont = 0
		while not rec.eof
			cont = cont+1
			'if (cont mod 2) = 0 then bg = 1 else bg = 0
			bg = 1  '-- tirei a modificacao das cores devido a cor dos eq´s vencidos
%>
	<tr <%if not IsNull(rec("EQC_VENCIMENTO")) then if cdate(rec("EQC_VENCIMENTO")) < date() then response.write "class='bg-danger'" end if %>>
			<td class="texto-centralizado"><%=rec("EQC_TIPO")%></td>
			<td><%=Sce.LinkEquipamento(rec("EQ_ID"), rec("EQ_CODIGOBARRAS"), False)%></td>
			<td><%=rec("MOD_CODNOME")%></td>
			<td><%=rec("MOD_DESCRICAO")%></td>
			<td><%=rec("EQ_NUMEROSERIE")%></td>
			<td><%=rec("FAB_NOME")%></td>
			<td class="texto-centralizado"><%=Sce.PegaStatusItem(rec("EQ_ID"), true)%></td>
			<td class="texto-centralizado"><%if IsNull(rec("EQC_VENCIMENTO")) then response.write "&nbsp;" else response.write rec("EQC_VENCIMENTO")%></td>
		</tr>
<%			rec.MoveNext
            total = total + 1
		WEnd%>
		</table>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<td><small>(*): C - Calibração / M - Manutenção / Q - Qualificação</small></td>
	<td class="texto-direito"><small>Total de itens encontrados: <%=cont%></small></td>
</tr>
<%
	else
%>
<tr><td align="center" >Nenhum <%=lcase(descricaoeq)%> encontrado !</td></tr>
<%
	End if
%>
<tr><td colspan="2">&nbsp;</td></tr>
</table>
</div>
<%
Else
    ssql =	"SELECT '''' + e.EQ_CODIGOBARRAS as [Código de Barras], e.MOD_CODNOME as [Modelo], e.MOD_DESCRICAO as [Descrição], " & _
		    "CASE WHEN e.EQ_INSTRUMENTAL = 1 THEN 'Sim' ELSE 'Não' END AS [Instrumental], EQ_NUMEROSERIE as [N.Série], " & _
		    "CASE WHEN e.EQ_CONFORME = 1 THEN 'Sim' ELSE 'Não' END as [Conforme], " & _
		    "CASE WHEN e.STATUS = " & STATUS_EM_ESTOQUE & " THEN 'Em Estoque'" & _
		    "	WHEN e.STATUS = " & STATUS_CADASTRADO & " THEN 'Cadastrado'" & _
		    "	WHEN e.STATUS = " & STATUS_EXPEDIDO & " THEN 'Expedido'" & _
		    "	WHEN e.STATUS = " & STATUS_EXPEDIDO_SUBST & " THEN 'Substituído'" & _
		    "	WHEN e.STATUS = " & STATUS_EM_USO & " THEN 'Em Uso'" & _
		    "END as [Status], e.AMB_NOME as [Localização], e.FAB_NOME as [Fabricante], " & _
		    "CASE WHEN EQC_TIPO = 'M' THEN 'Manutenção' " & _
		    "	WHEN EQC_TIPO = 'C' THEN 'Calibração' " & _
		    "	WHEN EQC_TIPO = 'Q' THEN 'Qualificação' " & _
		    "END as [Tipo], " & _
		    "CONVERT(varchar, EQC_VENCIMENTO, 103) AS [Vencimento] " & _
            "FROM vw_SCE_EQ_CONTROLE_ATUAL e "

    ssql = ssql & where & " order by /*EQ_CODIGOBARRAS,*/ EQC_TIPO, CAST(EQC_VENCIMENTO AS DATETIME);"

    Set rec = Env.oconn.execute(ssql)

    Call CriaExcelGeral("Relatório de Controle de Equipamento e Instrumental", rec, null)
End If
%>
