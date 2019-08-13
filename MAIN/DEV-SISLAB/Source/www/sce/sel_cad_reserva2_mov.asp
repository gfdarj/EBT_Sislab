<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
'-- RECEBE OS EQUIPAMENTOS ESCOLHIDOS (ACEITO/NAO ACEITO) DA LISTA DE RESERVAS E MOSTRA
'-- AO USUARIO A LISTA DOS MESMOS. PODENDO O USUÁRIO MOVIMENTAR OU ENTAO VOLTAR À TELA DE CONSULTA

Dim lista_itens, item

Tela.SCE = True
Tela.SetNomeTela = "Consulta > Movimentação de Itens Reservados - AS: " & request("ag_numero") : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()

    '-- retiro as marcacoes de aceito/nao aceito pois auqi so vao entrar itens aceitos para realizarem a
    '-- movimentacao
    lista_itens = replace(replace(replace(request("lista_itens"), "__", ""), "1_", ""), "0_", "")
%>
<div class="margem-10">

<form name="formulario" action="mov_acessorios.asp">
<input type="hidden" name="retornar_para" value="sel_cad_reserva.asp">
<input type="hidden" name="ag_numero" value="<%=request("ag_numero")%>">
<input type="hidden" name="eq_id" value="<%=lista_itens%>">
<input type="hidden" name="ehReserva" value="SIM">

<table class="largura-total">
<tr><th class="destaque">Lista de itens selecionados para movimentação pela Reserva/AG <%=request("ag_numero")%></th></tr>
<tr><td>&nbsp;</td></tr>
<tr id="tr_data_movimento"><td>Data da Movimentação:&nbsp;<%RW Combo.Data("Mov")%></td></tr>
<tr id="tr_data_movimento_branco"><td>&nbsp;</td></tr>
<tr>
	<td>
		<table class="largura-total table-condensed table-bordered table-striped table-hover">
		<tr>
			<th width="120px">Cód Barras</th>
			<th>Modelo</th>
			<th>Descrição</th>
			<th>Fabricante</th>
			<th width="100px">Localização</th>
			<th>Ambiente</th>
		</tr>
<%
Dim s, rec
s =	"SELECT EQ_ID, EQ_CODIGOBARRAS, MOD_CODNOME, MOD_DESCRICAO, FAB_NOME, AMB_NOME, AMB_NOME_RESERVA " & _
	"FROM vw_SCE_Reserva_Equipamentos WHERE AG_NUMERO = " & request("ag_numero") & " AND " & _
	"EQ_ID IN (" & lista_itens & ") " & _
	"ORDER BY EQ_CODIGOBARRAS, MOD_CODNOME"
Set rec = Env.oConn.Execute(s)
while not rec.eof%>
		<tr>
			<td><%=rec("EQ_CODIGOBARRAS")%></td>
			<td><%=rec("MOD_CODNOME")%></td>
			<td><%=rec("MOD_DESCRICAO")%></td>
			<td><%=rec("FAB_NOME")%></td>
			<td><%=rec("AMB_NOME")%></td>
			<td align="center"><%=rec("AMB_NOME_RESERVA")%></td>
		</tr>
<%	rec.MoveNext
wend%>
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td align="center">
		<input type="button" name="btnNovaConsulta" value="Nova Consulta"  onclick="javascript:location.href='sel_cad_reserva.asp';" style="width: 120px;  display: inline;">
		&nbsp;&nbsp;
		<input type="button" name="btnImprimir" value="Imprimir"  onclick="javascript:imprimirLista();" style="width: 120px;  display: inline;">
		&nbsp;&nbsp;
		<input type="button" name="btnMovimentar" value="Movimentar" onclick="javascript:movimentarReserva();"  style="width: 120px; display: inline;">
	</td></tr>
</table>
</form>

<br />

</div>

<script type="text/javascript">
    function movimentarReserva()
    {
    	document.formulario.submit();
    }
    function imprimirLista() {
	    document.all.btnNovaConsulta.style.display = "none";
	    document.all.btnImprimir.style.display = "none";
	    document.all.btnMovimentar.style.display = "none";

	    document.all.tr_data_movimento.style.display = "none";
	    document.all.tr_data_movimento_branco.style.display = "none";

	    //imprimeConteudoSCE();
	    window.print();

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
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
