<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Call Tela.ImprimeCabecalho2("SISLAB - Pesquisa de Satisfação", MENU_OFF, false, "", "Consulta Pesquisa de Satisfação", "window.close()", "")

Dim objSiteRS, sSQL, objSiteRS1
Dim auxusernameCadastro,auxIPCadastro,auxNAg,auxDataHoraCadastro
Dim auxNome,auxTelefone,auxEmail, auxAG
Dim auxorgaoEmpresa,auxorigem,numag
Dim auxR1,auxR2,auxR3,auxR4,auxR5,auxR6 
Dim auxR7,auxR8,auxR9,auxR10,auxR11
Dim auxC1,auxC2,auxC3,auxC4,auxC5,auxC6 
Dim auxC7,auxC8,auxC9,auxC10,auxC11
Dim auxC_3, auxC_4,prireg,ultreg,contreg,atureg,totresp
Dim parnag, partadesc, tipopesquisa, auxAg_Numero

tipopesquisa = UCase(request("tipopesquisa"))	'-- Analitico / Consolidado
parnag = request("numag")
dataIni = Trim(request("diadataIni") & "/" & request("mesdataIni") & "/" & request("anodataIni"))
dataFim= Trim(request("diadataFim") & "/" & request("mesdataFim") & "/" & request("anodataFim"))

If TipoPesquisa = "A" Then
	sSQL="Select TA_DESCRICAO from Tipo_Atividade where TA_ID = (SELECT TA_ID FROM Agendamento WHERE AG_NUMERO = " & parnag & ")"
Else
	sSQL="Select TA_DESCRICAO from Tipo_Atividade where TA_ID = " & parnag
End If

call Env.recordset(true, objSiteRS, sSQL)

If objSiteRS.Eof And objSiteRS.Bof Then
	partadesc=""
Else
	partadesc=objSiteRS("TA_DESCRICAO")
End If

function retornaaprox(opcao)
	dim auxint,auxdec,auxnum
	auxnum=opcao
	auxint=int(opcao)
	auxdec=cint((auxnum-auxint)*100)
	if len(auxdec)=1 then
		auxdec=left(auxdec,1)&"0"
	end if
	if len(auxdec)=0 then
		auxdec=auxdec&"00"
	end if
	retornaaprox=auxint&","&auxdec
end function

function retornaopcao(opcao)
	if opcao=1 then retornaopcao="Muito Insatisfeito" end if
	if opcao=2 then retornaopcao="Insatisfeito" end if 
	if opcao=3 then retornaopcao="Nem Satisfeito, Nem Insatisfeito" end if
	if opcao=4 then retornaopcao="Satisfeito" end if
	if opcao=5 then retornaopcao="Muito Satisfeito" end if
	if Isnull(opcao) then retornaopcao="Não Respondido" end if
end function

function retornacomentario(comenta)
	if Isnull(comenta) or comenta="" then retornacomentario="Sem Comentário" else retornacomentario="Comentário: "&comenta end if
end function

function retornaopcao1(opcao)
	if opcao<3 then retornaopcao1="<img width=15 height=15 src='img/smile3.gif'>" end if
	if (opcao>=3 and opcao<4) then retornaopcao1="<img width=15 height=15 src='img/smile2.gif'>" end if
	if opcao>=4 then retornaopcao1="<img width=15 height=15 src='img/smile1.gif'>" end if
end function
%>
<script language="javascript">
function parafrente()
{
	formulario.operacao.value=1;
	formulario.submit();
}

function paratras()
{
//move para tras
	formulario.operacao.value=0
	formulario.submit();
}
</script>

<FONT style="font-size:10pt">
<BR>
</font>
<table width="580" border="1" cellpadding="2" cellspacing="2" class="table-bordered" style="border: solid thin;">
<tr>
	<td class="azul3bg" style="color:#FFFFFF; font-size: 12px;">
	<b>&nbsp;&nbsp;Análise Individual dos Formulários de Satisfação</b><br>
	&nbsp;&nbsp;Tipo de Atividade: <%=partadesc%>
	</td>
</tr>
<%
sSQL = "Select * "
sSQL = sSQL&"  from PesquisaSatisfacao p INNER JOIN Agendamento a ON p.PSQ_NAg = a.AG_NUMERO "
sSQL = sSQL&"  INNER JOIN Tipo_atividade t ON t.TA_ID = a.TA_ID "

If TipoPesquisa = "A" Then
	sSQL=sSQL&"  where a.AG_NUMERO = " & parnag
