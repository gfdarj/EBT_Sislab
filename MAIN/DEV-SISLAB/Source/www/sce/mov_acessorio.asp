<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%

Dim tipousuario : tipousuario = ""
if Env.PerfilSce = PERFIL_ADM then tipousuario = " <span style='color:#800000;'>(Administrador)</span>"

Tela.SCE = True
Tela.SetNomeTela = "Movimentação > Item" & tipousuario : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>

<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
</script>

<script type="text/javascript">
function movimentaItens() {<%
'--
'-- Se for administrador pode fazer movimentos para qualquer tipo de situacao.
'-- Os não ADM´s só poderao fazer movimentacoes para itens com situacao atual selecionada
'-- por esta combo. Alem disso, as datas nesse caso serão as datas atuais
'--
if session("status") <> PERFIL_ADM then
%>	var d = document.forms[0];
	var ret = false;
	if (d.status.value == "") {
		alert("Selecione um tipo a ser movimentado.");
		d.status.focus();
	}
	else
		{ ret = true; }<%
else
%>	ret = true;<%
end if
%>	return ret;
}
</script>

<div class="margem-10">
<form name="formulario" method="post" action="mov_acessorio2.asp" onsubmit="javascript:return movimentaItens();">
<input type="hidden" name="busca" value="1">
<table class="largura-total">
	<tr><td><%if request("msg") <> "" then response.write " <strong><div align='center'>Movimentação efetuada com sucesso.<br> Foi criado um histórico de movimentação com estes dados.</div></strong><br><br>"%></td></tr>
	<tr>
	    <th>Selecione o filtro</th>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td><%if Env.PerfilSce <> PERFIL_ADM then response.write "<b>"%>Movimentar os itens na <%=Combo.SituacaoEquipamento("status", true, false, true, "")%><%if Env.PerfilSce <> PERFIL_ADM then response.write "</b>"%></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td> 
      		<table class="largura-total">
	  			<tr>
	    			<td  colspan="2">
						Código Barras:&nbsp;<input type="text"  name="codbarras" style="width:160px" maxlength="50">
						<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="btn btn-primary" value=" Procurar " onclick="buscaCB()" >-->
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Plataforma: <%=Combo.ServicosPlataformas("plataforma", "N", "P")%>
					</td>
				</tr>

				<tr><td  colspan="2"><br></td></tr>

				<tr>
	    			<td>
						Fabricante:&nbsp;
						<%=Combo.PadraoSql("fabricante", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
					</td>
					<td >
					Modelo:&nbsp;<input type="text" name="modelo"  style="width:200px">
					</td>
				</tr>
				<tr>
					<td  colspan="2"><br></td>
				</tr>
				
				<tr>
					<td colspan=2>	
					Fornecedor 		
                    <%=Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", false)%>
					</td>
				</tr>

				<tr><td >&nbsp;</td></tr>

				<tr>
					<td  width="50%" colspan="2">
					Nota Fiscal:&nbsp;<input type="text"  name="notafiscal" size="20">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Documento:&nbsp;<input type="text"  name="documento" size="7" maxlength="10">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					CDE:&nbsp;<input type="text"  name="cde" size="10">
					</td>
				</tr>

				<tr ><td>&nbsp;</td></tr>

				<tr>
	  				<td colspan="3">
						N&deg; AS:&nbsp;<input type="text"  name="as" size="10">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Número de Série:&nbsp;<input type="text"  name="numeroserie" maxlength="50">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Localiza&ccedil;&atilde;o:&nbsp;<input type="text"  name="localizacao" size="25" value="">
					</td>
				</tr>
				<tr ><td>&nbsp;</td></tr>
				<tr>
					<td colspan="3"><input type="submit" class="btn btn-primary" name="buscar" value="Pesquisar"></td>
				</tr>
			</table>
      	</td>
    </tr>
  </table>
</form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
