<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
call ImprimeCabecalho2("SISLAB - Comentários - Pesquisa de Satisfação", MENU_OFF, false, "100%", "", "", "window.close()")

Dim objSiteRS, cont, sSQL,tot, auxselag,auxselit,auxnitem,auxselativ
Dim auxnRitem, auxseltipo, dataIni, dataFim

auxselag = cint(trim(request("ag")))
auxselit = cint(trim(request("it")))
auxselativ = trim(request("ser"))
auxseltipo = cint(trim(request("tipo")))
dataIni = trim(request("dataIni"))
dataFim = trim(request("dataFim"))
auxselit = auxselit - 1

auxnitem = "psq_C" & auxselit
auxnRitem = "psq_R" & auxselit

function IsNulo(valor)
	if (len(valor) < 2) or isnull(valor) then 
	IsNulo = true
	else
	IsNulo = False
	end if
end function

function retornaopcao(opcao)
	if opcao=1 then retornaopcao="Muito Insatisfeito" end if
	if opcao=2 then retornaopcao="Insatisfeito" end if 
	if opcao=3 then retornaopcao="Nem Satisfeito, Nem Insatisfeito" end if
	if opcao=4 then retornaopcao="Satisfeito" end if
	if opcao=5 then retornaopcao="Muito Satisfeito" end if
	if Isnull(opcao) then retornaopcao="Não Respondido" end if
end function

function retornaopcao1(opcao)
	if opcao<3 then retornaopcao1="<img width=15 height=15 src='img/smile3.gif'>" end if
	if (opcao>=3 and opcao<4) then retornaopcao1="<img width=15 height=15 src='img/smile2.gif'>" end if
	if opcao>=4 then retornaopcao1="<img width=15 height=15 src='img/smile1.gif'>" end if
end function
%>

<table width="100%" bgcolor="#666666" border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="#000000">
<td width=20>
</td>
<td>
<font face="tahoma" style="font-size=11pt" color="#FFFFFF"><br>
<b>Comentários da Atividade: <%=auxselativ%><br>
Item&nbsp;
<%if auxselit=1 then%>
Comunicação
<%end if%>
<%if auxselit=2 then%>
Cortesia
<%end if%>
<%if auxselit=3 then%>
Presteza
<%end if%>
<%if auxselit=4 then%>
Flexibilidade
<%end if%>
<%if auxselit=5 then%>
Rapidez
<%end if%>
<%if auxselit=6 then%>
Iniciativa
<%end if%>
<%if auxselit=7 then%>
Confiabilidade
<%end if%>
<%if auxselit=8 then%>
Infraestrutura
<%end if%>
<%if auxselit=9 then%>
Ambiente
<%end if%>
<%if auxselit=10 then%>
Acesso
<%end if%>
<%if auxselit=11 then%>
Satisfação Geral
<%end if%>

</b></font>
</td>
<td width=20>
</td>
</tr>
<%
sSQL = sSQL & "SELECT * "
sSQL = sSQL & "  from PesquisaSatisfacao p INNER JOIN Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
sSQL = sSQL & "  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID "
sSQL = sSQL & " WHERE t.TA_ID = " & auxselag & " "

if dataIni <> "" and dataFim = "" then
	sSQL=sSQL & "  AND "
	'sSQL=sSQL & "  PSQ_DataHoraCadastro >= CONVERT(DATETIME, '" & dataIni & "', 103) "
	sSQL=sSQL & "  AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
elseif dataIni = "" and dataFim <> "" then
	sSQL=sSQL & "  AND "
	'sSQL=sSQL & "  (PSQ_DataHoraCadastro < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
	sSQL=sSQL & "  (AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
elseif dataIni <> "" and dataFim <> "" then
	sSQL=sSQL & "  AND "
	'sSQL=sSQL & "  PSQ_DataHoraCadastro BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
	sSQL=sSQL & "  AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
end if
sSQL = sSQL & "  ORDER by t.TA_ID;"
call Env.recordset(true, objSiteRS, sSQL)

