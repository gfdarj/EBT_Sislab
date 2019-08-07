<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim  objRS, s
Dim auxcadastradopor, auxtipocomando,auxselecao
dim auxidagenda, auxdescricao, auxtitulo, auxdatainicio, auxdatafim 
dim auxhorario, auxcontato,auxaltera, auxlocalizacao, auxas, auxresponsavel

auxdescricao=request.form("descricao")
auxtitulo=request.form("titulo")
auxidagenda=request.form("idagenda")
auxhorario=request.form("horario")
auxlocalizacao=request.form("localizacao")
auxcontato=request.form("contato")
auxselecao=request.form("selecao")
auxas=request.form("as")
if auxas = "0" or auxas = "" then auxas="null"
auxresponsavel=request.form("responsavel")

auxdatainicio = request("diaInicio") & "/" & request("mesInicio") & "/" & request("anoInicio")
auxdatafim = request("diaFim") & "/" & request("mesFim") & "/" & request("anoFim")
auxtipocomando=request.form("tipocomando")

'auxcadastradopor=request.form("cadastradopor")

If auxtipocomando="Alterar" Then
	strDesc = "A Alteração"
	s = "Update reserva_ambientes "
	s = s & "Set RAM_descricao='" & auxdescricao & "', "
	s = s & "RAM_titulo='" & auxtitulo & "', "
	s = s & "RAM_DataInicio=convert(smalldatetime,'" & auxdatainicio & "', 103), "
	s = s & "RAM_Datafim=convert(smalldatetime,'" & auxdatafim & "', 103), "
	s = s & "RAM_horario='" & auxhorario & "', "
	s = s & "AMB_ID='" & auxlocalizacao & "', "
	s = s & "RAM_contato='" & auxcontato & "', "
	s = s & "RAM_responsavel='" & auxresponsavel & "', "
	s = s & "RAM_as=" & auxas & " "
	s = s & "Where RAM_id=" & auxselecao & "; "
elseif auxtipocomando="apagar" then
	strDesc = "O Cancelamento"
	s = "delete from reserva_ambientes "
	s = s & "Where RAM_id=" & auxselecao & "; "
else
	strDesc = "A Inserção"
	s = "Insert into reserva_ambientes "
	s = s & "(RAM_descricao, RAM_titulo, RAM_responsavel,"
	s = s & "RAM_horario,AMB_ID,RAM_contato, RAM_as, "
	s = s & "RAM_datainicio,RAM_datafim) "
	s = s & "values ('" & auxdescricao & "','" & auxtitulo & "','"&auxresponsavel&"',"
	s = s & "'" & auxhorario & "','" & auxlocalizacao & "','" & auxcontato & "'," & auxas &","
	s = s & " convert(smalldatetime,'" & auxdatainicio & "', 103),convert(smalldatetime,'" & auxdatafim & "', 103));"
End if

'response.write s
'response.end

call Env.RecordSet( true, objRS, s)

Response.AddHeader "refresh", "3; url=sel_cad_agenda.asp"

Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Reserva de Ambientes", "location.href='../sislab.asp'", "../")
%>
<div class="margem-10">
<% 
If Err Then %>
	    <b>&nbsp;&nbsp;Erro Nº:</b> <%=Err.Number%>- <%=s%><br>
	    <b>&nbsp;&nbsp;Descrição:</b> <%=Err.Description%><br>
	    <b>Houve um erro na inclusão das informações digitadas.<br>
	        Por favor, tente mais tarde.
	    </b>
<% else %>
   <%=strDesc%> da reserva : <b><%=auxtitulo%></b> foi realizada com Sucesso! <br><br>
   <small>	Por favor, aguarde...</small><br><br><br>
<% end if %>
</div>

<%
Call Tela.MostraRodape()
%>
