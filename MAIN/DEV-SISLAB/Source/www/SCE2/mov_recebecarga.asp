<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<%
Tela.SetNomeTela = "SCE > Movimentação > Recepção de Carga" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<form name="formulario" method="post">
<input type="Hidden" name="qual_agendamento" value="">
<table width="100%" cellpadding="2" cellspacing="0" class="texto1">
<%  if request("msg") = "1" then %>
<tr><th>Carga recebida com sucesso.</th></tr>
<tr><td>&nbsp;</td></tr>
<%  end if %>
<tr>
	<td style="color: red;">
		<b>ATEN&Ccedil;&Atilde;O !<br><br>
		Ao receber uma passagem de carga voc&ecirc; estar&aacute; realizando uma movimenta&ccedil;&atilde;o
		do(s) equipamento(s) e seus acess&oacute;rios.<br><br>
		Verifique se o equipamento est&aacute; completo.</b>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td class="destaque">Meus agendamentos: (<i><%=Env.Usuario%></i>)</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<%=Combo.MeusAgendamentos(True, "txtAS", "ag_numero_destino", "", "N")%>
		<span id="responsavel_destino" style="font-weight: bold; font-style: italic;">&nbsp;</span>
		<script language="JavaScript">
			var f = document.formulario;
			f.ag_numero_destino.onchange = BuscaEq;
			f.txtAS.onblur = BuscaEq;
			function BuscaEq() {
				f.qual_agendamento.value = "DESTINO";
				f.target = "escondido";
				f.action = "mov_passacarga_buscaeq.asp";
				f.submit();
			}
		</script>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<table width="100%" class="texto1" cellpadding="2" cellspacing="0">
			<tr></tr>
		</table>
		
		Equipamentos cedidos ao usu&aacute;rio<br>
		<select multiple name="eq_destino" style="width: 640px;" class="texto1" size="6"></select>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td align="center"><button class="texto1" onclick="javascript:validaRecepcao();">&gt;&gt; Receber carga dos itens selecionados</button></td>
</tr>
</table>
</form>
<iframe src="" name="escondido" style="display: none;"></iframe>
<script language="JavaScript">
var d = document.forms[0];
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