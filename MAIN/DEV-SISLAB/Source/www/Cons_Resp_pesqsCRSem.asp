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
dataIni = Trim(request("di"))
dataFim= Trim(request("df"))

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
<script type="text/javascript">
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

<div class="margem-10">

    <div>
        <h4>Análise Individual dos Formulários de Satisfação</h4>
	    <h5>Tipo de Atividade: <%=partadesc%></h5>
    </div>

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
Call Env.Recordset(true, objSiteRS, sSQL)

objSiteRS.MoveFirst
prireg = objSiteRS("psq_id")
contreg = objSiteRS.RecordCount

Do While Not (objSiteRS.Eof)

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
		<table border="0" class="table-bordered table-condensed table-striped table-hover" style="width: 100%;">

		<tr valign="top">
			<td style="width: 150px;"><b>N. Agendamento:</b></td>
			<td><b><%=auxAg_Numero%></b></td>
		</tr>
		<tr valign="top">
			<td><b>Nome:</b></td>
			<td><%=auxnome%></td>
		</tr>
		<tr valign="top">
			<td><b>Telefone:</b></td>
			<td><%=auxtelefone%></td>
		</tr>
		<tr valign="top">
			<td><b>E-mail:</b></td>
			<td><%=auxemail%></td>
		</tr>
		<tr valign="top">
			<td><b>Comunicação:</b></td>
			<td><%=retornaopcao(auxR1) & "<br><small>" & retornacomentario(auxC1) & "</small>"%></td>
		</tr>
		<tr valign="top">
			<td><b>Cortesia:</b></td>
			<td><%=retornaopcao(auxR2) & "<br><small>" & retornacomentario(auxC2) & "</small>"%></td>
		</tr>
		<tr valign="top">
			<td><b>Presteza:</b></td>
			<td><%=retornaopcao(auxR3) & "<br><small>" & retornacomentario(auxC3) & "</small>"%></td>
		</tr>
		<tr valign="top">
			<td><b>Flexibilidade:</b></td>
			<td><%=retornaopcao(auxR4) & "<br><small>" & retornacomentario(auxC4) & "</small>"%></td>
		</tr>
		<tr valign="top">
			<td><b>Rapidez:</b></td>
			<td><%=retornaopcao(auxR5) & "<br><small>" & retornacomentario(auxC5) & "</small>"%></td>
		</tr>
		<tr valign="top">
			<td><b>Iniciativa:</b></td>
			<td><%=retornaopcao(auxR6) & "<br><small>" & retornacomentario(auxC6) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Confiabilidade:</b></td>
			<td><%=retornaopcao(auxR7) & "<br><small>" & retornacomentario(auxC7) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Infraestrutura:</b></td>
			<td><%=retornaopcao(auxR8) & "<br><small>" & retornacomentario(auxC8) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Ambiente:</b></td>
			<td><%=retornaopcao(auxR9) & "<br><small>" & retornacomentario(auxC9) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Acesso:</b></td>
			<td><%=retornaopcao(auxR10) & "<br><small>" & retornacomentario(auxC10) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Geral:</b></td>
			<td><%=retornaopcao(auxR11) & "<br><small>" & retornacomentario(auxC11) & "</small>" %></td>
		</tr>
		<tr valign="top">
			<td><b>Sugestões adicionais <br>nos itens Citados:</b></td>
			<td><small><%=retornacomentario(auxC_3) %></small></td>
		</tr>
		<tr valign="top">
			<td><b>Outras sugestões:</b></td>
			<td><small><%=retornacomentario(auxC_4) %></small></td>
		</tr>
		</table>
        <br />
<%
	    objSiteRS.MoveNext
	Loop
%>
        <div style="text-align: center;"><input type="button" value=" Fechar " onclick="javascript: window.close();" /></div>

        <form name="formulario" action="Cons_Ind_pesqsCR.asp" method="post">
            <input type="hidden" name="regprimeiro" value="<%=prireg%>">
            <input type="hidden" name="regultimo" value="<%=ultreg%>">
            <input type="hidden" name="regatual"  value="<%=atureg%>">
            <input type="hidden" name="operacao">
        </form>
    <br>
</div>

<%
call Env.Recordset(false, objSiteRS, null)

Call Tela.MostraRodape()
%>