<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Movimentação > Administração de Dados > De/Para de Modelos" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>
<div class="margem-10">
    <form method="post" action="adm_depara_modelos2.asp" name="formulario" onsubmit="javascript:return executaDePara(this);">
        <table>
<%
If request("msg")<>"" Then %>
            <tr>
	            <td colspan="2">
                    <b>
<%	If request("msg") = "1" Then
		response.write "Modelos atualizados com sucesso !"
	End If
%>		            </b>
	            </td>
            </tr>
            <tr><td>&nbsp;</td></tr><%
End If
%>
            <tr><td colspan="2">Modelo antigo: (De)</td></tr>
            <tr><td><%=Combo.PadraoSql("mod_id_old", "select mod_id as VALOR, mod_codnome + ' - ' + f.fab_nome as DESCRICAO from sce_modelos m inner join sce_fabricantes f on m.fab_id = f.fab_id order by mod_codnome", valor, "N")%></td></tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td class="texto-centralizado"><input type="submit" value="Executar !"></td></tr>
            <tr><td>Modelo novo: (Para)</td></tr>
            <tr><td><%=Combo.PadraoSql("mod_id_new", "select mod_id as VALOR, mod_codnome + ' - ' + f.fab_nome as DESCRICAO from sce_modelos m inner join sce_fabricantes f on m.fab_id = f.fab_id order by mod_codnome", valor, "N")%></td></tr>
        </table>
    </form>
</div>

<script type="text/javascript">
	d = document.forms[0];
	d.mod_id_old.size = 10;
	d.mod_id_new.size = 10;

	function executaDePara(d) {
		var ret = false;
		if( (d.mod_id_old.value == "") || (d.mod_id_new.value == "") )
			alert("Selecione os modelos !");
		else if(d.mod_id_old.value == d.mod_id_new.value )
			alert("Selecione modelos diferentes !");
		else {
			ret = true;
		}
		return ret;
	}
</script>
<%
    Set Combo = Nothing
    Set Env = Nothing
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
