<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
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
Tela.SetNomeTela = "Consulta > Item" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
	<!--#include file="includes/montacnpj.inc"-->
	<!--#include file="includes/estado.asp"-->
</script>
<div class="margem-10">
    <form name="formulario" method="post" action="cad_acess_mod.asp" onSubmit="vdform('formulario','notafiscal','Nota Fiscal','Number', 'documento','Documento','Number'); return document.ValorPassou;">
        <input type="hidden" name="busca" value="1">
        <table class="largura-total">
	    <tr>
		    <td>
<%		if request("msg") <> "" then
			if request("msg") = 1 then response.write " Ítem incluído com sucesso!"
			if request("msg") = 2 then response.write " Ítem alterado com sucesso!"
			if request("msg") = 3 then response.write " Ítem excluído com sucesso!"
			if request("msg") = 4 then response.write " É necessário selecionar algum campo de busca!"
			if request("msg") = 5 then response.write " Já existe equipamento cadastrado com este código de barras!"
			response.write "<BR><BR>"
		end if%>
		    </td>
	    </tr>
	    <tr><th>Selecione o Item:</th></tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
			    Código Barras:&nbsp;<input type="text"  name="codbarras" size="25">
			    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    Localização:&nbsp;<input type="text"  name="localizacao" size="25">
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
    		    Plataforma: <%RW Combo.ServicosPlataformas("plataforma", "N", "P")%>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
		    Fabricantes:&nbsp;
		    <%RW Combo.PadraoSql("fabricante", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
			    <table>
			    <tr>
				    <td>Modelo:&nbsp;<input type="text" name="modelo" ></td>
				    <td style="width: 40px;">&nbsp;</td>
				    <td>Descrição:&nbsp;<input type="text" name="desc_modelo"  size="30"></td>
			    </tr>
			    </table>
		    </td>
	    </tr>
	    <tr ><td>&nbsp;</td></tr>
	    <tr>
		    <td>Família Tipo:&nbsp;<%RW Combo.PadraoSql("idtipo", "select TIPO_ID as VALOR, tipo_descricao as DESCRICAO from sce_tipos order by tipo_descricao", "", "N")%>
	    </td>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
			    Fornecedor:&nbsp;
			    <%RW Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", false)%>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
			    <table class="largura-total">
			    <tr>
				    <td>Nota Fiscal:&nbsp;<input type="text"  name="notafiscal" size="10"></td>
				    <td width="10px">&nbsp;</td>
				    <td>Documento:&nbsp;<input type="text"  name="documento" size="7" maxlength="10"></td>
				    <td width="10px">&nbsp;</td>
				    <td>Registro/Certificado/CDE/RMA:&nbsp;<input type="text"  name="cde_equip" size="7"></td>
				    <td width="10px">&nbsp;</td>
				    <td>Número de Série:&nbsp;<input type="text"  name="numeroserie" maxlength="100"></td>
			    </tr>
			    </table>
		    </td>
	    </tr>
	    <tr><td>&nbsp;</td></tr>
	    <tr>
		    <td>
			    <table class="largura-total">
			    <tr>
				    <td><%RW Combo.SimNaoInstrumental("instrumental", true)%></td>
				    <td width="40px">&nbsp;</td>
				    <td><%RW Combo.EquipamentoConforme("conforme", true)%></td>
				    <td width="40px">&nbsp;</td>
				    <td><%RW Combo.SituacaoEquipamento("status", true, true, true, "")%></td>
				    <td width="40px">&nbsp;</td>
				    <td><%RW Combo.PropriedadeEquipamento("propriedade", true)%></td>
			    </tr>
			    </table>
		    </td>
	    </tr>
        </table>
        <br />
        <p><input type="submit" name="buscar" value="Pesquisar"></p>
    </form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
