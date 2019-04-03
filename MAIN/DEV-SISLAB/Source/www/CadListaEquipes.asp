<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Lista das Equipes " & Application("SISLAB_NOME_EMPRESA"), "location.href='sislab.asp'", "")

If not Env.ehRAT Then 
    Response.Write "<br />" & Env.MensagemAcessoExclusivo()
    Call Tela.MostraRodape()
    Response.End
End If

Dim gerente, lista, RS, bEof
gerente = Request("gerente")
lista = ""
bEof = True
%>
<script type="text/javascript" src="includes/ValidacaoEmail.js"></script>
<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    function BuscarGerente(){
	    var frm = document.forms[0];
	    frm.action = "CadListaEquipes.asp";
	    frm.target = "_parent";
	    frm.submit();
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;	
    }
    function Cancela(){
	    var frm = document.forms[0];
	    frm.action = "sislab.asp";
	    frm.target = "_parent";
	    frm.submit();
    }
    function ValidaCampos(){
	    var frm = document.forms[0];

	    if (frm.lista.length == 0) {
		    alert('É necessário informar um usuário membro da equipe.');
		    frm.novo_participante.focus();
		    return false
	    }

	    /* CONTATENA A LISTA */
	    frm.lista_participante.value = '';
	    for(i=0; i < frm.lista.length; i++)
	    {
		    frm.lista_participante.value += frm.lista[i].value;
		    if(i != frm.lista.length-1) frm.lista_participante.value += ','; 
	    }

	    frm.action = "CadListaEquipesA.asp";
	    //frm.target = "_parent";
	    frm.submit();
    }

    function IncluirNovo() {
	    var frm = document.forms[0];
	    frm.novo_gerente.value = "";
	    frm.novo_gerente.focus();
	    frm.lista.length = 0;
	    frm.gerente.value = "";
	    frm.btnIncluir.disabled = true;
	    frm.btnExcluir.disabled = true;
	    frm.btnSalvar.disabled = false;
	    frm.btnCancelar.disabled = false;	
    }

    function Excluir() {
	    var frm = document.forms[0];
	    if(frm.gerente.value == '') {
		    alert('Nenhum Gerente selecionado para exclusão !');
		    frm.gerente.focus();
	    }
	    else {
		    frm.excluir.value = '1';
		    frm.action = "CadListaEquipesA.asp";
		    frm.target = "_parent";
		    frm.submit();
	    }
    }
</script>

<div class="margem-10">
    <form method="post" action="CadListaEquipesA.asp" name="frm">
        <input type="hidden" name="excluir" value="0">
        <input type="hidden" name="lista_participante" value="">

        <table>
        <tr> 
	        <td></td>
	        <td></td>
        </tr>
        <tr> 
	        <td colspan="2">&nbsp;<span class="texto-vermelho-bold">*</span>&nbsp; Indica um Campo Obrigatório</td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><td colspan="2"><span class="texto-vermelho-bold">Cadastro de equipes da <%=Application("SISLAB_NOME_EMPRESA")%> para que o gerente possa ter acesso à dados sigilosos dos agendamentos que foram criados pelos membros da sua equipe.</span></td></tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Gerencia</th></tr>

        <tr>
	        <td>Username do Gerente:</td>
	        <td>
		        <%Call comboBDSQL_2("gerente", Env.oConn, "select DISTINCT UserId_Gerente AS VALOR, UserId_Gerente AS DESCRICAO from EquipeEmbratel ORDER BY UserId_Gerente", "N", true)%>
		        &nbsp;&nbsp;
		        <input type="button" value="Buscar" onclick="BuscarGerente();">
	        </td>
        </tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr><th colspan="2">Equipe</th></tr>

        <tr>
	        <td>&nbsp;<span class="texto-vermelho-bold">*</span>&nbsp;Username do Gerente:</td>
	        <td><input type="text" name="novo_gerente" size="50" maxlength="80"></td>
        <tr>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td style="vertical-align: top;"><span class="texto-vermelho-bold">*</span>&nbsp;Username da Equipe:</td>
	        <td>
		        <table class="largura-total">
		        <tr style="vertical-align: top;">
			        <td>Username do Participante<BR>
				        <input type="text" name="novo_participante" size="50" maxlength="80">
			        </td>
			        <td valign="middle">
				        <input type="button" name="add" value="&gt;" onclick="javascript:adiciona_retira_participantes(1);"><br>
				        <input type="button" name="remove" value="&lt;" onclick="javascript:adiciona_retira_participantes(0);">
			        </td>
			        <td>
				        Usuários adicionados<BR>
				        <select name="lista" style="width: 250px; HEIGHT: 100px;" multiple>
<%
if Not VVVN(gerente) Then
	ssql = "select * from EquipeEmbratel where UserId_Gerente = '" & gerente & "'"
	Set RS = Env.oConn.Execute(ssql)
	bEof = RS.Eof
	While Not RS.Eof %>
    			    		<option value="<%=RS("UserId_Membro")%>"><%=RS("UserId_Membro")%></option>
<%		RS.MoveNext
	WEnd
End If %>
				        </select>
			        </td>
		        </tr>
		        </table>
	        </td>
        <tr>

        <script type="text/javascript">
            function adiciona_retira_participantes(tipo)
            {
	            var frm = document.forms[0]
	            var nome = frm.novo_participante;
	            var lista = frm.lista;
	            var ultimo;

	            if (tipo == 0){
		            if (lista.selectedIndex != -1){
			            lista.options[lista.selectedIndex]=null;
		            }
	            }
	            else
	            {
		            if (nome.value == ""){
			            alert("O campo 'Participante' deve ser preenchido.");
			            nome.focus();
		            }
		            else if (!validacaoEmail(nome.value)) {
		                alert("E-mail inválido!");
		                nome.focus();
                    }
		            else {
		                ultimo = lista.options.length;
		                lista.options[ultimo] = new Option(nome.value, nome.value);
		                lista.options[ultimo].value = nome.value;
		                nome.value = "";
		                nome.focus();
		            }
	            }
            }
        </script>

        <tr><td colspan="2">&nbsp;</td></tr>

        <tr>
	        <td colspan="2">
		        <input type="button"  onclick="ValidaCampos()" value="Salvar Dados" name="btnSalvar">
		        <input type="button"  onclick="IncluirNovo()" value=" Incluir " name="btnIncluir">
		        <input type="button"  onclick="Excluir()" value=" Excluir " name="btnExcluir">
		        <input type="button"  onclick="Cancela()" value=" Cancelar " name="btnCancelar">
	        </td>
        </tr>
        </table>
    </form>
    <iframe name="escondido" style="display: none;"></iframe>
</div>

<script type="text/javascript">
    var frm = document.forms[0];
    var frmAll = document.all;
    <%
    If Not VVVN(gerente) then
	    If Not bEof Then%>
		    frm.btnIncluir.disabled = false;
		    frm.btnExcluir.disabled = false;
		    frm.novo_gerente.value = '<%=UCase(gerente)%>';
	    <%Else%>
		    frm.btnSalvar.disabled = true;
		    frm.btnCancelar.disabled = true;	
	    <%End If
    else%>
	    frm.btnSalvar.disabled = true;
	    frm.btnCancelar.disabled = true;
    <%end if%>
</script>
<%
Set RS = Nothing

Call Tela.MostraRodape()
%>
