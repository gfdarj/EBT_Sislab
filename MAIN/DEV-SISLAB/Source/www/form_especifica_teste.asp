<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/ControlesHTML.asp" -->
<%
Dim objSiteRS, cont, sSQL, tot, rs_servico
Dim titulo, i, rs_teste
Dim num_erro, desc_erro, desc_equip, cod_teste
Dim disponivel, tempo, area_tec, tipo, area, pto_cc, pto_ca, pto_telefonicos, descricao, observacao, cabos_conectores, aterramento, rs_procedimentos
Dim auxTipoTeste
Dim int_Repeticao

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Testes", "location.href='form_atualiza_teste_sel.asp'", "")
cod_teste = request("cod_teste")

if cod_teste <> "" then
	call Env.RecordSet(true, rs_teste, "Select t.*, tt.TIT_DESCRICAO from testes t inner join tipo_teste tt on t.TIT_ID = tt.TIT_ID where t.t_id = " & cod_teste)
	if not rs_teste.EOF then
		titulo = rs_teste("T_TITULO")
		disponivel = rs_teste("T_DISPONIVEL")
		tipo = rs_teste("TIT_DESCRICAO")
		descricao = rs_teste("T_DESCRICAO")
		observacao = rs_teste("T_OBSERVACAO")
		auxTipoTeste = rs_teste("TIT_ID")
		int_Repeticao = rs_teste("T_PERIODOREPETICAO")
	end if
	call Env.RecordSet(false, rs_teste, null)
else
	titulo = null
	disponivel = null
	tipo = null
	descricao = null
	observacao = null
	auxTipoTeste = ""
	int_Repeticao = ""
end if
%>
<script type="text/javascript">
    function validaCampos(frm)
    {	//Valida os campos quando o formulário é submetido
	    if (frm.txtTitulo.value == "") 
	    {
		    alert("Título do teste deve ser preenchido.");
		    frm.txtTitulo.focus();
		    return false;
	    }
	    else if (frm.rdoTipo.value == '')
	    {
		    alert("Selecione o tipo do teste.");
		    frm.rdoTipo.focus();
		    return false;
	    }
	    else if (isNaN(frm.periodoRepeticao.value))
	    {
		    alert("Entre com um valor entre 0 (Zero) e 99.");
		    frm.periodoRepeticao.focus();
		    return false;
	    }
	    else if (frm.periodoRepeticao.value < 0)
	    {
		    alert("Entre com um valor entre 0 (Zero) e 99.");
		    frm.periodoRepeticao.focus();
		    return false;
	    }
	    return true;
    }
</script>
<div class="margem-10">
    <form method="post" action="form_especifica_testeA.asp" name="frmEspecificaTeste" onSubmit="return validaCampos(this);">
        <input type="hidden" value="<%= cod_teste%>" name="cod_teste">

        <table border="0" style="width: 100%;">
        <tr>
	        <td>
		       Título:<BR>
		       <input type="text" value="<%=titulo%>" name="txtTitulo" size="100" maxlength="200">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               Disponível:&nbsp;<input type="checkbox" name="chkDisponivel" <%if disponivel then Response.Write "checked"%>>
	        </td>
        </tr>
        <tr><td height="5px"></td></tr>
        <tr>
	        <td>
		        Tipo do teste<BR>
		        <%call comboTipoTeste("rdoTipo", Env.oConn, auxTipoTeste, "N")%>
	        </td>
        </tr>
        <tr><td height="5px"></td></tr>
        <tr>
	        <td>
		        Descrição<br>
		        <textarea cols=100 name="txaDescricao" rows="6"><%= descricao%></textarea>
	        </td>
        </tr>
        <tr><td height="5px"></td></tr>
        <tr>
	        <td>
		        Período de Repetição do Teste<br>
		        <input size="3" maxlength="2" type="text" name="periodoRepeticao" value="<%=int_Repeticao%>"> mês(es)&nbsp;&nbsp;&nbsp; <small><i>(Zero ou Vazio indicam a <u>Não</u> repetição)</i></small>
	        </td>
        </tr>
        <tr><td height="5px"></td></tr>
        <tr>
	        <td>
		        Observação:<br>
		        <textarea cols=100 name="txaObservacao" rows="6"><%= observacao%></textarea>
	        </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
	        <td>
	            <input type="submit" class="btn btn-primary" value="     Ok     " name="btnOk">
    	        <input type="button" class="btn btn-primary" value="Cancelar" onclick="javascript:location.href='form_atualiza_teste_sel.asp';">
	        </td>
        </tr>
        </table>
    </form>
</div>
<%
Call Tela.MostraRodape()
%>
