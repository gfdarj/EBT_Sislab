<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<!--#include file="includes/bib_str.asp"-->
<%
if request("busca") <> "" then

	ssql =	"SELECT distinct a.eq_id, e.fab_id, a.status,a.eq_codigobarras, " & _
			"a.eq_numeroserie, a.mod_id, e.mod_codnome, e.mod_descricao " & _
			"FROM sce_modelos e, SCE_Equipamentos a LEFT JOIN SCE_Movimentacao b " & _
			"ON a.EQ_ID = b.EQ_ID "

	if request("notafiscal") <> "" or request("enf_id") <> "" then
		ssql = ssql &" LEFT JOIN SCE_Nota_Fiscal nf ON b.nf_id = nf.nf_id "
		if request("enf_id") <> "" then
			ssql = ssql &" and nf.enf_id = "& request("enf_id")
		end if
	end if

	ssql = ssql & "where (a.mod_id = e.mod_id ) "

	if session("status") <> PERFIL_ADM or request("status") <> "" then
		ssql = ssql & "AND a.STATUS = " & request("status") & " "
	end if

	If request("plataforma") <> "" Then
		ssql = ssql & _
			" AND EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
			"WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = a.EQ_ID) "
	End If

	if request("codbarras") <> "" then
		ssql = ssql &"and a.eq_codigobarras like '%"& trim(request("codbarras")) &"%' "
	end if
	if request("modelo") <> "" then
		ssql = ssql &"and UPPER(e.mod_codnome) like '%"& ucase(trim(request("modelo"))) &"%' "
	end if
	if request("numeroserie") <> "" then
		ssql = ssql &"and a.eq_numeroserie like '%"& trim(request("numeroserie")) &"%' "
	end if
	if request("as") <> "" then
		ssql = ssql &" and b.asa = '"& request("as") &"' "
	end if	
	if request("fabricante") <> "" then
		ssql = ssql &"and e.fab_id = "& request("fabricante") &" "
	end if
	if request("documento") <> "" and isnumeric(request("documento")) then
		ssql = ssql & " and b.doc_id = " & request("documento") & " "
	end if

	if request("notafiscal") <> "" then
		ssql = ssql & " and nf.NF_NUMERONOTA = '" & request("notafiscal") & "' "
	end if

	if request("enf_id") <> "" then
		ssql = ssql & " and nf.ENF_ID = '" & request("enf_id") & "' "
	end if

	if request("cde") <> "" then
		ssql = ssql & " and b.CDE = '" & request("CDE") & "' "
	end if
	if request("localizacao") <> "" then
		ssql = ssql &"and UPPER(a.EQ_LOCALIZACAO) like '"& UCase(request("localizacao")) &"%' "
	end if

	'response.write "AQUI<BR>" & ssql & "<BR>"
	'response.end

	ssql = ssql & " ORDER BY a.eq_codigobarras"
	set rec = conn.execute(ssql)
	if rec.eof then a = "a"
end if

Dim tipousuario : tipousuario = ""
if session("status") = PERFIL_ADM then tipousuario = " <span style='color:#800000;'>(Administrador)</span>"

call ImprimeCabecalho ("", MENU_ON, true, "Movimentação de Item" & tipousuario, "", "history.go(-1);")
%>
<form name="formulario" action="sel_mov_acessorio.asp" method="post">
<input type="Hidden" name="status" value="<%=request("status")%>">  <!-- pego o estado dos itens consultados para movimentar -->
<table width="100%" cellpadding="2" cellspacing="0" class="texto">
<tr>
	<td class="titulo"><%
'if request("eq_id") = "" or a <> "" or isnull(a) then 
if a <> "" or isnull(a) then 
	response.write "<p align='center'>Nenhum item encontrado com estes parâmetros.</p><br>"
	response.end
else
%>	</td>
</tr>
<tr valign="top">
    <td class="titulo" align="center">
		Escolha um Item<br><br>
		<table width="100%" cellpadding="2" cellspacing="0" border="1" class="texto">
  			<tr bgcolor="#C0E0EF" class="titulo">
			  <th align="center">&nbsp;</th>
		      <th align="center">Itens</th>
			  <th>Descri&ccedil;&atilde;o</th>
			  <th align="center">Modelo</th>
			  <th align="center">Número <br>de<br> Série</th>
			  <th align="center">Fabricante</th>
			  <th align="center">Status Item</th>
			 </tr>
<%'if not rec.eof then
	while not rec.eof
		ssql = "select fab_nome from sce_fabricantes where fab_id = "& rec("fab_id")
		set rec2 = conn.execute(ssql)%>
			 <tr bgcolor="#C0E0EF">
				<td align="center"> <input type=checkbox name=eq_id value="<%=rec("eq_id")%>"></td>
				<td><%=ConverteNuloHTML(rec("eq_codigobarras"))%></td>
				<td><%=ConverteNuloHTML(rec("mod_descricao"))%></td>
				<td align="center"><%=ConverteNuloHTML(rec("mod_codnome"))%></td>
				<td align="center"><%=ConverteNuloHTML(rec("eq_numeroserie"))%></td>
				<td align="center"><%=ConverteNuloHTML(rec2("fab_nome"))%></td>
				<td align="center"><%=PegaStatusItem(Conn, rec("EQ_ID"), true)%></td>
			</tr>
<%		rec.movenext
	wend
'end if%>
		 </table>
	</td>
</tr>
<tr>
   	<td class="texto" align="center"><br><br>
	&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value=" Escolher " class=form>&nbsp;&nbsp;<br><br>
	</td>
</tr>
<tr>
      	<td class="texto" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<a href="cad_acess_item.asp" class=texto><strong>Cadastrar Novo Ítem</strong></a>
	</td>
</tr>
</table>
</form>
		<%end if%>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
