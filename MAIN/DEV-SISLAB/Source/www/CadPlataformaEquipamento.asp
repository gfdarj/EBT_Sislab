<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Server.ScriptTimeout = 10000

Dim objRS, s, plataforma, mod_id

If Not Env.ehRAT Then RESPONSE.REDIRECT "INDEX.ASP"

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Equipamentos em Plataformas", "location.href='sislab.asp'", "")

plataforma = request("plataforma")
If plataforma = "" Then plataforma = "0"

mod_id = Trim(request("mod_id"))
%>
<script type="text/javascript">
    function existeNaLista(lista, valor)
    {
	    var i;
	    for(i=0; i<lista.length; i++) {
		    if(lista[i].value == valor) {
			    return true;
		    }
	    }
	    return false;
    }
    function selecionouLista(lista)
    {
	    if(lista.selectedIndex < 0) {
		    alert('Selecione um equipamento da lista !');
		    lista.focus();
		    return false;
	    }
	    else {
		    lista.focus();
		    return true;
	    }
    }
    function BuscarPlataformas()
    {
	    frm.action = 'CadPlataformaEquipamento.asp';
	    frm.target = '_parent';
	    frm.submit();
    }
    function adicionar()
    {
	    var i, ultimo, jaExiste;
	    if(selecionouLista(frm.eq_disp))
	    {
		    for(i=0; i<frm.eq_disp.length; i++) {
			    if(!existeNaLista(frm.eq_comp, frm.eq_disp.options[i].value))
			    {
				    if(frm.eq_disp.options[i].selected) {
					    ultimo = frm.eq_comp.options.length;
					    frm.eq_comp.options[ultimo] = new Option(frm.eq_disp[i].text, frm.eq_disp[i].value);
				    }
			    }
		    }
	    }
    }
    function remover()
    {
	    var i, ultimo;
	    if(selecionouLista(frm.eq_comp))
	    {
		    ultimo = frm.eq_comp.length;
		    for(i=0; i<frm.eq_comp.length; i++) {
			    if(frm.eq_comp.options[i].selected) {
				    frm.eq_comp.options[i] = null;
				    i -= 1;
			    }
		    }
	    }
    }
    function salvaPlataforma(frm)
    {
	    var i;
	    var lista = '';
	    if(frm.plataforma.value == '')
	    {
		    alert('Selecione uma plataforma antes de salvar');
		    return false;
	    }
	    else
	    {
		    // monta a lista de equipamentos
		    for(i=0; i<frm.eq_comp.length; i++)
		    {
			    lista += frm.eq_comp.options[i].value
			    if(i != (frm.eq_comp.length - 1)) lista += ',';
		    }
		    frm.listaEquipamentos.value = lista;

		    frm.action = 'CadPlataformaEquipamentoA.asp';
		    frm.target = '_parent';
		    frm.submit();
		    return true;
	    }
    }
</script>

<div class="margem-10">
    <form method="post" action="" name="frm">
        <input type="hidden" name="listaEquipamentos" value="">

        <table>
        <tr><td>&nbsp;</td></tr>

        <tr><th>Selecione a Plataforma</th></tr>

        <tr>
	        <td>
                Plataforma:&nbsp;
		        <%call comboServicosPlataformas("plataforma", Env.oConn, "N", "P")%>
		        <script type="text/javascript">
			        frm.plataforma.onchange = BuscarPlataformas;
			        frm.plataforma.value = '<%=plataforma%>';
		        </script>
	        </td>
        </tr>

        <tr><td>&nbsp;</td></tr>

        <tr><th>Equipamentos da Plataforma</th></tr>

        <tr>
	        <td>
		        Modelos disponíveis<br>
		        <%call comboBDSQL("mod_id", Env.oConn, "SELECT MOD_ID as valor, MOD_CODNOME as descricao FROM SCE_Modelos ORDER BY MOD_CODNOME", mod_id, true)%>
		        <script type="text/javascript">
		            function mudaModelo()
		            {
			            document.forms[0].action = 'eventosInternos.asp?hdnEvento=14&mod_id=' + document.forms[0].mod_id.value;
			            document.forms[0].target = 'escondido';
			            document.forms[0].method = 'post';
			            document.forms[0].submit();
		            }
		            document.all.mod_id.onchange = mudaModelo;
		        </script>
	        </td>
        </tr>

        <tr><td>&nbsp;</td></tr>

        <tr>
	        <td>
				Equipamentos disponíveis<br>
				<select name="eq_disp" multiple size="7" style="width: 630px;"></select>
	        </td>
        </tr>
        <tr>
			<td class="texto-direito">
				<input type="button" value="Adicionar" onclick="javascript: adicionar();">&nbsp;&nbsp;
				<input type="button" value=" Remover " onclick="javascript: remover();">
			</td>
        </tr>

        <tr><td>&nbsp;</td></tr>
        <tr>
	        <td>
		        Equipamentos componentes da plataforma<br>
		        <select name="eq_comp" multiple size="7" style="width: 630px;">
<%
's =	"SELECT f.EQ_ID, f.EQ_CODIGOBARRAS, f.MOD_CODNOME, f.MOD_DESCRICAO " & _
'	"FROM vw_SCE_Equipamentos_Fabricantes f INNER JOIN Plataforma_Equipamentos pe " & _
'	"ON f.EQ_ID = pe.EQ_ID " & _
'	"WHERE pe.S_ID = " & plataforma & " " & _
'	"ORDER BY MOD_DESCRICAO, EQ_CODIGOBARRAS"
s =	"SELECT e.EQ_ID, e.EQ_CODIGOBARRAS, m.MOD_CODNOME, m.MOD_DESCRICAO " & _
	"FROM SCE_Equipamentos e INNER JOIN SCE_Modelos m ON e.MOD_ID = m.MOD_ID " & _
	"INNER JOIN Plataforma_Equipamentos pe ON e.EQ_ID = pe.EQ_ID " & _
	"WHERE pe.S_ID = " & plataforma & " " & _
	"ORDER BY MOD_DESCRICAO, EQ_CODIGOBARRAS"
call Env.RecordSet(true, objRS, s)
while not objRS.Eof
	Response.Write "<option value='" & objRS("EQ_ID") & "'>" & objRS("EQ_CODIGOBARRAS") & " - " & objRS("MOD_CODNOME") & " - " & objRS("MOD_DESCRICAO") & "</option>"
	objRS.MoveNext
wend
call Env.RecordSet(false, objRS, null)
%>
		        </select>
	        </td>
        </tr>

        <tr><td>&nbsp;</td></tr>

        <tr><td><input type="button" value=" Salvar " onclick="javascript:return salvaPlataforma(document.forms[0]);"></td></tr>

        </table>
    </form>
    <iframe src="" name="escondido" style="display: none;"></iframe>
    <br />
</div>

<script type="text/javascript">
	var frm = document.forms[0];
</script>
<%
Call Tela.MostraRodape()
%>
