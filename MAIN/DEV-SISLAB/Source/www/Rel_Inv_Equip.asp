<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/controleshtml_SCE.asp" -->
<%
Dim EH_CRT, EH_RAT
'Dim chr_BgColor, chr_EstiloTD

EH_CRT = Env.UsuarioCRT()
EH_RAT = Env.EhRat()
'chr_BgColor = "#E8E8E8"
'chr_EstiloTD = "style='border-bottom: solid " & chr_BgColor & " thin;'"

If Not EH_RAT Then
	RR "index.asp"
	RE
End If

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório para Inventário de Equipamentos", "", "")
%>
<script type="text/javascript">
    function ValidaCampos() {
	    var frm = document.frmFiltro;

	    if(isNaN(frm.notafiscal.value)) {
		    alert('Nota fiscal não é válida.');
		    frm.notafiscal.focus(); return false;
	    }
	    else if(isNaN(frm.qtdmov.value)) {
		    alert('Quantidade de movimento não é válido.');
		    frm.qtdmov.focus(); return false;
	    }
	    else {
		    showAguarde(); return true;
	    }
    }
</script>

<div class="margem-10">
    <form name="frmFiltro" method="post" action="rel_inv_equip_A.asp" onSubmit="javascript:return ValidaCampos();">

        <table class="largura-total">
        <tr><th>Selecione uma das opções de filtro para consulta</th></tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
	        <td>
                <table class="table-condensed ">
		        <tr>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
		        </tr>

		        <tr>
			        <td colspan="2">Código Barras: <input type="text" name="codigobarras" size="20" maxlength="16" ></td>
			        <td colspan="2">Localização: <input type="text" name="localizacao" size="20" ></td>
			        <td colspan="6">Modelo: <input type="text" name="modelo" size="20" ></td>
		        </tr>

		        <tr>
			        <td colspan="2">Nota Fiscal: <input type="text" name="notafiscal" size="10" ></td>
			        <td colspan="2">
				        Propriedade:
				        <select name="propriedade" >
					        <option value="">Todos</option>
					        <option value="M">Comodato (Embratel)</option>
					        <option value="C">CRT</option>
					        <option value="O">Outros (Embratel)</option>
					        <option value="T">Terceiros</option>
				        </select>
			        </td>
			        <td colspan="6">Qtde de Movimentos: <input type="text" name="qtdmov" size="6" maxlength="5" ></td>
		        </tr>

		        <tr>
			        <td colspan="8">Fornecedor: <%call comboFornecedor("idfornecedor", Env.oConn, "", "N", "FORNECEDOR", False)%></td>
			        <td colspan="2">Status:
				        <select name="status" >
					        <option value="">Todos</option>
					        <option value="0">Cadastrado</option>
					        <option value="2">Em Uso</option>
					        <option value="1">Estoque</option>
					        <option value="3">Expedido</option>
				        </select>
			        </td>
		        </tr>

		        <tr>
			        <td colspan="4">
                        Ordenação:
				        <select name="ordenacao" >
					        <option value="E.EQ_CODIGOBARRAS">Código de Barras</option>
					        <option value="QTD_MOV.TOTAL_MOVIMENTOS">Quantidade de Movimentos</option>
					        <option value="E.STATUS">Status do Equipamento</option>
				        </select>&nbsp;
				        <select name="tipoordenacao" >
					        <option value="ASC">Ascendente</option>
					        <option value="DESC">Descendente</option>
				        </select>
			        </td>
			        <td colspan="6" class="texto-direito">
				        Registros por Página:
				        <select name="registroporpagina" >
					        <option value="10">10</option>
					        <option value="30">30</option>
					        <option value="50">50</option>
					        <option value="100">100</option>
				        </select>
			        </td>
		        </tr>
		        </table>
	        </td>
        </tr>
		<tr><td>&nbsp;</td></tr>
        </table>

        <p><input type="submit" name="btnConsultar" Value="Consultar" ></p>

    </form>
</div>
<%
Call Tela.MostraRodape()
%>
