<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
'On Error Resume Next

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Consulta Pesquisa de Satisfação", "", "")

Dim objSiteRS, sSQL,objSiteRS1
Dim auxusernameCadastro,auxIPCadastro,auxNAg,auxDataHoraCadastro
Dim auxtipoatividade,auxNome,auxTelefone,auxEmail
Dim auxorgaoEmpresa,auxorigem,numag
Dim auxR1,auxR2,auxR3,auxR4,auxR5,auxR6 
Dim auxR7,auxR8,auxR9,auxR10,auxR11
Dim auxC1,auxC2,auxC3,auxC4,auxC5,auxC6 
Dim auxC7,auxC8,auxC9,auxC10,auxC11
Dim auxC_3, auxC_4,prireg,ultreg,contreg,atureg,totresp
Dim dataIni, dataFim
%>
<script language="javascript">
var matriz=new Array()
x=0;
<%
'sSQL = "Select psq_nag, psq_id, psq_C1,psq_C2,psq_C3,psq_C4,psq_C5,psq_C6, "
'sSQL = sSQL &"psq_C7,psq_C8,psq_C9,psq_C10,psq_C11,psq_C_3,psq_C_4 "
'sSQL = sSQL &" From PesquisaSatisfacao ORDER BY psq_nag asc ; "
'call RecordSet( true, objSiteRS, sSQL, objConn)

'If Not ObjSiteRS.EOF Then ObjSiteRS.MoveFirst

