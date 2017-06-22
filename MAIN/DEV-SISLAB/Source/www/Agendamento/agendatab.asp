<!--#include file="includes/cabecalho.inc"-->
<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes/funcoesAux.inc"-->
<%
Dim semana, nrodia, data, nome, i, descricao
Dim cordia1, cordia2, corferiado, cortexto, cordescricao, corbarra, cormarcado
cordia1="#FFFFFF"
cordia2="#E2E2E2"
'cordia2="#9BE3FF"
corferiado="#CDCDCD"
cortexto="#000000"
'cortexto="#ffffff"
cordescricao="#9BE3FF"
'cordescricao="navy"
corbarra="#ffff00"
cormarcado="#ccbb33"

' data da semana inicial
Dim mudouData
if (Request.Form("data") <> date()) AND (Request.Form("data") <> "") Then
  data = cdate(Request.Form("data"))
  mudouData = 1
else
  data = date()
  mudouData = 0
end if

' verifico se houve mudanca de data
if (Request.Form("dataTipo") <> "") Then
  Dim tipo, qtd
  tipo = Request.Form("dataTipo")
  qtd = Request.Form("dataQtd")
  data = cdate(dateadd(cstr(tipo),cint(qtd),data))
end if

' verifico se houve filtro de nome
if (Request.Form("nome") <> "-1") and (Request.Form("nome") <> "") Then
	nome = Request.Form("nome")
else
	nome = "-1"
end if

semana = array("","Dom","Seg","Ter","Qua","Qui","Sex","Sáb")
nrodia = weekday(data)
%>

<HTML>
<HEAD>
  <TITLE>Agendamento</TITLE>
<!-- Atribui os estilos apropriados para cada resolucao -->
<!--#include file="includes\verificaResolucao.inc"-->

<style>
.celula
{        
	BORDER-BOTTOM: white thin inset; 
}
</style> 

<script language="JavaScript" src="includes\manipulaObj.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var maiorp;
maiorp = 0;
function vetorAlocacao(tpid)
{
	this.tpid = tpid;
}
var vetorAloc = new Array();

function alteraCamada(msg)
{
	var tamdiv = 350;
	if (msg!='')
	{
		if (document.all)
		{	
			if (event.x+tamdiv+document.body.scrollLeft < screen.width)
				mudaEstilo("camada", "left", event.x+20+document.body.scrollLeft);
			else
				mudaEstilo("camada", "left", event.x-tamdiv+document.body.scrollLeft);
			mudaEstilo("camada", "top", event.y+10+document.body.scrollTop);
		}
		else
		{
			mudaEstilo("camada", "left", 20);
			mudaEstilo("camada", "top", 20);
		}
		mudaConteudo("camada", "innerHTML", msg);
		mudaEstilo("camada", "display","block");
	}
	else
		mudaEstilo("camada", "display","none");
}

<%
if mudouData = 1 then%>
  // atualizando as propriedades do frame superior
  var frm = parent.frames[0].document.formSuperior;
  frm.data.value = '<%= day(data)&"/"&month(data)&"/"&year(data)%>';

	parent.frames[0].document.all.tituloAtividade.innerHTML = "<font COLOR='white' class='fonte2'>" + 
	"Atividades<br>" +
	"(<%=day(data)&"/"&month(data)&"/"&year(data)%> a " +
	"<%=day(data+13)&"/"&month(data+13)&"/"&year(data+13)%>)</font>"

<%Dim nrodiatemp
	nrodiatemp = nrodia
	for i=0 to 13%>
		parent.frames[0].document.all.dia<%= i%>.innerHTML = "<font COLOR='white' class='fonte1'><%= day(data+i)&"/"&month(data+i)%></font><BR>" + 
		"<font COLOR='white' class='fonte1'><%= semana(nrodiatemp)%></font>" 
<%	nrodiatemp = nrodiatemp + 1
		if nrodiatemp > 7 then 
			nrodiatemp=1 
		end if
	next
end if%>

function limpaMarcados()
{
	// limpa os marcados
	for(j=0;j<=maiorp;j++)
	{
		for(i=0;i<=13;i++)
			if (document.all["cel_"+vetorAloc[j].tpid+"_"+i])
				document.all["cel_"+vetorAloc[j].tpid+"_"+i].style.backgroundColor = '<%=corbarra%>';
	}
}

