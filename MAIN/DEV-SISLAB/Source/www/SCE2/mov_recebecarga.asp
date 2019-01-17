<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<div class="margem-10">
    <form name="formulario" method="post">
        <input type="hidden" name="qual_agendamento" value="">

        <table class="largura-total">
<%  if request("msg") = "1" then %>
            <tr><th>Carga recebida com sucesso.</th></tr>
            <tr><td>&nbsp;</td></tr>
<%  end if %>
            <tr>
	            <td class="text-danger">
		            <b>ATEN&Ccedil;&Atilde;O !<br><br>
		            Ao receber uma passagem de carga voc&ecirc; estar&aacute; realizando uma movimenta&ccedil;&atilde;o
		            do(s) equipamento(s) e seus acess&oacute;rios.<br><br>
		            Verifique se o equipamento est&aacute; completo.</b>
	            </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td><strong>Meus agendamentos: (<small><%=Env.Usuario%></small>)</strong></td></tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
	            <td>
		            <%=Combo.MeusAgendamentos(True, "txtAS", "ag_numero_destino", "", "N")%>
		            <span id="responsavel_destino" style="font-weight: bold; font-style: italic;">&nbsp;</span>
		            <script type="text/javascript">
			            var f = document.formulario;
			            f.ag_numero_destino.onchange = BuscaEq;
			            f.txtAS.onblur = BuscaEq;
			            function BuscaEq() {
                            atualizarEQ(f.eq_destino, "DESTINO", f.ag_numero_destino.value);
			            }
		            </script>
	            </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
	            <td>
		            <table class="largura-total">
			            <tr></tr>
		            </table>
		            Equipamentos cedidos ao usu&aacute;rio<br>
		            <select multiple name="eq_destino" style="width: 640px;"  size="6"></select>
	            </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
	            <td><button  onclick="javascript:validaRecepcao();">Receber carga dos itens selecionados &gt;&gt;</button></td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript" src="../includes/anexo.js" ></script>
<script type="text/javascript" src="../ajax/max_ajax_ref.js" ></script>
<script type="text/javascript" src="../ajax/montaCombo.js" ></script>

<script type="text/javascript">
    var d = document.forms[0];

	/*** FUNÇÕES DO AJAX ***/
    function atualizarEQ(objCombo, qual_agendamento, agendamento)
    {
		var url = "../ajax/sce_passacarga_buscaeq.asp";
		url += "?agendamento=" + agendamento + "&qual_agendamento=" + qual_agendamento;

		var maxAjaxObj = new max.Ajax(url,{update:"",onComplete:
			function(texto,xml){
				montaComboSemVazio(objCombo, texto);
			}
		});
		maxAjaxObj.get();
	}

    function validaRecepcao() {
	    var i;
	    if(d.ag_numero_destino.value == "") {
		    alert("Nenhum agendamento selecionado");
		    d.ag_numero_destino.focus();
	    }
	    else if(d.eq_destino.length==0) {
		    alert("Não existe nenhum equipamento para ser recebido");
		    d.ag_numero_destino.focus();
	    }
	    else {
		    for(i=0; i<d.eq_destino.length; i++)
			    d.eq_destino.options[i].selected = true;

		    d.target = "";
		    d.method = "post";
		    d.action = "mov_recebecarga2.asp";
		    d.submit();
	    }
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