'do while not ObjSiteRS.EOF 
%>
//str='<%'=ObjSiteRS("psq_id")%>***<%'=ObjSiteRS("psq_nag")%>***<%'=Replace(ObjSiteRS("psq_C1")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C2")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C3")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C4")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C5")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C6")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C7")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C8")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C9")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C10")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C11")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C_3")&" ",vbCRLF,"<BR>")%>***<%'=Replace(ObjSiteRS("psq_C_4")&" ",vbCRLF,"<BR>")%>***';matriz[x]=str.split('***');x++;
<%
'	ObjSiteRS.movenext
'loop
'call RecordSet(false, objSiteRS, null, objConn)
%>
function janelacoment(parag,paritem)
{
    window.open('janelaComentarios.asp?ag='+parag+'&it='+paritem,'Comentarios','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=317,height=300, top=0, left=0');
}
function respostas(nag)
{
//	formulario.numag.value=nag;
//	formulario.submit();
	var jan = window.open('Cons_Resp_PesqsCRSem.asp?tipopesquisa=A&numag=' + nag, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	jan.focus();
}
function contC(parag,paritem)
{
	cont=0;
	for (m=0;m<=matriz.length-1;m++)
	 {	 
	 if (matriz[m][1]==parag) 
		{
		  if (matriz[m][paritem]!='' & matriz[m][paritem]!=' ')
			{
			cont=cont+1;
			}
		} 
         }
	  if (cont!=0)
		{ 
		return('<a href="javascript: janelacoment('+parag+','+paritem+');">Coment.:'+cont+'</a>')
		}
        else  return('-');
}
</script>
<FONT style="font-size:3pt">
<BR></font>
<table width="100%" class="tabela1">
<tr>
	<th>Análise Global dos Formulários de Satisfação</th>
</tr>
<tr>
	<td>
		<table width="100%" class="tabela1" cellpadding="2" cellspacing="0">
<%
auxAs=request("auxAs")
auxRT=request.form("rt")
auxRAT=request.form("rat")
auxtipoteste=request.form("tipoteste")
auxdiasteste=request.form("diasteste")
auxsolicitante=request.form("solicitante")
auxtecnologia=request.form("tecnologia")
auxorgaosel=request.form("orgao")
auxClientes = (request.form("chkClientes")="on")
dataIni = request("anoIni") & "-" & request("mesIni") & "-" & request("diaIni") & " 00:00"
dataFim = request("anoFim") & "-" & request("mesFim") & "-" & request("diaFim") & " 00:00"

sSQL= "SET ANSI_WARNINGS OFF; " & _
	  " SELECT /*T_TITULO,*/ f.ag_rat, f.ta_descricao,f.ag_responsavel,f.ag_username,f.ta_id, f.ag_orgao,f.ag_clienteexterno,ag_datainicio "  & _
	  " ,psq_nag, count(psq_id) as totresp, COALESCE(avg(psq_r1),0) as medr1, COALESCE(avg(psq_r2),0) as medr2, COALESCE(avg(psq_r3),0) as medr3, "  & _
	  " COALESCE(avg(psq_r4),0) as medr4, COALESCE(avg(psq_r5),0) as medr5, COALESCE(avg(psq_r6),0) as medr6, "  & _
	  " COALESCE(avg(psq_r7),0) as medr7, COALESCE(avg(psq_r8),0) as medr8, COALESCE(avg(psq_r9),0) as medr9, "  & _
	  " COALESCE(avg(psq_r10),0) as medr10, COALESCE(avg(psq_r11),0) as medr11 "  & _
	  " from PesquisaSatisfacao  "  & _
	  " inner join vw_Agendamento f on f.ag_numero = psq_nag " & _
	  " /* left JOIN Ordem_de_Servico os ON os.AG_NUMERO = f.AG_NUMERO*/ "  & _
	  " /* left JOIN Testes t ON os.T_ID = t.T_ID*/ "  & _
	  " /* left JOIN Tipo_Atividade ta ON f.TA_ID = ta.TA_ID */ " & _
	  " where psq_nag = psq_nag AND ID_SITUACAO = " & AS_Finalizado & " "

if auxdiasteste <> "" then
	sSQL = sSQL & " AND DATEDIFF(day, ag_datainicio, getDate() - " & auxdiasteste & ") < 0 "
end if

if auxAS <> "" then
    sSQL=sSQL&" AND psq_nag=" & auxAS
end if

if (request("anoIni") <> "" and request("mesIni") <> "" and request("diaIni") <> "") and _
	(request("anoFim") <> "" and request("mesFim") <> "" and request("diaFim") <> "") then
    sSQL=sSQL&" AND PSQ_DataHoraCadastro BETWEEN '" & dataIni & "' AND '" & dataFim & "' "
end if

if auxtipoteste<>"" then
	sSQL=sSQL&" AND f.ta_id = " & auxtipoteste & ""
end if

if auxRT<>"" then
    sSQL=sSQL&" AND f.AG_Responsavel='"&auxRT&"' "
end if

if auxRAT<>"" then
    sSQL=sSQL&" AND f.AG_RAT='"&auxRAT&"' "
end if

if auxsolicitante<>"" then
    sSQL=sSQL&" AND UPPER(f.ag_username) = '" & ucase(auxsolicitante) & "' "
end if

if auxtecnologia<>"" then
    sSQL=sSQL&" AND f.TA_ID = '" & auxtecnologia & "' "
end if

if auxorgaosel<>"" then
    sSQL=sSQL&" AND ag_orgao='"&auxorgaosel&"' "
end if

if auxClientes = true then
    sSQL=sSQL & " AND Not(ag_clienteexterno Is Null) and (ag_clienteexterno <> '')"
end if

sSQL = sSQL & " group by psq_nag, f.ta_descricao, f.ag_rat, f.ag_responsavel, f.ag_username, f.ta_id, f.ag_orgao, f.ag_clienteexterno, ag_datainicio /*, T_TITULO*/ "
sSQL = sSQL & " order  by psq_nag desc;"

'response.write ssql
'response.end
response.write "<!-- SQL: " & ssql & " -->"

call Env.RecordSet(true, objSiteRS, sSQL)

if objSiteRS.eof and objSiteRS.Bof then%>
<tr class="texto1">
	<td colspan="11" align="center">
		<b>Não existe pesquisa que satisfaça os requisitos da consulta.</b>
	</td>
</tr>
<%
else
	Do While not(objSiteRS.eof)
		totresp=objSiteRS("totresp")
		numag=objSiteRS("PSQ_nag")
		auxR1=objSiteRS("medR1")
		auxR2=objSiteRS("medR2")
		auxR3=objSiteRS("medR3")
		auxR4=objSiteRS("medR4")
		auxR5=objSiteRS("medR5")
		auxR6=objSiteRS("medR6")
		auxR7=objSiteRS("medR7")
		auxR8=objSiteRS("medR8")
		auxR9=objSiteRS("medR9")
		auxR10=objSiteRS("medR10")
		auxR11=objSiteRS("medR11")
%>
<tr>
	<td colspan=11>
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Número Agendamento:</b> <a href="ficha_as.asp?selecao=<%=numag%>"><%=numag%></a> - <b>total de respostas:</b> <%=totresp%> - <b><a href="javascript:respostas(<%=numag%>)">Ver Respostas</a></b> - <b>Comentário Adicional</b> - <b>Outros Comentários</b><br>
	<b>Serviço:</b> <%=objSiteRS("ta_descricao")%><%'If Not IsNull(objSiteRS("T_TITULO")) Then Response.Write " - " & objSiteRS("T_TITULO")%></font>
	</td>
</tr>
<tr><td colspan="11" height="5px"></td></tr>
<tr class="realce1" style="font-size:7pt">
	<td align="center">Comunicação</td>
	<td align="center">Cortesia</td>
	<td align="center">Presteza</td>
	<td align="center">Flexibilidade</td>
	<td align="center">Rapidez</td>
	<td align="center">Iniciativa</td>
	<td align="center">Confiabilidade</td>
	<td align="center">Infraestrutura</td>
	<td align="center">Ambiente</td>
	<td align="center">Acesso</td>
	<td align="center">Geral</td>
</tr>
<tr>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR1)&"<br>"&retornaopcao1(auxR1)%><br><script language="javascript">document.write(contC(<%=numag%>,2))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR2)&"<br>"&retornaopcao1(auxR2)%><br><script language="javascript">document.write(contC(<%=numag%>,3))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR3)&"<br>"&retornaopcao1(auxR3)%><br><script language="javascript">document.write(contC(<%=numag%>,4))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR4)&"<br>"&retornaopcao1(auxR4)%><br><script language="javascript">document.write(contC(<%=numag%>,5))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR5)&"<br>"&retornaopcao1(auxR5)%><br><script language="javascript">document.write(contC(<%=numag%>,6))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR6)&"<br>"&retornaopcao1(auxR6)%><br><script language="javascript">document.write(contC(<%=numag%>,7))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR7)&"<br>"&retornaopcao1(auxR7)%><br><script language="javascript">document.write(contC(<%=numag%>,8))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR8)&"<br>"&retornaopcao1(auxR8)%><br><script language="javascript">document.write(contC(<%=numag%>,9))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR9)&"<br>"&retornaopcao1(auxR9)%><br><script language="javascript">document.write(contC(<%=numag%>,10))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR10)&"<br>"&retornaopcao1(auxR10)%><br><script language="javascript">document.write(contC(<%=numag%>,11))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR11)&"<br>"&retornaopcao1(auxR11)%><br><script language="javascript">document.write(contC(<%=numag%>,12))</script></font>
	</td>
</tr>
<tr bgcolor="#666625">
	<td colspan=11></td>
</tr>
<%
		'End if
		objSiteRS.moveNext
	Loop
end if
%>
</table>
<form name="formulario" action="Cons_Resp_pesqsCRSem.asp" method="post">
<input type="hidden" name="numag" value="">
</form>
<%
Call imprimeRodape(RODAPE_OFF)
%>