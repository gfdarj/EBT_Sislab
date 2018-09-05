<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Lista das Equipes da Embratel ", "location.href='sislab.asp'", "")

if not Env.ehRAT then response.redirect "index.asp"

Dim gerente, lista, RS, bEof
gerente = Request("gerente")
lista = ""
bEof = True
%>
<script language="javascript" src="includes/anexo.js"></script>
<script language="javascript">
function BuscarGerente(){
	var frm = document.forms[0];
	frm.action = "CadListaEquipesEmbratel.asp";
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

	frm.action = "CadListaEquipesEmbratelA.asp";
	//frm.target = "_parent";
	frm.submit();
}
function IncluirNovo(){
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
		frm.action = "CadListaEquipesEmbratelA.asp";
		frm.target = "_parent";
		frm.submit();
	}
}
</script>
<form method="post" action="CadListaEquipesEmbratelA.asp" name="frm">
<input type="Hidden" name="excluir" value="0">
<input type="Hidden" name="lista_participante" value="">
<table border="0" width="100%" cellpadding="2" cellspacing="0" class="tabela1">
<tr> 
	<td width="50px"></td>
	<td width="*"></td>
</tr>
<tr> 
	<td colspan="2">&nbsp;<span class="vermelho2"><b>*</span>&nbsp; Indica um Campo Obrigatório</b></td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><td colspan="2"><p><b><font color="#ff0000">Cadastro de equipes da embratel para que o gerente possa ter acesso à dados sigilosos dos agendamentos que foram criados pelos membros da sua equipe.</font></b></p></td></tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">Gerencia</td></tr>

<tr>
	<td>&nbsp;&nbsp;<b>Username do Gerente:</b></td>
	<td>
		<%Call comboBDSQL_2("gerente", Env.oConn, "select DISTINCT UserId_Gerente AS VALOR, UserId_Gerente AS DESCRICAO from EquipeEmbratel ORDER BY UserId_Gerente", "N", true)%>
		&nbsp;&nbsp;
		<input class="texto1" type="Button" value="Buscar" onclick="BuscarGerente();">
	</td>
</tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr><th align="left" colspan="2">&nbsp;&nbsp;Equipe</th></tr>

<tr>
	<td>&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Username do Gerente:</b></td>
	<td><input type="Text" name="novo_gerente" size="20" maxlength="20" class="texto1"></td>
<tr>

<tr><td colspan="2">&nbsp;</td></tr>

<tr>
	<td valign="top">&nbsp;<span class="vermelho2"><b>*</span>&nbsp;Username da Equipe:</b></td>
	<td>
		<table class="texto1">
		<tr valign="top">
			<td><b>Participante</b><BR>
				<input type="Text" name="novo_participante" size="20" maxlength="20" class="texto1">
			</td>
			<td valign="middle">
				<input type="Button" name="add" value="&gt;" onclick="javascript:adiciona_retira_participantes(1);"><br>
				<input type="Button" name="remove" value="&lt;" onclick="javascript:adiciona_retira_participantes(0);">
			</td>
			<td>
				<b>Usuários adicionados</b><BR>
				<select name="lista" style="width: 150px; HEIGHT: 100px;" class="texto1" multiple>
<%
if Not VVVN(gerente) Then
	ssql = "select * from EquipeEmbratel where UserId_Gerente = '" & gerente & "'"
	Set RS = Env.oConn.Execute(ssql)
	bEof = RS.Eof
	While Not RS.Eof %>
					<option value="<%=RS("UserId_Membro")%>"><%=RS("UserId_Membro")%></option>
<%		RS.MoveNext
	WEnd
End If
%>
				</select>
			</td>
		</tr>
		</table>
	</td>
<tr>

<script language="JavaScript">
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
	else{
		if (nome.value == ""){
			alert("O campo 'Participante' deve ser preenchido.");
			nome.focus();		
		}
		else{
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
	<td colspan="2">&nbsp;&nbsp;
		<input type="Button" class="texto1" onclick="ValidaCampos()" value="Salvar Dados" name="btnSalvar">
		<input type="Button" class="texto1" onclick="IncluirNovo()" value=" Incluir " name="btnIncluir">
		<input type="Button" class="texto1" onclick="Excluir()" value=" Excluir " name="btnExcluir">
		<input type="Button" class="texto1" onclick="Cancela()" value=" Cancelar " name="btnCancelar">
	</td>
</tr>
</table>
</form>
<iframe name="escondido" style="display: none;"></iframe>
<script>
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
Call ImprimeRodape(RODAPE_OFF)
%>

