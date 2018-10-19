<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim RS
Dim chr_Indice
Dim int_TotalAgendamento
Dim objRS, objRSGLO, sSQL, objRSAnt, objRSAntGLO
Dim auxusernameCadastro,auxIPCadastro,auxNAg,auxDataHoraCadastro
Dim auxtipoatividade,auxNome,auxTelefone,auxEmail
Dim auxorgaoEmpresa,auxorigem,numag,auxatividade
Dim auxR1,auxR2,auxR3,auxR4,auxR5,auxR6 
Dim auxR7,auxR8,auxR9,auxR10,auxR11
Dim auxR1Ant,auxR2Ant,auxR3Ant,auxR4Ant,auxR5Ant,auxR6Ant 
Dim auxR7Ant,auxR8Ant,auxR9Ant,auxR10Ant,auxR11Ant
Dim auxC1,auxC2,auxC3,auxC4,auxC5,auxC6 
Dim auxC7,auxC8,auxC9,auxC10,auxC11
Dim auxC_3, auxC_4,prireg,ultreg,contreg,atureg,totresp
Dim dataprocurada
Dim i
Dim dataIni, dataFim
Dim chr_DataIni
Dim chr_DataFim


Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Pesquisa de Satisfação - Relatório Consolidado"
Call Tela.MostraCabecalho()
'''''call ImprimeCabecalho2("SISLAB - Pesquisa de Satisfação", MENU_ON, true, "", "Pesquisa de Satisfação - Relatório Consolidado", "", "")

dataIni = Trim(request("diadataIni") & "/" & request("mesdataIni") & "/" & request("anodataIni"))
dataFim= Trim(request("diadataFim") & "/" & request("mesdataFim") & "/" & request("anodataFim"))

if dataIni = "//" then dataIni = ""
if dataFim = "//" then dataFim = ""


chr_DataIni = Trim(request("anodataIni") & "-" & request("mesdataIni") & "-" & request("diadataIni"))
chr_DataFim = Trim(request("anodataFim") & "-" & request("mesdataFim") & "-" & request("diadataFim"))

If chr_DataIni = "'--'" Then chr_DataIni = "NULL" Else chr_DataIni = "'" & chr_DataIni & " 00:00'"
If chr_DataFim = "'--'" Then chr_DataFim = "NULL" Else chr_DataFim = "'" & chr_DataFim & " 00:00'"
%>
<script language="javascript">
var matriz=new Array()
x=0;
<%
If Request("enviou") = "1" Then

	'-->>>>> Da carga na lista de comentarios
	sSQL = "Select a.TA_ID AS PSQ_TipoAtiv, psq_id, psq_C1,psq_C2,psq_C3,psq_C4,psq_C5,psq_C6, "
	sSQL = sSQL & "psq_C7,psq_C8,psq_C9,psq_C10,psq_C11,psq_C_3,psq_C_4 "
	sSQL = sSQL & " From PesquisaSatisfacao p INNER JOIN vw_Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
	sSQL = sSQL & "WHERE 1 = 1 "
	sSQL = sSQL & "AND A.id_situacao = " & AS_Finalizado & " "
	if dataIni <> "" and dataFim = "" then
		'sSQL=sSQL&" AND PSQ_DataHoraCadastro >= CONVERT(DATETIME, '" & dataIni & "', 103) "
		sSQL=sSQL&" AND a.AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
	elseif dataIni = "" and dataFim <> "" then
		'sSQL=sSQL&" AND (PSQ_DataHoraCadastro < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
		sSQL=sSQL&" AND a.AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
	elseif dataIni <> "" and dataFim <> "" then
		'sSQL=sSQL&" AND PSQ_DataHoraCadastro BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
		sSQL=sSQL&" AND a.AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
	end if
	sSQL=sSQL&"  ORDER by a.TA_ID ; "

	call Env.RecordSet(true, objRS, sSQL)
	if Not objRS.EOF Then 
		objRS.MoveFirst
		do while not objRS.EOF 
%>
str='<%=objRS("psq_id")%>***<%=objRS("PSQ_TipoAtiv")%>***<%=Replace(objRS("psq_C1")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C2")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C3")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C4")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C5")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C6")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C7")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C8")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C9")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C10")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C11")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C_3")&" ",vbCRLF,"<BR>")%>***<%=Replace(objRS("psq_C_4")&" ",vbCRLF,"<BR>")%>***';
matriz[x]=str.split('***');

// x varia em colunas... matriz(x,y)
x++;
<%		objRS.MoveNext
		Loop
	End If
End If
%>
function retornavalor() {
	document.formulario.action="Cons_Ind_pesqsCRSem.asp";
	document.formulario.submit();
}
function janelacoment(partipo,parag,paritem, parserv, pardataini, pardatafim) {
    window.open("janelaComentariosGR.asp?tipo="+partipo+"&ag="+parag+"&it="+paritem+"&ser="+parserv+"&dataIni="+pardataini+"&dataFim="+pardatafim,'Comentarios','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=321,height=300, top=0, left=0');
}
function respostas(nag) {
	//formulario.numag.value=nag;
	//document.formulario.action="Cons_Resp_pesqsCRSem.asp";
	//formulario.submit();
	var jan = window.open('Cons_Resp_PesqsCRSem.asp?tipopesquisa=C&numag=' + nag, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	jan.focus();
}
function contC(parag, paritem, parativ, pardataini, pardatafim) {
	var cont=0;
	for (m=0;m<=matriz.length-1;m++) {	 
		if (matriz[m][1]==parag) {
			if (matriz[m][paritem]!='' & matriz[m][paritem]!=' ') {
				cont=cont+1;
			}
		} 
	}
	if (cont!=0)
		return('<a href="javascript: janelacoment(-6,'+parag+','+paritem+',\''+parativ+'\',\''+pardataini+'\',\''+pardatafim+'\');">Coment.:'+cont+'</a>');
	else
		return('-');
}
</script>
<!--SQL:<%=sSQL%>-->
<form method="post" action="Cons_Ind_pesqsCRSem.asp" name="formulario">
<input type="hidden" name="numag">
<input type="Hidden" name="enviou" value="1">
<table width="100%" class="tabela1" cellpadding="2" cellspacing="0">
<tr>
	<td colspan="2">
		&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px; font-weight: bold;">
			Análise Periódica dos Formulários de Satisfação
		</span>
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>
<tr>
	<td colspan="2"><b>Período:</b></td>
</tr>

<tr> 
	<td colspan="2">
		De <%call comboData("dataIni")%>&nbsp;até&nbsp;<%call comboData("dataFim")%>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="Button" value="Pesquisar" class="texto1" onclick="retornavalor();">
		<script language="JavaScript">
<%
If dataIni <> "" Then%>
			document.all.diadataIni.value = '<%=left(dataIni,2)%>';
			document.all.mesdataIni.value = '<%=mid(dataIni,4,2)%>';
			document.all.anodataIni.value = '<%=right(dataIni,4)%>';
<%
End If
If dataFim <> "" Then%>
			document.all.diadataFim.value = '<%=left(dataFim,2)%>';
			document.all.mesdataFim.value = '<%=mid(dataFim,4,2)%>';
			document.all.anodataFim.value = '<%=right(dataFim,4)%>';
<%
End If%>
		</script>
	 </td>
</tr>
<tr><td>&nbsp;</td></tr>
<%
if request("enviou") = "1" then
%>
<tr>
	<td colspan="2">
		<table width="100%" cellpadding="3" cellspacing="0" border="1" style="border: solid thin;">
<%
'		"FROM PesquisaSatisfacao p RIGHT JOIN vw_Agendamento a ON p.PSQ_NAg = a.AG_NUMERO " & VbCrLf & 
'		"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID " & VbCrLf & 

	sSQL = _
		"SET ANSI_WARNINGS OFF;" & VbCrLf & _
		"Select T.TA_Descricao, T.TA_ID AS PSQ_TipoAtiv, count(psq_id) as totresp, COALESCE(avg(psq_r1),0) as medr1, COALESCE(avg(psq_r2),0) as medr2, COALESCE(avg(psq_r3),0) as medr3, " & VbCrLf & _
		"  COALESCE(avg(psq_r4),0) as medr4, COALESCE(avg(psq_r5),0) as medr5, COALESCE(avg(psq_r6),0) as medr6, " & VbCrLf & _
		"  COALESCE(avg(psq_r7),0) as medr7, COALESCE(avg(psq_r8),0) as medr8, COALESCE(avg(psq_r9),0) as medr9, " & VbCrLf & _
		"  COALESCE(avg(psq_r10),0) as medr10, COALESCE(avg(psq_r11),0) as medr11 " & VbCrLf & _
		"FROM " & VbCrLf & _
		"	Tipo_atividade t " & VbCrLf & _
		"	left JOIN vw_Agendamento a ON t.TA_ID = a.TA_ID " & VbCrLf & _
		"	left JOIN PesquisaSatisfacao p ON p.PSQ_NAg = a.AG_NUMERO " & VbCrLf & _
		"WHERE 1 = 1 " & VbCrLf & _
		"	AND A.id_situacao = " & AS_Finalizado & " " & VbCrLf

	If dataIni <> "" and dataFim = "" Then
		sSQL = sSQL & " AND a.AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
	ElseIf dataIni = "" and dataFim <> "" Then
		sSQL = sSQL & " AND (a.AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
	ElseIf dataIni <> "" and dataFim <> "" Then
		sSQL = sSQL & " AND a.AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
	End If

	'sSQL = sSQL & "group by a.TA_ID, a.TA_Descricao;"
	sSQL = sSQL & "group by t.TA_ID, t.TA_Descricao;"


	rw "<!--AQUI SQL: " & sSQL & "-->"

	Call Env.RecordSet(true, objRS, sSQL)

	Do While Not (objRS.eof)
		totresp = objRS("totresp")
		numag = objRS("PSQ_TipoAtiv")
		auxatividade = objRS("TA_Descricao")
		If Not(IsNull(objRS("medr1"))) Then auxR1=objRS("medR1")
		If Not(IsNull(objRS("medr2"))) Then auxR2=objRS("medR2")
		If Not(IsNull(objRS("medr3"))) Then auxR3=objRS("medR3")
		If Not(IsNull(objRS("medr4"))) Then auxR4=objRS("medR4")
		If Not(IsNull(objRS("medr5"))) Then auxR5=objRS("medR5")
		If Not(IsNull(objRS("medr6"))) Then auxR6=objRS("medR6")
		If Not(IsNull(objRS("medr7"))) Then auxR7=objRS("medR7")
		If Not(IsNull(objRS("medr8"))) Then auxR8=objRS("medR8")
		If Not(IsNull(objRS("medr9"))) Then auxR9=objRS("medR9")
		If Not(IsNull(objRS("medr10"))) Then auxR10=objRS("medR10")
		If Not(IsNull(objRS("medr11"))) Then auxR11=objRS("medR11")

		'-- faz a media por tipo de atividade
		sSQL= _
				"SET ANSI_WARNINGS OFF; " & VbCrLf & _
				"Select a.TA_Descricao, t.TA_ID AS PSQ_TipoAtiv, count(psq_id) as totresp, COALESCE(avg(psq_r1),0) as medr1, avg(psq_r2) as medr2, COALESCE(avg(psq_r3),0) as medr3, " & VbCrLf & _
				"  COALESCE(avg(psq_r4),0) as medr4, COALESCE(avg(psq_r5),0) as medr5, COALESCE(avg(psq_r6),0) as medr6, " & VbCrLf & _
				"  COALESCE(avg(psq_r7),0) as medr7, COALESCE(avg(psq_r8),0) as medr8, COALESCE(avg(psq_r9),0) as medr9, " & VbCrLf & _
				"  COALESCE(avg(psq_r10),0) as medr10, COALESCE(avg(psq_r11),0) as medr11 " & VbCrLf & _
				"FROM PesquisaSatisfacao p INNER JOIN vw_Agendamento a ON p.PSQ_NAg = a.AG_NUMERO " & VbCrLf & _
				"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID " & VbCrLf & _
				"WHERE t.TA_ID = " & numag & " " & VbCrLf & _
				"  AND A.id_situacao = " & AS_Finalizado & " " & VbCrLf

		If dataIni <> "" and dataFim = "" Then
			sSQL = sSQL & " AND a.AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
		ElseIf dataIni = "" and dataFim <> "" Then
			sSQL = sSQL & " AND (a.AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
		ElseIf dataIni <> "" and dataFim <> "" Then
			sSQL = sSQL & " AND a.AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
		End If

		sSQL = sSQL & "GROUP BY t.TA_ID, a.TA_Descricao;"

		Call Env.RecordSet(true, objRSAnt, sSQL)

		If Not objRSAnt.eof Then
			auxR1Ant=objRSAnt("medR1")
			auxR2Ant=objRSAnt("medR2")
			auxR3Ant=objRSAnt("medR3")
			auxR4Ant=objRSAnt("medR4")
			auxR5Ant=objRSAnt("medR5")
			auxR6Ant=objRSAnt("medR6")
			auxR7Ant=objRSAnt("medR7")
			auxR8Ant=objRSAnt("medR8")
			auxR9Ant=objRSAnt("medR9")
			auxR10Ant=objRSAnt("medR10")
			auxR11Ant=objRSAnt("medR11")
		Else
			auxR1Ant=auxR1
			auxR2Ant=auxR2
			auxR3Ant=auxR3
			auxR4Ant=auxR4
			auxR5Ant=auxR5
			auxR6Ant=auxR6
			auxR7Ant=auxR7
			auxR8Ant=auxR8
			auxR9Ant=auxR9
			auxR10Ant=auxR10
			auxR11Ant=auxR11
		End If

		Set RS = Env.oConn.Execute("dbo.sp_IndiceRetornoSatisfacao " & _
					objRS("PSQ_TipoAtiv") & _
					", NULL, NULL, NULL, " & chr_DataIni & ", " & chr_DataFim _
				)

		If RS("ERRO") = 0 Then
			chr_Indice = Replace(RS("INDICE"), ".", ",")
			int_TotalAgendamento = RS("TOTALPESQUISA")
		Else
			chr_Indice = ""
			int_TotalAgendamento = 0
		End If
%>
<tr class="azul1bg">
	<td colspan="11">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Total de respostas:</b> <%=totresp%>
	&nbsp;&nbsp;&nbsp;
	<!--<b>Total de Agendamentos:</b> <%'=int_TotalAgendamento%> (Finalizados: <%'=rs("totalagendamento")%>) -->
	<b>Total de Agendamentos Finalizados:</b> <%=rs("totalagendamento")%>
	&nbsp;&nbsp;&nbsp;
	<b>Índice de retorno:</b> <%=chr_Indice%>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<b><a href="javascript:respostas(<%=numag%>)">Ver Respostas</a></b> - <b>Comentário Adicional</b> - <b>Outros Comentários</b><br>
	<b>Serviço:</b> <%=objRS("TA_Descricao")%>
	</font>
<!--
	<%'="dbo.sp_IndiceRetornoSatisfacao " & objRS("PSQ_TipoAtiv") & ", NULL, NULL, NULL, " & chr_DataIni & ", " & chr_DataFim%>
	<br>
	<%'=sSQL%>
-->
	</td>
</tr>
<tr class="azul1bg">
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Comunicação</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Cortesia</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Presteza</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Flexibilidade</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Rapidez</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Iniciativa</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Confiabilidade</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Infraestrutura</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Ambiente</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Acesso</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Geral</b></font>
	</td>
</tr>
<tr bgcolor="#FFFFFF">
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR1)&"<br>"&retornaopcao1(auxR1)&"<br>"&retornaopcaoAnt(auxR1, auxR1Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,2,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR2)&"<br>"&retornaopcao1(auxR2)&"<br>"&retornaopcaoAnt(auxR2,auxR2Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,3,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR3)&"<br>"&retornaopcao1(auxR3)&"<br>"&retornaopcaoAnt(auxR3,auxR3Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,4,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR4)&"<br>"&retornaopcao1(auxR4)&"<br>"&retornaopcaoAnt(auxR4,auxR4Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,5,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR5)&"<br>"&retornaopcao1(auxR5)&"<br>"&retornaopcaoAnt(auxR5,auxR5Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,6,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR6)&"<br>"&retornaopcao1(auxR6)&"<br>"&retornaopcaoAnt(auxR6,auxR6Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,7,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR7)&"<br>"&retornaopcao1(auxR7)&"<br>"&retornaopcaoAnt(auxR7,auxR7Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,8,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR8)&"<br>"&retornaopcao1(auxR8)&"<br>"&retornaopcaoAnt(auxR8,auxR8Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,9,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR9)&"<br>"&retornaopcao1(auxR9)&"<br>"&retornaopcaoAnt(auxR9,auxR9Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,10,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR10)&"<br>"&retornaopcao1(auxR10)&"<br>"&retornaopcaoAnt(auxR10,auxR10Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,11,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR11)&"<br>"&retornaopcao1(auxR11)&"<br>"&retornaopcaoAnt(auxR11,auxR11Ant)%><br><script language="javascript">document.write(contC(<%=numag%>,12,'<%=auxatividade%>','<%=dataIni%>','<%=dataFim%>'))</script></font>
	</td>
</tr>
<tr bgcolor="#666625">
	<td colspan="11"></td>
</tr>
<%		objRS.moveNext
	Loop


	'--------------------------------------------------------------------------------------
	'
	' TOTAL GERAL - faz o calculo geral
	'
	'--------------------------------------------------------------------------------------
	sSQL="Select count(psq_id) as totresp, avg(psq_r1) as medr1, avg(psq_r2) as medr2, avg(psq_r3) as medr3, "
	sSQL=sSQL&"  avg(psq_r4) as medr4, avg(psq_r5) as medr5, avg(psq_r6) as medr6, "
	sSQL=sSQL&"  avg(psq_r7) as medr7, avg(psq_r8) as medr8, avg(psq_r9) as medr9, "
	sSQL=sSQL&"  avg(psq_r10) as medr10, avg(psq_r11) as medr11 "
	sSQL=sSQL&"  from PesquisaSatisfacao p INNER JOIN vw_Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
	sSQL=sSQL&"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID "
	sSQL = sSQL & "WHERE 1 = 1 "
	sSQL = sSQL & "AND A.id_situacao = " & AS_Finalizado & " "

	if dataIni <> "" and dataFim = "" then
		'sSQL=sSQL&" AND PSQ_DataHoraCadastro >= CONVERT(DATETIME, '" & dataIni & "', 103) "
		sSQL=sSQL&" AND a.AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
	elseif dataIni = "" and dataFim <> "" then
		'sSQL=sSQL&" AND (PSQ_DataHoraCadastro < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
		sSQL=sSQL&" AND (a.AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
	elseif dataIni <> "" and dataFim <> "" then
		'sSQL=sSQL&" AND PSQ_DataHoraCadastro BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
		sSQL=sSQL&" AND a.AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
	end if

	call Env.RecordSet(true, objRSGLO, sSQL)

	if not objRSGLO.eof then objRSGLO.Movefirst

	if  not(IsNull(objRSGLO("medr1")))  and  not(IsNull(objRSGLO("medr2"))) and  not(IsNull(objRSGLO("medr3"))) and _
		not(IsNull(objRSGLO("medr4"))) and  not(IsNull(objRSGLO("medr5"))) and not(IsNull(objRSGLO("medr6"))) and _
		not(IsNull(objRSGLO("medr7"))) and not(IsNull(objRSGLO("medr8"))) and  not(IsNull(objRSGLO("medr9"))) and _
		not(IsNull(objRSGLO("medr10"))) and not(IsNull(objRSGLO("medr11"))) then

		totresp=objRSGLO("totresp")
		if not(IsNull(objRSGLO("medr1"))) then auxR1=objRSGLO("medR1")
		if not(IsNull(objRSGLO("medr2"))) then auxR2=objRSGLO("medR2")
		if not(IsNull(objRSGLO("medr3"))) then auxR3=objRSGLO("medR3")
		if not(IsNull(objRSGLO("medr4"))) then auxR4=objRSGLO("medR4")
		if not(IsNull(objRSGLO("medr5"))) then auxR5=objRSGLO("medR5")
		if not(IsNull(objRSGLO("medr6"))) then auxR6=objRSGLO("medR6")
		if not(IsNull(objRSGLO("medr7"))) then auxR7=objRSGLO("medR7")
		if not(IsNull(objRSGLO("medr8"))) then auxR8=objRSGLO("medR8")
		if not(IsNull(objRSGLO("medr9"))) then auxR9=objRSGLO("medR9")
		if not(IsNull(objRSGLO("medr10"))) then auxR10=objRSGLO("medR10")
		if not(IsNull(objRSGLO("medr11"))) then auxR11=objRSGLO("medR11")

		sSQL="Select count(psq_id) as totresp, avg(psq_r1) as medr1, avg(psq_r2) as medr2, avg(psq_r3) as medr3, "
		sSQL=sSQL&"  avg(psq_r4) as medr4, avg(psq_r5) as medr5, avg(psq_r6) as medr6, "
		sSQL=sSQL&"  avg(psq_r7) as medr7, avg(psq_r8) as medr8, avg(psq_r9) as medr9, "
		sSQL=sSQL&"  avg(psq_r10) as medr10, avg(psq_r11) as medr11 "
		sSQL=sSQL&"  from PesquisaSatisfacao p INNER JOIN vw_Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
		sSQL=sSQL&"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID "
		sSQL = sSQL & "WHERE 1 = 1 "
		sSQL = sSQL & "AND A.id_situacao = " & AS_Finalizado & " "

		if dataIni <> "" and dataFim = "" then
			'sSQL=sSQL&" AND PSQ_DataHoraCadastro >= CONVERT(DATETIME, '" & dataIni & "', 103) "
			sSQL=sSQL&" AND a.AG_DATATERMINO >= CONVERT(DATETIME, '" & dataIni & "', 103) "
		elseif dataIni = "" and dataFim <> "" then
			'sSQL=sSQL&" AND (PSQ_DataHoraCadastro < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
			sSQL=sSQL&" AND (a.AG_DATATERMINO < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
		elseif dataIni <> "" and dataFim <> "" then
			'sSQL=sSQL&" AND PSQ_DataHoraCadastro BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
			sSQL=sSQL&" AND a.AG_DATATERMINO BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
		end if

		call Env.RecordSet(true, objRSAntGLO, sSQL)

		if not(IsNull(objRSAntGLO("medr1"))) and not(IsNull(objRSAntGLO("medr2"))) and not(IsNull(objRSAntGLO("medr3"))) and _
			not(IsNull(objRSAntGLO("medr4"))) and not(IsNull(objRSAntGLO("medr5"))) and not(IsNull(objRSAntGLO("medr6"))) and _
			not(IsNull(objRSAntGLO("medr7"))) and not(IsNull(objRSAntGLO("medr8"))) and not(IsNull(objRSAntGLO("medr9"))) and _
			not(IsNull(objRSAntGLO("medr10"))) and not(IsNull(objRSAntGLO("medr11"))) then
			auxR1Ant=objRSAntGLO("medR1")
			auxR2Ant=objRSAntGLO("medR2")
			auxR3Ant=objRSAntGLO("medR3")
			auxR4Ant=objRSAntGLO("medR4")
			auxR5Ant=objRSAntGLO("medR5")
			auxR6Ant=objRSAntGLO("medR6")
			auxR7Ant=objRSAntGLO("medR7")
			auxR8Ant=objRSAntGLO("medR8")
			auxR9Ant=objRSAntGLO("medR9")
			auxR10Ant=objRSAntGLO("medR10")
			auxR11Ant=objRSAntGLO("medR11")
		Else
			auxR1Ant=auxR1
			auxR2Ant=auxR2
			auxR3Ant=auxR3
			auxR4Ant=auxR4
			auxR5Ant=auxR5
			auxR6Ant=auxR6
			auxR7Ant=auxR7
			auxR8Ant=auxR8
			auxR9Ant=auxR9
			auxR10Ant=auxR10
			auxR11Ant=auxR11
		End If
%>
<tr class="azul1bg">
	<td colspan=11>
		<FONT face="tahoma" color="#000050" style="font-size:7pt">
		<b>Total de respostas:</b> <%=totresp%>
<%
Set RS = Env.oConn.Execute("dbo.sp_IndiceRetornoSatisfacao " & "NULL, NULL, NULL, NULL, " & chr_DataIni & ", " & chr_DataFim)

If RS("ERRO") = 0 Then
	chr_Indice = Replace(RS("INDICE"), ".", ",")
	int_TotalAgendamento = RS("TOTALPESQUISA")
Else
	chr_Indice = ""
	int_TotalAgendamento = 0
End If
%>
		&nbsp;&nbsp;&nbsp;
<!--		<b>Total de Agendamentos:</b> <%'=int_TotalAgendamento%> (Finalizados: <%'=rs("totalagendamento")%>) -->
		<b>Total de Agendamentos Finalizados:</b> <%=rs("totalagendamento")%>
		&nbsp;&nbsp;&nbsp;
		<b>Índice de retorno:</b> <%=chr_Indice%>
		<br>
		<b>TOTAL</b></font>
		<%'="dbo.sp_IndiceRetornoSatisfacao " & "NULL, NULL, NULL, NULL, " & chr_DataIni & ", " & chr_DataFim%>
	</td>
</tr>

<tr  class="azul1bg">
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Comunicação</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Cortesia</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Presteza</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Flexibilidade</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Rapidez</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Iniciativa</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Confiabilidade</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Infraestrutura</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Ambiente</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Acesso</b></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<b>Geral</b></font>
	</td>
</tr>
<tr bgcolor="#FFFFFF">
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR1)&"<br>"&retornaopcao1(auxR1)&"<br>"&retornaopcaoAnt(auxR1,auxR1Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR2)&"<br>"&retornaopcao1(auxR2)&"<br>"&retornaopcaoAnt(auxR2,auxR2Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR3)&"<br>"&retornaopcao1(auxR3)&"<br>"&retornaopcaoAnt(auxR3,auxR3Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR4)&"<br>"&retornaopcao1(auxR4)&"<br>"&retornaopcaoAnt(auxR4,auxR4Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR5)&"<br>"&retornaopcao1(auxR5)&"<br>"&retornaopcaoAnt(auxR5,auxR5Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR6)&"<br>"&retornaopcao1(auxR6)&"<br>"&retornaopcaoAnt(auxR6,auxR6Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR7)&"<br>"&retornaopcao1(auxR7)&"<br>"&retornaopcaoAnt(auxR7,auxR7Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR8)&"<br>"&retornaopcao1(auxR8)&"<br>"&retornaopcaoAnt(auxR8,auxR8Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR9)&"<br>"&retornaopcao1(auxR9)&"<br>"&retornaopcaoAnt(auxR9,auxR9Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR10)&"<br>"&retornaopcao1(auxR10)&"<br>"&retornaopcaoAnt(auxR10,auxR10Ant)%><br></font>
	</td>
	<td align="center">
	<FONT face="tahoma" color="#000050" style="font-size:7pt">
	<%=retornaaprox(auxR11)&"<br>"&retornaopcao1(auxR11)&"<br>"&retornaopcaoAnt(auxR11,auxR11Ant)%><br></font>
	</td>
	</tr>
	<tr bgcolor="#666625">
	<td colspan=11>
	</td>
</tr>
<%
		objRSGLO.moveNext
	End If

	Call Env.RecordSet(False, objRSGLO, sSQL)
	Call Env.RecordSet(False, objRS, sSQL)

End If
%>
</table>
</form>
<%
'----------------------------------------------------------------
'
' funcoes usadas nesta página para Exibição dos valores
'
'----------------------------------------------------------------
function retornaaprox(opcao)
	Dim auxint,auxdec,auxnum

	auxnum=opcao
	auxint=Int(opcao)
	auxdec=CInt((auxnum-auxint)*100)

	If Len(auxdec)=1 Then
		auxdec=left(auxdec,1)&"0"
	End If
	If Len(auxdec)=0 Then
		auxdec=auxdec & "00"
	End If
	retornaaprox =  auxint&","&auxdec
End Function

Function retornaopcao(opcao)
	If opcao=1 Then retornaopcao="Muito Insatisfeito" End If
	If opcao=2 Then retornaopcao="Insatisfeito" End If
	If opcao=3 Then retornaopcao="Nem Satisfeito, Nem Insatisfeito" End If
	If opcao=4 Then retornaopcao="Satisfeito" End If
	If opcao=5 Then retornaopcao="Muito Satisfeito" End If
	If Isnull(opcao) Then retornaopcao="Não Respondido" End If
End Function

Function retornaopcao1(opcao)
	if opcao < 3 then retornaopcao1="<img width=15 height=15 src='img/smile3.gif'>" end if
	if (opcao >= 3 and opcao < 4) then retornaopcao1="<img width=15 height=15 src='img/smile2.gif'>" end if
	if opcao >= 4 then retornaopcao1="<img width=15 height=15 src='img/smile1.gif'>" end if
End Function

Function retornaopcaoAnt(opcao, ant)
	Dim varianca : varianca = 0.50 '-- varianca de acordo com a norma do CRT PR4.7
	Dim opcao1, ant1

	If isnull(opcao) or opcao = "" or isempty(opcao) Then
		opcao1 = 0
	Else
		opcao1 = CDbl(opcao * 1)
	End If
	If isnull(ant) or ant = "" or isempty(ant) Then
		ant1 = 0
	Else
		ant1 = CDbl(ant * 1)
	End If
	If (opcao1 > ant1 + varianca) Then retornaopcaoAnt = "<img width=15 height=15 src='img/U_arrow.gif'>" End If
	If (opcao1 < ant1 - varianca) Then retornaopcaoAnt = "<img width=15 height=15 src='img/D_arrow.gif'>" End If
	If (opcao1 <= ant1 + varianca) And (opcao1 >= ant1 - varianca) Then retornaopcaoAnt = "<img width=15 height=15 src='img/R_arrow.gif'>" End If
End Function

Function retornacomentario(comenta)
	if Isnull(comenta) or comenta="" then
		retornacomentario = "Sem Coment."
	else
		retornacomentario = "Comentário: "&comenta 
	end if
End Function
'-----------------------------------------------------

Call Tela.MostraRodape()
%>
