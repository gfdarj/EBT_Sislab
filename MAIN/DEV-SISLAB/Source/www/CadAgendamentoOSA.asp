<!--#include file="includes/Sislab_Lib.asp"-->
<!--#inc lude file="includes/conexao.inc" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim RS

'-- redireciona caso expirado
if Env.usuario = "" or IsEmpty(Env.usuario) then response.redirect "msgAcessoNA.ASP"

'Dados Básico - Cliente -----------------------------------------------------------
equipamento = request.form("cmbEquipamento")
teste = request.form("cmbTeste")
obs = trocaPlic2Aspas(request.form("obs"))
cmbSituacao = request.form("cmbSituacao")
data_inicio = request.form("diaINICIO") & "-" & request.form("mesINICIO") & "-" & request.form("anoINICIO")
hora_inicio = request.form("horaINICIO") & ":" & request.form("minutoINICIO")
num_os = request("num_os")
num_ag = request("num_ag")
motivo = trocaPlic2Aspas(request("motivo"))
nova_os =  request("nova_os")
situacaoAnterior = request.form("hdnSituacao")
if situacaoAnterior = cmbSituacao then
	cmbSituacao = "null"
end if

plataforma = request("cmbPlataforma")
servico = request("cmbServico")
eq_id = request("cmbEquipamento")

ssql = _
		"exec sp_CadAgendamentoOS " & nova_os & "," & teste & "," & _
		num_os & "," & num_ag & ",'" & obs & "'," & cmbSituacao & ",'" & _
		motivo & "','" & data_inicio & " " & hora_inicio & "'," & servico & "," & _
		plataforma & "," & eq_id

ssql = PreparaStrSQL(ssql)

'response.write ssql
'response.end

Set RS = Env.oConn.execute(ssql)

%>
<html>
<body>
<form>
<script>
	window.visible = false;
<%
If Not (RS.Eof And RS.Bof) Then
	If (RS("RepeticaoOS") = 1) Then
%>
	alert('Esta OS está marcada para repetição !');
<%
	End If
End If
%>
	self.opener.Recarrega();
	self.opener.focus();
	window.close();
</script>
</form>
</html>
</body>
