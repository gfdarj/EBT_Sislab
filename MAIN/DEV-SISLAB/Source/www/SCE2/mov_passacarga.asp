<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Server.ScriptTimeout = 360000

Tela.SetNomeTela = "SCE > Movimentação > Passagem de Carga" : Tela.SetCaminhoRelativo = "../"

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
<%
if request("msg") = "1" then %>
<tr>
	<th>
		Passagem de carga solicitada com sucesso. <br>Aguarde a confirmação pelo RT do agendamento destino !
	</th>
</tr>
<tr><td>&nbsp;</td></tr>
<%
End If
%>
<tr><th>Meus agendamentos: (<small><%=Env.Usuario%></small>)</th></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<%=Combo.MeusAgendamentos(True, "txtAS_origem", "ag_numero_origem", CStr(ag_numero), "N")%>
		<%'call comboAgendamento("txtAS_origem", "ag_numero_origem", Env.oConn, cstr(ag_numero), "N")%>
		&nbsp;&nbsp;&nbsp;
		<span id="responsavel_origem" class="text-info">&nbsp;</span>
		<script type="text/javascript">
			var f = document.formulario;
            f.ag_numero_origem.onchange = BuscaEqOrigem;
			f.txtAS_origem.onblur = BuscaEqOrigem;
            function BuscaEqOrigem()
            {
                atualizarEQ(f.eq_origem, "ORIGEM", f.ag_numero_origem.value);
			}
		</script>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<b>*&nbsp;</b>Equipamentos em condições de carga (sem reservas no período do agendamento)<br>
		<select multiple name="eq_origem" style="width: 640px;"  size="6"></select>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><th>Selecione o agendamento de <span class="text-danger">destino</span></th></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<%'call comboMeusAgendamentos(false, "txtAS_destino", "ag_numero_destino", Env.oConn, cstr(ag_numero), "N")%>
		<%=Combo.MeusAgendamentos(False, "txtAS_destino", "ag_numero_destino", CStr(ag_numero), "N")%>
		&nbsp;&nbsp;&nbsp;
		<input type="button" value="Mover para destino" onclick="passarEqDestino();">
		<span id="responsavel_destino" style="font-weight: bold; font-style: italic;">&nbsp;</span>
		<script type="text/javascript">
			f.ag_numero_destino.onchange = BuscaEqDestino;
			f.txtAS_destino.onblur = BuscaEqDestino;
            function BuscaEqDestino()
            {
				removeSelecionadosDestino(1);
                atualizarEQ(f.eq_destino, "DESTINO", f.ag_numero_destino.value);
			}
		</script>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<b>*&nbsp;</b>Equipamentos <b>cedidos</b> ao agendamento destino<br>
		<select multiple name="eq_destino" style="width: 640px;"  size="6"></select>
		<br>
		<small>(<a href="#" onclick="javascript:removeSelecionadosDestino(0);">clique aqui para remover itens selecionados</a>)</small>

	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td><input type="button" onclick="javascript:validaPassagem();" value="Passar a carga dos itens selecionados &gt;&gt;"></td>
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

        var maxAjaxObj = new max.Ajax(url, {
            update: "", onComplete:
			function(texto,xml){
				montaComboSemVazio(objCombo, texto);
			}
		});
		maxAjaxObj.get();
	}

    // confirma e salva a passagem
    function validaPassagem() {
	    if(!validaAgendamentos()) {
		    // msg de erro na funcao
	    }
	    else {
		    d.action = "mov_passacarga2.asp";
		    d.method = "post";
		    d.target = "";

		    for(i=0; i<d.eq_destino.length; i++)
			    d.eq_destino.options[i].selected = true;

		    d.submit();
	    }
    }

    function validaAgendamentos() {
	    var ret = false;
	    if(d.ag_numero_origem.value == "") {
		    alert("Selecione o seu agendamento primeiro.");
		    d.ag_numero_origem.focus();
	    }
	    else if(d.ag_numero_destino.value == "") {
		    alert("Selecione o agendamento de destino.");
		    d.ag_numero_destino.focus();
	    }
	    else if(d.ag_numero_origem.value == d.ag_numero_destino.value) {
		    alert("Os agendamentos são iguais. Selecione outro agendamento.");
		    d.ag_numero_origem.focus();
	    }
	    else { ret = true; }
	    return ret;
    }
    function passarEqDestino() {
	    var i = 0;
	    var jaExiste = false;

	    if(!validaAgendamentos()) {
		    // msg de erro na funcao
	    }
        else {
            while (d.eq_origem.selectedIndex != -1)
            {
                if (!existeNaLista(d.eq_origem.options[d.eq_origem.selectedIndex].value, d.eq_destino)) {
                    d.eq_destino.options[d.eq_destino.options.length] = new Option(d.eq_origem.options[d.eq_origem.selectedIndex].text, d.eq_origem.options[d.eq_origem.selectedIndex].value);
				    d.eq_origem.options[d.eq_origem.selectedIndex] = null;
			    }
			    else {
				    //d.eq_origem.options[d.eq_origem.selectedIndex].selected = false;
				    d.eq_origem.options[d.eq_origem.selectedIndex] = null;
				    jaExiste = true;
			    }
		    }
		    if( d.eq_destino.options.length > 1 ) {
			    Quicksort(d.eq_destino, 0, d.eq_destino.options.length-1);
		    }
		    if(jaExiste) alert("Alguns itens não foram inseridos na lista destino\npois já se encontram selecionados.");
	    }
    }

    function existeNaLista(valor, lista) {
	    var i;
	    for(i=0; i<lista.length; i++) {
		    if (lista.options[i].value == valor) {
			    return true;
			    break;
		    }
	    }
	    return false;
    }

    function removeSelecionadosDestino(tudo) {
	    var i;
	    if (tudo) {
		    for(i=0; i< d.eq_destino.length; i++)
			    d.eq_destino.options[i].selected = true;
	    }
	    else {
		    if(d.eq_destino.options.selectedIndex == -1) {
			    alert("Nenhum item selecionado");
		    }
	    }

	    while (d.eq_destino.selectedIndex != -1) {
            if (!existeNaLista(d.eq_destino.options[d.eq_destino.selectedIndex].value, d.eq_origem)) {
                d.eq_origem.options[d.eq_origem.options.length] = new Option(d.eq_destino.options[d.eq_destino.selectedIndex].text, d.eq_destino.options[d.eq_destino.selectedIndex].value);
			    d.eq_destino.options[d.eq_destino.selectedIndex] = null;
		    }
		    else {
			    d.eq_destino.options[d.eq_destino.selectedIndex] = null;
			    //d.eq_destino.options[d.eq_destino.selectedIndex].selected = false;
		    }
	    }
	    if( d.eq_origem.options.length > 1 )
		    Quicksort(d.eq_origem, 0, d.eq_origem.options.length-1);
    }

    // nao quis funcionar estando no arquivo BIB_STR.JS, nao sei o motivo !!
    //-- gilberto
    function Quicksort(vec, loBound, hiBound)
    {
	    var pivot, pivot_text, loSwap, hiSwap, temp, temp_text;

	    // Two items to sort
	    if (hiBound - loBound == 1)
	    {
		    if (vec.options[loBound].text > vec.options[hiBound].text)
		    {
			    temp = vec.options[loBound].value;
			    vec.options[loBound].value = vec.options[hiBound].value;
			    vec.options[hiBound].value = temp;
			    temp_text = vec.options[loBound].text;
			    vec.options[loBound].text = vec.options[hiBound].text;
			    vec.options[hiBound].text = temp_text;
		    }
		    return;
	    }

	    // Three or more items to sort
	    pivot = vec.options[parseInt((loBound + hiBound) / 2)].value;
	    pivot_text = vec.options[parseInt((loBound + hiBound) / 2)].text;
	    vec.options[parseInt((loBound + hiBound) / 2)].value = vec.options[loBound].value;
	    vec.options[loBound].value = pivot;
	    vec.options[parseInt((loBound + hiBound) / 2)].text = vec.options[loBound].text;
	    vec.options[loBound].text = pivot_text;
	    loSwap = loBound + 1;
	    hiSwap = hiBound;

	    do {
		    // Find the right loSwap
		    while (loSwap <= hiSwap && vec.options[loSwap].text <= pivot_text)
		    loSwap++;
	
		    // Find the right hiSwap
		    while (vec.options[hiSwap].text > pivot_text)
		    hiSwap--;
	
		    // Swap values if loSwap is less than hiSwap
		    if (loSwap < hiSwap)
		    {
			    temp = vec.options[loSwap].value;
			    vec.options[loSwap].value = vec.options[hiSwap].value;
			    vec.options[hiSwap].value = temp;
			    temp_text = vec.options[loSwap].text;
			    vec.options[loSwap].text = vec.options[hiSwap].text;
			    vec.options[hiSwap].text = temp_text;
		    }
	    } while (loSwap < hiSwap);

	    vec.options[loBound].value = vec.options[hiSwap].value;
	    vec.options[hiSwap].value = pivot;
	    vec.options[loBound].text = vec.options[hiSwap].text;
	    vec.options[hiSwap].text = pivot_text;

	    // Recursively call function...  the beauty of quicksort

	    // 2 or more items in first section
	    if (loBound < hiSwap - 1)
	    Quicksort(vec, loBound, hiSwap - 1);

	    // 2 or more items in second section
	    if (hiSwap + 1 < hiBound)
	    Quicksort(vec, hiSwap + 1, hiBound);
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