function barraAlocacao(valor) // ao clicar na barra de alocacao
{
  var frm = parent.frames[2].document.frmInicioTermino;
	frm.data.value = "<%=data%>";
	frm.tpid.value = valor;
  frm.action = "agendainf.asp";
  frm.target = "inferior";
	frm.method = "post";
	parent.frames[0].gravacookie("flag_2=1");
  frm.submit();
	// limpa os marcados
	limpaMarcados();
	// pinta o marcado
	for(i=0;i<=13;i++)
		if (document.all["cel_"+valor+"_"+i])
			document.all["cel_"+valor+"_"+i].style.backgroundColor = '<%=cormarcado%>';
}

function verificaVoltar()
{
	if (parent.frames[0].lecookie("flag_1")=="0")
		window.parent.location.replace("default.htm");
}
</SCRIPT>
 
</HEAD>
<BODY bgcolor="#FFFFFF" topmargin="0" leftmargin="3" link="#FFFFFF" vlink="#FFFFFD" alink="#FFFFF6">

<div id="camada" class="fonte1" align="left" style="position:absolute; width:350px;
 background-color:#fffff0; color:black; display:none;"></div>

<table width="770" border=1 cellspacing="0" cellpadding="0">
<TR><td>
<table width="770" border=0 cellspacing="0" cellpadding="0">
<%
	Dim feriado()
	redim feriado(14)
	for i=0 to 14
		feriado(i)=0
	next

  Dim objConn, objRS, sSQL
	Call Connection(True, objConn)
 	Call RecordSet(True, objRS, "SP_AG_BUSCA_FERIADOS '"&day(data)&"/"&month(data)&"/"&year(data)&"'", objConn)
	if not objRS.eof then
	  while not objRS.eof
			if (objRS("DATA_FERIADO")-data) >= 0 then
				feriado(objRS("DATA_FERIADO")-data) = 1
			else
				feriado(objRS("DATA_FERIADO")-(dateadd("yyyy", -1,data))) = 1
			end if
			objRS.movenext
		wend
	end if
 	Call RecordSet(False, objRS, Null, Null)
 	Call RecordSet(True, objRS, "SP_TAREFAS_POR_PERIODO '"&day(data)&"/"&month(data)&"/"&year(data)&"',"&nome, objConn)

  Dim temAlocado
  if objrs.eof then
    temAlocado=false
  else
    temAlocado=true
  end if

if nome <> "-1" then
	
  ' definindo o vetor pAloc
  Dim pAloc(), h, l, p, j, tt, aux(), reglivre, reg, vetorAloc(), count
	count = 0
	redim aux(100)
	redim vetorAloc(100)
  redim pAloc(100, 1, 14, 1)
  for h=0 to 100
		for j=0 to 1
	    for i=0 to 14
  	    for l=0 to 1
    	    pAloc(h,j,i,l)=0
      	next
	    next
		next
  next
	for i=0 to 100
		vetorAloc(i) = -1
		aux(i) = 0
	next

	if temAlocado then objrs.movefirst
  while not objrs.eof
		reg = objrs("TAREFA_ID")
		reglivre = -1
		p = -1
		for i=0 to 100
			if (reglivre<0)and(aux(i)=0) then reglivre = i
			if aux(i) = reg then p = i
			if (reglivre>=0)and(p>=0) then exit for
		next
		if p < 0 then
			p = reglivre
			aux(p) = reg
		end if
		tt = objrs("TAREFA_TIPO")
		if tt then
			tt = 0
		else
			tt = 1
		end if

	  for i=0 to 13
			if pAloc(p,tt,i,0) = 0 then
				pAloc(p,tt,i,1) = objrs("TP_ID") 
			end if
			if ((data+i) >= objrs("TP_DATAINICIAL")) and ((data+i) =< objrs("TP_DATAFINAL")) then
				pAloc(p,tt,i,0)= 1
			end if
	  next
		vetorAloc(count) = objrs("TP_ID") 
		count = count+1
		objrs.movenext
  wend

  if temAlocado then objrs.movefirst
  Dim nroLinhas
  nroLinhas = 0
  while not objrs.eof
		reg = objrs("TAREFA_ID")
		for i=0 to 100
			if aux(i) = reg then
				p = i
				exit for
			end if
		next

		tt =objrs("TAREFA_TIPO")
		if tt then
			tt = 0
		else
			tt = 1
		end if
			if pAloc(p,tt,14,0) = 0 then 'verifica se ja utilizou a tarefa
				If not(isnull(objrs("DESCRICAO_TAREFA"))) then
					descricao = objrs("DESCRICAO_TAREFA")
				else
					descricao = " "
				end if
				%>
				<TR BGCOLOR="white">
	  	  <td style="cursor:help" class="celula" align="left" BGCOLOR="<%=cordescricao%>" onmouseout="alteraCamada('');" onmouseover='alteraCamada("<%=objRS("TIPO")%> - <% trocaAspas(objrs("DESCRICAO_TAREFA"))%>");'>
				<font color="<%=cortexto%>" class="fonte1">
				<%= left(objRS("TIPO")&" - "&replace(descricao,vbcrlf," "),39)%></font>
				</td>