Else
	sSQL=sSQL&"  where t.TA_ID = " & parnag

	if dataIni <> "//" and dataFim = "//" then
		sSQL=sSQL&"  AND "
		sSQL=sSQL&"  PSQ_DataHoraCadastro >= CONVERT(DATETIME, '" & dataIni & "', 103) "
	elseif dataIni = "//" and dataFim <> "//" then
		sSQL=sSQL&"  AND "
		sSQL=sSQL&"  (PSQ_DataHoraCadastro < CONVERT(DATETIME, '" & dataFim & "', 103) + 1 "
	elseif dataIni <> "//" and dataFim <> "//" then
		sSQL=sSQL&"  AND "
		sSQL=sSQL&"  PSQ_DataHoraCadastro BETWEEN CONVERT(DATETIME, '" & dataIni & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) "
	end if
End If
sSQL=sSQL&" order by AG_NUMERO asc; "
'response.write ssql
'response.end
call Env.Recordset(true, objSiteRS, sSQL)

objSiteRS.MoveFirst
prireg = objSiteRS("psq_id")
contreg = objSiteRS.RecordCount

do while not(objSiteRS.eof)
	auxAG = objSiteRS("AG_NUMERO")
	auxusernameCadastro=UCase(objSiteRS("PSQ_UsernameCadastro"))
	auxIPCadastro=objSiteRS("PSQ_IPCAdastro")
	auxDataHoraCadastro=objSiteRS("PSQ_DataHoraCAdastro")
	auxNAg=objSiteRS("PSQ_NAg")  
	auxNome=objSiteRS("PSQ_Nome")
	auxTelefone=objSiteRS("PSQ_Telefone")
	auxEmail=objSiteRS("PSQ_Email")

	If trim(auxnome)="" then 
		auxnome="anônimo"
	end if

	If trim(auxTelefone)="" then 
		auxTelefone="não informado"
	end if

	If trim(auxEmail)="" or IsNull(auxEmail) then 
		auxEmail="não informado"
	end if

	auxOrgaoEmpresa=objSiteRS("PSQ_OrgaoEmpresa")
	auxOrigem=objSiteRS("PSQ_Origem")
	auxR1=objSiteRS("PSQ_R1")
	auxR2=objSiteRS("PSQ_R2")
	auxR3=objSiteRS("PSQ_R3")
	auxR4=objSiteRS("PSQ_R4")
	auxR5=objSiteRS("PSQ_R5")
	auxR6=objSiteRS("PSQ_R6")
	auxR7=objSiteRS("PSQ_R7")
	auxR8=objSiteRS("PSQ_R8")
	auxR9=objSiteRS("PSQ_R9")
	auxR10=objSiteRS("PSQ_R10")
	auxR11=objSiteRS("PSQ_R11")
	auxC1=objSiteRS("PSQ_C1")
	auxC2=objSiteRS("PSQ_C2")
	auxC3=objSiteRS("PSQ_C3")
	auxC4=objSiteRS("PSQ_C4")
	auxC5=objSiteRS("PSQ_C5")
	auxC6=objSiteRS("PSQ_C6")
	auxC7=objSiteRS("PSQ_C7")
	auxC8=objSiteRS("PSQ_C8")
	auxC9=objSiteRS("PSQ_C9")
	auxC10=objSiteRS("PSQ_C10")
	auxC11=objSiteRS("PSQ_C11")
	auxC_3=objSiteRS("PSQ_C_3")
	auxC_4=objSiteRS("PSQ_C_4")
	auxAg_Numero = objSiteRS("AG_NUMERO")
