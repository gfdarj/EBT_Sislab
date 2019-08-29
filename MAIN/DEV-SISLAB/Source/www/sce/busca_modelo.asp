<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Consulta > Modelo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Call Tela.ImprimeMenuSce()

    Dim ssql, rec, where
%>
<div class="margem-10">
<table width="100%">
	<tr>
		<td>
<%
ssql =	"select distinct m.mod_id, m.mod_descricao, f.fab_id, m.mod_codnome, f.fab_nome, m.mod_partnumber " & _
			"from sce_fabricantes f inner join sce_modelos m on f.fab_id = m.fab_id " & _
			"where "
where = ""
if request("partnumber") <> "" then
	where = "m.mod_partnumber Like '%"& request("partnumber") &"%' "
end if

if request("modelo") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.mod_codnome Like '%"& request("modelo") &"%' "
end if

if request("fab_id") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.fab_id = " & request("fab_id") &" "
end if

If request("descricao") <> "" then
	if where <> "" then where = where & " and "
	where = where & "m.mod_descricao Like '%" & request("descricao") &"%' "
End If

ssql = ssql & where & "order by mod_codnome, fab_nome"
'response.write ssql
'response.end
Set rec = Env.oconn.execute(Ssql)

'-- se achou 1 registro pulo direto para a edicao do mesmo
if rec.recordcount = 1 then
	response.redirect "alt_modelos.asp?mod_id=" & rec("mod_id")
else%>
        <table class="largura-total table-condensed table-bordered table-striped table-hover"><%
		if not (rec.eof and rec.bof) then%>
			<tr  bgcolor="#C0E0EF">
				<th>Modelo</th>
				<th>Fabricante</th>
				<th>Descrição</th>
				<th>Part Number</th>
			</tr>
<%			while not rec.eof%>
			<tr>
				<td><a href=alt_modelos.asp?mod_id=<%=rec("mod_id")%>><%=rec("mod_codnome")%></a></td>
				<td><%if isnull(rec("fab_nome")) then response.write "&nbsp;" else response.write rec("fab_nome")%></td>
				<td><%if isnull(rec("mod_descricao")) then response.write "&nbsp;" else response.write rec("mod_descricao") end if%></td>
				<td><%if isnull(rec("mod_partnumber")) then response.write "&nbsp;" else response.write rec("mod_partnumber") end if%></td>
			</tr>
<%				rec.MoveNext
			wend
		end if%>
			</table><%
end if
rec.close
set rec = nothing
%>
		</td>
	</tr>
	<tr ><td>&nbsp;</td></tr>
	<tr><td align="center"><input type="button"  value="Voltar" onclick="javascript:history.go(-1);"></td></tr>
</table>
</div>
<br>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
