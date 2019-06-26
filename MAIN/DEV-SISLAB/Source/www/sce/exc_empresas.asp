<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->

<!------- SISLAB ---->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->

<%
ssql = "select * from sce_empresa_nota_fiscal where enf_id = " & request("enf_id")
set rec = Env.oConn.execute(ssql)

ssql = "delete from sce_empresa_nota_fiscal where enf_id = " & request("enf_id")
Env.oConn.execute(ssql)

'acao = "O usuário " & reco("user_nome") & " excluiu a empresa " & rec("enf_nome") & "."
acao = "O usuário " & Env.Ebt.NomeReduzido() & " excluiu a empresa " & rec("enf_nome") & "."
data = year(now) & "/" & right(month(now)+100,2) & "/" & right(day(now)+100,2) & " " & right(hour(now)+100,2) & ":" & right(minute(now)+100,2) & ":" & right(second(now)+100,2)

ssql = "insert into sce_historico (id_usuario,acao,data) values ('" & Env.Usuario & "', '" & acao & "', '" & data & "')"
Env.oConn.execute(ssql)

Response.Redirect "sel_cad_empresa.asp?msg=2"
%>