%>
<tr>
	<td>
		<table border="0" width="100%" class="table-bordered" cellpadding="0" cellspacing="8">

		<tr valign="top">
			<td width="120px"><b>N. Agendamento:</b></td>
			<td width="*"><b><%=auxAg_Numero%></b></td>
		</tr>


		<tr valign="top">
			<td width="120px"><b>Nome:</b></td>
			<td width="*"><%=auxnome%></td>
		</tr>
		<tr valign="top">
			<td><b>Telefone:</b></td>
			<td><%=auxtelefone%></td>
		</tr>
		<tr valign="top">
			<td><b>Email:</b></td>
			<td><%=auxemail%></td>
		</tr>
		<tr valign="top">
			<td><b>Comunicação:</b></td>
			<td><%=retornaopcao(auxR1) & "<br>" & retornacomentario(auxC1)%></td>
		</tr>
		<tr valign="top">
			<td><b>Cortesia:</b></td>
			<td><%=retornaopcao(auxR2) & "<br>" & retornacomentario(auxC2)%></td>
		</tr>
		<tr valign="top">
			<td><b>Presteza:</b></td>
			<td><%=retornaopcao(auxR3) & "<br>" & retornacomentario(auxC3)%></td>
		</tr>
		<tr valign="top">
			<td><b>Flexibilidade:</b></td>
			<td><%=retornaopcao(auxR4) & "<br>" & retornacomentario(auxC4)%></td>
		</tr>
		<tr valign="top">
			<td><b>Rapidez:</b></td>
			<td><%=retornaopcao(auxR5) & "<br>" & retornacomentario(auxC5) %></td>
		</tr>
		<tr valign="top">
			<td><b>Iniciativa:</b></td>
			<td><%=retornaopcao(auxR6) & "<br>" & retornacomentario(auxC6) %></td>
		</tr>
		<tr valign="top">
			<td><b>Confiabilidade:</b></td>
			<td><%=retornaopcao(auxR7) & "<br>" & retornacomentario(auxC7) %></td>
		</tr>
		<tr valign="top">
			<td><b>Infraestrutura:</b></td>
			<td><%=retornaopcao(auxR8) & "<br>" & retornacomentario(auxC8) %></td>
		</tr>
		<tr valign="top">
			<td><b>Ambiente:</b></td>
			<td><%=retornaopcao(auxR9) & "<br>" & retornacomentario(auxC9) %></td>
		</tr>
		<tr valign="top">
			<td><b>Acesso:</b></td>
			<td><%=retornaopcao(auxR10) & "<br>" & retornacomentario(auxC10) %></td>
		</tr>
		<tr valign="top">
			<td><b>Geral:</b></td>
			<td><%=retornaopcao(auxR11) & "<br>" & retornacomentario(auxC11) %></td>
		</tr>
		<tr valign="top">
			<td><b>Sugestões adicionais <br>nos itens Citados:</b></td>
			<td><%=retornacomentario(auxC_3) %></td>
		</tr>
		<tr valign="top">
			<td><b>Outras sugestões:</b></td>
			<td><%=retornacomentario(auxC_4) %></td>
		</tr>
		</table>
		<!--
		<span style="font-size:10pt">
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Nome:</b>&nbsp;<%=auxnome%><b>, Telefone:</b><%=auxtelefone%> <b>, Email </b><%=auxemail%><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Comunicação: </b><%=retornaopcao(auxR1) &" - " & retornacomentario(auxC1)  %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Cortesia: </b><%=retornaopcao(auxR2) &" - " & retornacomentario(auxC2) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Presteza: </b><%=retornaopcao(auxR3) &" - " & retornacomentario(auxC3) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Flexibilidade: </b><%=retornaopcao(auxR4) &" - " & retornacomentario(auxC4) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Rapidez: </b><%=retornaopcao(auxR5) &" - " & retornacomentario(auxC5) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Iniciativa: </b><%=retornaopcao(auxR6) &" - " & retornacomentario(auxC6) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Confiabilidade: </b><%=retornaopcao(auxR7) &" - " & retornacomentario(auxC7) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Infraestrutura: </b><%=retornaopcao(auxR8) &" - " & retornacomentario(auxC8) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Ambiente: </b><%=retornaopcao(auxR9) &" - " & retornacomentario(auxC9) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Acesso: </b><%=retornaopcao(auxR10) &" - " & retornacomentario(auxC10) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Geral: </b><%=retornaopcao(auxR11) &" - " & retornacomentario(auxC11) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Sugestões adicionais nos itens Citados: </b><%=retornacomentario(auxC_3) %><br>
		<b>&nbsp;&nbsp;&nbsp;&nbsp;Outras sugestões: </b><%=retornacomentario(auxC_4) %><br>
		</span>
		-->
<%
	objSiteRS.MoveNext
	Loop
%>
	</td>
</tr>
</table>
<form name="formulario" action="Cons_Ind_pesqsCR.asp" method="post">
<input type="hidden" name="regprimeiro" value="<%=prireg%>">
<input type="hidden" name="regultimo" value="<%=ultreg%>">
<input type="hidden" name="regatual"  value="<%=atureg%>">
<input type="hidden" name="operacao">
</form>
<br>
<%
call Env.Recordset(false, objSiteRS, null)

Call Tela.MostraRodape()
%>