<%
				for i=0 to 13
					if (i mod 2)=1 then
						if ((nrodia=1)or(nrodia=7))or(feriado(i)) then 
							response.write("<td class='celula' background='img/bgrachu.gif' bgcolor='"&cordia2&"'>")
						else
							response.write("<td class='celula' bgcolor='"&cordia2&"'>")
						end if
				  else
						if ((nrodia=1)or(nrodia=7))or(feriado(i)) then 
							response.write("<td class='celula' background='img/bgrachu.gif' bgcolor='"&cordia2&"'>")
						else
							response.write("<td class='celula'>")
			  	  end if
				  end if
	
				  ' pintando a tabela de acordo com a alocacao da tarefa
					response.write("<TABLE WIDTH='100%' cellspacing=0 CELLPADDING=0>")
					if pAloc(p,tt,i,0) = 1 then %>
						<td id="cel_<%=pAloc(p,tt,i,1)%>_<%=i%>" style="cursor:hand; background-color:<%=corbarra%>;" ONCLICK="javascript:barraAlocacao(<%=pAloc(p,tt,i,1)%>)"><font class="fonte2">&nbsp;</td>
	<%		  else %>
						<td>&nbsp;</td>
	<%		  end if
					response.write("</td></TABLE>")
			  	response.write("</td>")
					nrodia = nrodia + 1
					if nrodia > 7 then 
						nrodia=1 
					end if
				next
				response.write("</TR>")
				nroLinhas = nroLinhas + 1
			end if ' fim verificacao de tarefa
	   	pAloc(p,tt,14,0) = 7
		objrs.movenext 
	wend 
	Call RecordSet(False, objRS, Null, Null)
	
end if 'TESTE

	Call Connection(False, objConn)

	'preenchendo o nro minimo de linhas
  do
		nrolinhas = nrolinhas + 1
'  for j=nroLinhas to 7%>
		<TR BGCOLOR="white">
		<td WIDTH="200" BGCOLOR="<%=cordescricao%>">&nbsp;</td> 
<%	for i=0 to 13
			if (i mod 2)=1 then
				if ((nrodia=1)or(nrodia=7))or(feriado(i)) then
					response.write("<td align='center' width='35' background='img/bgrachu.gif' BGCOLOR='"&cordia2&"'>&nbsp;</td>")    
  		  else
					response.write("<td align='center' width='35' BGCOLOR='"&cordia2&"'>&nbsp;</td>")
	      end if
	    else
				if ((nrodia=1)or(nrodia=7))or(feriado(i)) then 
					response.write("<td align='center' width='35' background='img/bgrachu.gif' bgcolor='"&cordia2&"'>&nbsp;</td>")
				else
					response.write("<td align='center' width='35'>&nbsp;</td>")
	      end if
	    end if
			nrodia = nrodia + 1
			if nrodia > 7 then 
				nrodia=1 
			end if
	  next%>
    </TR>
<%loop while nrolinhas < 8%>
</TABLE>
</td></TR>
</TABLE>
<script>
	maiorp=<%=count-1%>
<%for i=0 to count-1%>
	vetorAloc[<%= i%>] = new vetorAlocacao();
  vetorAloc[<%= i%>].tpid = <%= vetorAloc(i)%>;
<%next%>
</script>
<script>
verificaVoltar();
parent.frames[0].gravacookie("flag_1=0");
</script>
</BODY>
</HTML>
<!--#include file="includes\rodape.inc"-->