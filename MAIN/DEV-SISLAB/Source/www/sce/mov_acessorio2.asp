<!------- LIB ------->
<!--#include file="../Classes/Classe_SCE.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Dim tipousuario : tipousuario = ""
if Env.PerfilSce = PERFIL_ADM then tipousuario = " <span style='color:#800000;'>(Administrador)</span>"

Tela.SCE = True
Tela.SetNomeTela = "Movimentação > Item" & tipousuario : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Sce
    Set Sce = New TSce

    'Call Tela.ImprimeMenuSce()

    Server.ScriptTimeout = 100000

    if request("busca") <> "" then

	    ssql =	"SELECT distinct a.eq_id, e.fab_id, a.status,a.eq_codigobarras, " & _
			    "a.eq_numeroserie, a.mod_id, e.mod_codnome, e.mod_descricao, " & _
				"ma.ASA AS AG_NUMERO, ma.MOV_SOLICITANTE, amb.AMB_NOME, " & _
				"   CASE WHEN A.STATUS = 2 THEN 'Em Uso' " & _
				"   WHEN A.STATUS = 1 THEN 'Estoque' " & _
				"   WHEN A.STATUS = 3 THEN 'Expedido' " & _
				"   WHEN A.STATUS = 0 THEN 'Cadastrado' END AS STATUS_M " & _
				"FROM " & _
                "   sce_modelos e INNER JOIN SCE_Equipamentos a ON a.mod_id = e.mod_id " & _
				"   LEFT JOIN vw_SCE_Movimentacao_Atual AS ma ON ma.EQ_ID = a.EQ_ID " & VbCrLf & _
			    "   LEFT JOIN SCE_Movimentacao b ON a.EQ_ID = b.EQ_ID " & VbCrLf & _
                "   LEFT JOIN Ambientes amb ON a.AMB_ID = amb.AMB_ID " & VbCrLf

	    if request("notafiscal") <> "" or request("enf_id") <> "" then
		    ssql = ssql &" LEFT JOIN SCE_Nota_Fiscal nf ON b.nf_id = nf.nf_id "
		    if request("enf_id") <> "" then
			    ssql = ssql &" and nf.enf_id = "& request("enf_id")
		    end if
	    end if

	    ssql = ssql & "where 1=1 "

	    if Env.PerfilSce <> PERFIL_ADM or request("status") <> "" then
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
		    ssql = ssql &"and UPPER(amb.AMB_NOME) like '"& UCase(request("localizacao")) &"%' "
	    end if

	    'response.write "AQUI<BR>" & ssql & "<BR>"
	    'response.end

	    ssql = ssql & " ORDER BY a.eq_codigobarras"
	    set rec = Env.oconn.execute(ssql)
	    if rec.eof then a = "a"
    end if
%>

<div class="margem-10">
<form name="formulario" action="sel_mov_acessorio.asp" method="post">
<input type="hidden" name="status" value="<%=request("status")%>">  <!-- pego o estado dos itens consultados para movimentar -->

<table class="largura-total">
<tr>
	<td><%
    'if request("eq_id") = "" or a <> "" or isnull(a) then 
    if a <> "" or isnull(a) then 
	    response.write "<p align='center'>Nenhum item encontrado com estes parâmetros.</p><br>"
	    response.end
    else
%>	</td>
</tr>
<tr>
    <th class="texto-centralizado">Escolha um Item</th>
</tr>
<tr>
    <td >
		<br>
		<table class="largura-total table-condensed table-bordered table-striped table-hover">
  			<tr>
			  <th>&nbsp;</th>
		      <th>Item</th>
			  <th>Descrição</th>
			  <th class="texto-centralizado">Modelo</th>
			  <th class="texto-centralizado">Nº de Série</th>
			  <th class="texto-centralizado">Fabricante</th>
			  <th class="texto-centralizado">Status Item</th>
			 </tr>
<%  'if not rec.eof then
	    while not rec.eof
		    ssql = "select fab_nome from sce_fabricantes where fab_id = "& rec("fab_id")
		    set rec2 = Env.oconn.execute(ssql)%>
			 <tr>
				<td class="texto-centralizado"> <input type=checkbox name=eq_id value="<%=rec("eq_id")%>"></td>
				<td><%=ConverteNuloHTML(rec("eq_codigobarras"))%></td>
				<td><%=ConverteNuloHTML(rec("mod_descricao"))%></td>
				<td class="texto-centralizado"><%=ConverteNuloHTML(rec("mod_codnome"))%></td>
				<td class="texto-centralizado"><%=ConverteNuloHTML(rec("eq_numeroserie"))%></td>
				<td class="texto-centralizado"><%=ConverteNuloHTML(rec2("fab_nome"))%></td>
				<td class="texto-centralizado"><%=Sce.ImprimeStatusItem(rec)%></td>
			</tr>
<%	    	rec.MoveNext
	    WEnd
    'end if%>
		 </table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
   	<td class="texto-centralizado">
	    <input type=submit value=" Escolher " >&nbsp;&nbsp;<br><br>
	</td>
</tr>
<tr>
   	<td class="texto-centralizado">
		<a href="cad_acess_item.asp">Cadastrar Novo Ítem</a>
	</td>
</tr>
</table>
</form>
<br />

</div>
<%  End If

    Set Sce = Nothing
    Set Env = Nothing
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>

