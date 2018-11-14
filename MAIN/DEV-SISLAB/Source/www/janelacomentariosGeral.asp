<!-- #INCLUDE FILE="includes/inicializacao.inc" --><%
'	On Error Resume Next

Conecta true

Dim objSiteRS, cont, sSQL,tot, auxselag,auxselit,auxnitem,auxselativ
Dim auxnRitem, auxseldata,auxseltipo

auxselag=cint(trim(request.QueryString("ag")))
auxselit=cint(trim(request.QueryString("it")))
auxselativ=trim(request.QueryString("ser"))
auxseltipo=cint(trim(request.QueryString("tipo")))
auxseldata=(trim(request.QueryString("data")))
auxselit=auxselit-1

auxnitem="psq_C"&auxselit
auxnRitem="psq_R"&auxselit

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

<html>
<head>
<title>Comentários</title>
<meta http-equiv="Pragma" content="no-cache">
</head>
<link rel="stylesheet" href="estilos/style.css">
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0 background="img/fnjornal.gif">

<table width="300" bgcolor="#666666" border="0" cellspacing="0" cellpadding="0">
<tr bgcolor="#000000">
<td width=20>
</td>
<td>
<font face="tahoma" style="font-size=11pt" color="#FFFFFF"><br>
<b>Todas as Atividades<br>

</b></font>
</td>
<td width=20>
</td>
</tr>

<script type="text/javascript">

function janelalink(link)
{
    window.open(link,'Noticias_Detalhe','toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=auto,resizable=no,copyhistory=no,width=800,height=600, top=0, left=0');
    parent.close();
}
</script>
<%
sSQL="Select p.*, t.TA_DESCRICAO "
sSQL=sSQL&"  from PesquisaSatisfacao p INNER JOIN Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
sSQL=sSQL&"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID "
sSQL=sSQL&"  ORDER by t.TA_DESCRICAO; "
Set objSiteRS = ObterRecordset(sSQL)

 If Not ObjSiteRS.EOF Then 
	ObjSiteRS.MoveFirst

cont=0

 do while not ObjSiteRS.EOF 

cont=1
%>

<%if not (IsNulo(objSiteRS("PSQ_C1")) and IsNulo(objSiteRS("PSQ_C2")) and IsNulo(objSiteRS("PSQ_C3")) and IsNulo(objSiteRS("PSQ_C4")) and _
IsNulo(objSiteRS("PSQ_C5")) and IsNulo(objSiteRS("PSQ_C6")) and IsNulo(objSiteRS("PSQ_C7")) and IsNulo(objSiteRS("PSQ_C8")) and _
IsNulo(objSiteRS("PSQ_C9")) and IsNulo(objSiteRS("PSQ_C10")) and IsNulo(objSiteRS("PSQ_C11"))) then %>
<tr>
<td width=20>
</td>
<td><font face="tahoma" style="font-size=9pt" color="#FFFFBD"><br>
<b>Comentários sobre o Agendamento <%=objSiteRS("PSQ_NAg")%>:</b></font>
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
<%if not IsNulo(objSiteRS("PSQ_C1")) then 
cont=0 %><font color="#ff0000">Comunicação:</font> <%=retornaopcao1(objSiteRS("PSQ_R1"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R1"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C1")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C2")) then 
cont=0 %><font color="#ff0000">Cortesia:</font> <%=retornaopcao1(objSiteRS("PSQ_R2"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R2"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C2")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C3")) then 
cont=0 %><font color="#ff0000">Presteza:</font> <%=retornaopcao1(objSiteRS("PSQ_R3"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R3"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C3")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C4")) then 
cont=0 %><font color="#ff0000">Flexibilidade:</font> <%=retornaopcao1(objSiteRS("PSQ_R4"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R4"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C4")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C5")) then 
cont=0 %><font color="#ff0000">Rapidez:</font> <%=retornaopcao1(objSiteRS("PSQ_R5"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R5"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C5")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C6")) then 
cont=0 %><font color="#ff0000">Iniciativa:</font> <%=retornaopcao1(objSiteRS("PSQ_R6"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R6"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C6")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C7")) then 
cont=0 %><font color="#ff0000">Confiabilidade:</font> <%=retornaopcao1(objSiteRS("PSQ_R7"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R7"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C7")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C8")) then 
cont=0 %><font color="#ff0000">Infraestrutura:</font> <%=retornaopcao1(objSiteRS("PSQ_R8"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R8"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C8")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C9")) then 
cont=0 %><font color="#ff0000">Ambiente:</font> <%=retornaopcao1(objSiteRS("PSQ_R9"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R9"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C9")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C10")) then 
cont=0 %><font color="#ff0000">Acesso:</font> <%=retornaopcao1(objSiteRS("PSQ_R10"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R10"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C10")%><br> <%end if %>
<%if not IsNulo(objSiteRS("PSQ_C11")) then 
cont=0 %><font color="#ff0000">Satisfação Geral:</font> <%=retornaopcao1(objSiteRS("PSQ_R11"))%>&nbsp;(<%=retornaopcao(objSiteRS("PSQ_R11"))%>)&nbsp;&nbsp;<br><%=objSiteRS("PSQ_C11")%><br> <%end if %>
<%if cont=1 then %> SEM COMENTÁRIOS <%end if %>
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
<b>nome: <%=objSiteRS("PSQ_nome")%><br>Tel/Ramal: <%=objSiteRS("PSQ_Telefone")%><br>Órgão/Empresa: <%=objSiteRS("PSQ_orgaoEmpresa")%><br>Atividade: <%=objSiteRS("TA_DESCRICAO")%></b></font>
</td>
<td bgcolor="#EEEEEE">
</td>
</tr>

<%End if
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
	'Fechar Objetos abertos
 	Conecta False

%>
<%
	Call MostraFooter
%>