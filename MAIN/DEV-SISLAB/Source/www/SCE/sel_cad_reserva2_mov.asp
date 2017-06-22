<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#inc lude file="../includes/controlesHTML.asp" -->
<!--#include file="../includes/funcoes.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/Abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<%
'-- RECEBE OS EQUIPAMENTOS ESCOLHIDOS (ACEITO/NAO ACEITO) DA LISTA DE RESERVAS E MOSTRA
'-- AO USUARIO A LISTA DOS MESMOS. PODENDO O USUÁRIO MOVIMENTAR OU ENTAO VOLTAR À TELA DE CONSULTA

Dim lista_itens, item

call ImprimeCabecalho ("", MENU_ON, true, "Movimentação de Itens Reservados - AS: " & request("ag_numero"), "", "history.go(-1);")

'-- retiro as marcacoes de aceito/nao aceito pois auqi so vao entrar itens aceitos para realizarem a
'-- movimentacao
lista_itens = replace(replace(replace(request("lista_itens"), "__", ""), "1_", ""), "0_", "")
%>
<form name="formulario" action="mov_acessorios.asp">
<input type="hidden" name="retornar_para" value="sel_cad_reserva.asp">
<input type="hidden" name="ag_numero" value="<%=request("ag_numero")%>">
<input type="hidden" name="eq_id" value="<%=lista_itens%>">
<input type="hidden" name="ehReserva" value="SIM">
<table width="100%" class="texto">
<tr><th class="titulo">Lista de itens selecionados para movimenta&ccedil;&atilde;o pela Reserva/AG <%=request("ag_numero")%></th></tr>
<tr><td>&nbsp;</td></tr>
<tr id="tr_data_movimento"><td>Data da Movimenta&ccedil;&atilde;o:&nbsp;<%Call comboData("Mov")%></td></tr>
<tr id="tr_data_movimento_branco"><td>&nbsp;</td></tr>
<tr>
	<td>
		<table width="100%" border="1" cellpadding="2" cellspacing="0" class="texto">
		<tr>
			<th width="120px">C&oacute;d Barras</th>
			<th>Modelo</th>
			<th>Descri&ccedil;&atilde;o</th>
			<th>Fabricante</th>
			<th width="100px">Localiza&ccedil;&atilde;o</th>
			<th>Ambiente</th>
		</tr>
<%
Dim s, rec
s =	"SELECT EQ_ID, EQ_CODIGOBARRAS, MOD_CODNOME, MOD_DESCRICAO, FAB_NOME, EQ_LOCALIZACAO, AMB_NOME " & _
	"FROM vw_SCE_Reserva_Equipamentos WHERE AG_NUMERO = " & request("ag_numero") & " AND " & _
	"EQ_ID IN (" & lista_itens & ") " & _
	"ORDER BY EQ_CODIGOBARRAS, MOD_CODNOME"
Set rec = Conn.Execute( s )
while not rec.eof%>
		<tr>
			<td><%=rec("EQ_CODIGOBARRAS")%></td>
			<td><%=rec("MOD_CODNOME")%></td>
			<td><%=rec("MOD_DESCRICAO")%></td>
			<td><%=rec("FAB_NOME")%></td>
			<td><%=rec("EQ_LOCALIZACAO")%></td>
			<td align="center"><%=rec("AMB_NOME")%></td>
		</tr>
<%	rec.MoveNext
wend%>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td align="center">
		<input type="Button" name="btnNovaConsulta" value="Nova Consulta" class="form" onclick="javascript:location.href='sel_cad_reserva.asp';" style="width: 100px;  display: inline;">
		&nbsp;&nbsp;
		<input type="Button" name="btnImprimir" value="Imprimir" class="form" onclick="javascript:imprimirLista();" style="width: 100px;  display: inline;">
		&nbsp;&nbsp;
		<input type="Button" name="btnMovimentar" value="Movimentar" onclick="javascript:movimentarReserva();" class="form" style="width: 100px; display: inline;">
	</td></tr>
</table>
</form>
<script language="JavaScript">
function movimentarReserva() {
	document.formulario.submit();
}
function imprimirLista() {
	document.all.btnNovaConsulta.style.display = "none";
	document.all.btnImprimir.style.display = "none";
	document.all.btnMovimentar.style.display = "none";

	document.all.tr_data_movimento.style.display = "none";
	document.all.tr_data_movimento_branco.style.display = "none";

	imprimeConteudoSCE();

	document.all.tr_data_movimento.style.display = "inline";
	document.all.tr_data_movimento_branco.style.display = "inline";

	document.all.btnNovaConsulta.style.display = "inline";
	document.all.btnImprimir.style.display = "inline";
	document.all.btnMovimentar.style.display = "inline";
}

document.formulario.diaMov.value = '<%=Zeros(Day(Date()),2)%>';
document.formulario.mesMov.value = '<%=Zeros(Month(Date()),2)%>';
document.formulario.anoMov.value = '<%=Year(Date())%>';
</script>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>