if Not ObjSiteRS.EOF Then 
	ObjSiteRS.MoveFirst
	cont=0
	do while not ObjSiteRS.EOF 
		if not(((auxselit=1) and IsNulo(objSiteRS("PSQ_C1"))) or _
			((auxselit=2) and IsNulo(objSiteRS("PSQ_C2"))) or _
			((auxselit=3) and IsNulo(objSiteRS("PSQ_C3"))) or _
			((auxselit=4) and IsNulo(objSiteRS("PSQ_C4"))) or _
			((auxselit=5) and IsNulo(objSiteRS("PSQ_C5"))) or _
			((auxselit=6) and IsNulo(objSiteRS("PSQ_C6"))) or _
			((auxselit=7) and IsNulo(objSiteRS("PSQ_C7"))) or _
			((auxselit=8) and IsNulo(objSiteRS("PSQ_C8"))) or _
			((auxselit=9) and IsNulo(objSiteRS("PSQ_C9"))) or _
			((auxselit=10) and IsNulo(objSiteRS("PSQ_C10"))) or _
			((auxselit=11) and IsNulo(objSiteRS("PSQ_C11")))) _
		then
			cont=cont+1
%>
<tr>
<td width=20>
</td>
<td><font face="tahoma" style="font-size=9pt" color="#FFFFBD"><br>
<b>Comentário <%=cont%>:</b></font>
</td>
<td width=20>
</td>
</tr>
<tr>
<td width=20 bgcolor="#FFFFFF">
</td>
<td bgcolor="#FFFFFF" align="center" height="26" align=absmiddle>
<font face="tahoma" style="font-size=9pt" color="#202050">
<B>
<div align="justify">
<%if auxselit=1 then%>
<%=retornaopcao1(objSiteRS("PSQ_R1"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R1"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C1")%>
<%end if%>
<%if auxselit=2 then%>
<%=retornaopcao1(objSiteRS("PSQ_R2"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R2"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C2")%>
<%end if%>
<%if auxselit=3 then%>
<%=retornaopcao1(objSiteRS("PSQ_R3"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R3"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C3")%>
<%end if%>
<%if auxselit=4 then%>
<%=retornaopcao1(objSiteRS("PSQ_R4"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R4"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C4")%>
<%end if%>
<%if auxselit=5 then%>
<%=retornaopcao1(objSiteRS("PSQ_R5"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R5"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C5")%>
<%end if%>
<%if auxselit=6 then%>
<%=retornaopcao1(objSiteRS("PSQ_R6"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R6"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C6")%>
<%end if%>
<%if auxselit=7 then%>
<%=retornaopcao1(objSiteRS("PSQ_R7"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R7"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C7")%>
<%end if%>
<%if auxselit=8 then%>
<%=retornaopcao1(objSiteRS("PSQ_R8"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R8"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C8")%>
<%end if%>
<%if auxselit=9 then%>
<%=retornaopcao1(objSiteRS("PSQ_R9"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R9"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C9")%>
<%end if%>
<%if auxselit=10 then%>
<%=retornaopcao1(objSiteRS("PSQ_R10"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R10"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C10")%>
<%end if%>
<%if auxselit=11 then%>
<%=retornaopcao1(objSiteRS("PSQ_R11"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R11"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C11")%>
<%end if%>
</div>
</B><br>
</font>
</td>
<td width=20 bgcolor="#FFFFFF">
</td>
</tr>
<tr>
<td bgcolor="#EEEEEE">
</td>
<td bgcolor="#EEEEEE" align="left"><font face="tahoma" style="font-size=9pt" color="#222222">
<b>nome: <%=objSiteRS("PSQ_nome")%><br>Tel/Ramal: <%=objSiteRS("PSQ_Telefone")%><br>Órgão/Empresa: <%=objSiteRS("PSQ_orgaoEmpresa")%><br>No AS: <%=objSiteRS("PSQ_NAg")%></b></font>
</td>
<td bgcolor="#EEEEEE">
</td>
</tr>

<%
		End If
		objSiteRS.MoveNext
	Loop
end if
%>
<tr>
<td colspan="3">&nbsp;
</td>
</tr>
</table>
<%
call Env.recordset(false, objSiteRS, null)
call imprimeRodape(RODAPE_OFF)
%>