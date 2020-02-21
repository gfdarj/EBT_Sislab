<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Lib/Classe_SCE.asp"-->
<!--#incl ude file="../Lib/Classe_Combo.asp"-->
<%
Server.ScriptTimeout = 10000

Tela.SetNomeTela = "SCE > Cadastro > Reserva de Equipamentos > Filtro de Seleção" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Sce
    Set Sce = New TSce

    '-- JANELA AUXILIAR DE SELEÇÃO DE ITENS PARA O CADASTRO DE RESERVAS --

    Dim s, w, objRS, reservado, listaNF

    s =	"SELECT DISTINCT e.EQ_ID, e.EQ_CODIGOBARRAS, e.STATUS, ma.ASA AS AG_NUMERO, ma.MOV_SOLICITANTE, " & _
        "e.MOD_CODNOME, e.MOD_DESCRICAO, " & _
	    "e.EQ_LOCALIZACAO, e.FAB_NOME, e.EQ_INSTRUMENTAL, e.EQ_CONFORME, e.EQ_NUMEROSERIE "

    '-- nao pego o campo de NF porque podem existir várias notas para o item,
    '-- logo os mesmos aparecerao repetidos. Utilizo uma funcao para pegar a lista de
    '-- NF´s
    'if request("notafiscal") <> "" or request("fornecedor") <> "" then
    '	s = s & ", nf.NF_NUMERONOTA "
    'else
    '	s = s & ", NULL AS NF_NUMERONOTA "
    'end if

    s = s & "FROM vw_SCE_Equipamentos_Fabricantes e LEFT JOIN vw_SCE_Movimentacao_Atual ma ON e.EQ_ID = ma.EQ_ID "
    w = ""

    '-- So faco o join no caso de ter preenchido a NF ou o Fornecedor, caso contrario
    '-- uso uma funcao para retornar as NF´s do item
    if request("notafiscal") <> "" or request("documento") <> "" or request("fornecedor") <> "" then
	    s =	s & "INNER JOIN SCE_Movimentacao m ON e.EQ_ID = m.EQ_ID " & _
		    "LEFT JOIN SCE_Nota_Fiscal nf ON m.NF_ID = nf.NF_ID "
	    if request("notafiscal") <> "" then
		    if w <> "" then w = w & " and "
		    w = w & " nf.NF_NUMERONOTA = " & request("notafiscal") & " "
	    end if
	    if request("documento") <> "" then
		    if w <> "" then w = w & " and "
		    w = w & " m.DOC_ID = " & request("documento") & " "
	    end if
	    if request("fornecedor") <> "" then
		    if w <> "" then w = w & " and "
		    w = w & " nf.ENF_ID = " & request("fornecedor") & " "
	    end if
    end if

    if request("modelo") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " UPPER(e.mod_codnome) like '%"& ucase(trim(replace(request("modelo"), "'", ""))) &"%' "
    end if
    if request("desc_modelo") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " UPPER(e.mod_descricao) like '%"& ucase(trim(replace(request("desc_modelo"), "'", ""))) &"%' "
    end if
    if request("fabricante") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " e.fab_id = "& request("fabricante") & " "
    end if
    if request("coditem") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " e.eq_codigobarras like '%"& trim(request("coditem")) &"%' "
    end if
    if request("instrumental") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " e.eq_instrumental = " & request("instrumental") &" "
    end if
    if request("propriedade") <> "" then
	    if w <> "" then w = w & " and "
	    w = w &" e.EQ_PROPRIEDADE IN ('" & request("propriedade") & "') "
    end if
    if request("conforme") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " e.eq_conforme = " & request("conforme") & " "
    end if
    if request("status") <> "" then
	    if w <> "" then w = w & " and "
	    w = w & " e.status = " & request("status") & " "
    else
	    if w <> "" then w = w & " and "
	    w = w & " e.status <> " & STATUS_EXPEDIDO & " AND e.status <> " & STATUS_EXPEDIDO_SUBST & " "  '-- nao pego itens os expedidos
    end if

    if w <> "" then s = s & " where " & w
    s = s & "order by e.eq_codigobarras"

    'response.write "aqui: " & request("propriedade") & " / " & request("propriedade1") & "<BR><BR>"
    response.write  "<!--SQL: " & s & " -->"
    'response.end

    Set objRS = Env.oconn.execute(s)
%>
<script type="text/javascript">
    var total_linhas = 0;
    var checkedAll = false;
    function checkAll() {
	    var f = document.forms[0]; var i;
	    var undef;
	    checkedAll = !checkedAll;
	    for(i=1; i<=total_linhas; i++)
		    f["eq_id_"+i].checked = checkedAll;
    }
</script>

<form name="formulario">
<table width="100%" border="0" class="texto1">
<tr>
	<td>
		<!--<div style="width: 100%; height: 200; overflow: auto; border: thin silver solid;">-->
		<table class="texto1" width="100%" border="1" cellpadding="2" cellspacing="0" style="border: thin silver solid;">
		<tr valign="top">
			<th><a href="#" onClick="javascript:checkAll();"><img src="img/checked.gif" border="0"></a></th>
			<th align="left">C&oacute;digo de Barras</th>
			<th align="left">Modelo</th>
			<th align="left">Descri&ccedil;&atilde;o</th>
			<!--<th align="left">Localiza&ccedil;&atilde;o</th>-->
			<th align="left">Num. S&eacute;rie</th>
			<th>Fabricante</th>
			<th>Status</th>
			<!--<th>Instr.</th>-->
			<th>Conforme</th><%
'if request("notafiscal") <> "" or request("fornecedor") <> "" then%>
			<th>NF</th><%
'end if%>
		</tr>
		<tbody><%
if objRS.eof and objRS.Bof then%>
		<tr><td colspan="9<%'if request("notafiscal") <> "" or request("fornecedor") <> "" then response.write "10" else response.write "9"%>" align="center" class="texto1">Nenhum equipamento encontrado !</td></tr><%
else
	linha = 1
	while not objRS.eof
		reservado = Trim(Sce.VerificaReservaItem(false, request("ag_numero"), objRS("EQ_ID"), true))%>
		<tr valign="top" id="<%="linha_"&linha%>" class="<%if linha mod 2 = 0 then response.write "linha_par" else response.write "linha_impar"%>" <%if reservado <> "&nbsp;" then response.write "style='color: red;'"%>>
			<td id="<%="linha_"&linha&"_col_1"%>" align="center"><input type="Checkbox" name="eq_id_<%=linha%>" value="<%=objRS("EQ_ID")%>" onClick="avisoReserva('<%if reservado <> "&nbsp;" then response.write reservado%>', this.checked);"></td>
			<td id="<%="linha_"&linha&"_col_2"%>"><%if isNull(objRS("EQ_CODIGOBARRAS")) then response.write "&nbsp;" else response.write objRS("EQ_CODIGOBARRAS")%></td>
			<td id="<%="linha_"&linha&"_col_3"%>"><%if isNull(objRS("MOD_CODNOME")) then response.write "&nbsp;" else response.write objRS("MOD_CODNOME")%></td>
			<td id="<%="linha_"&linha&"_col_4"%>"><%if isNull(objRS("MOD_DESCRICAO")) then response.write "&nbsp;" else response.write objRS("MOD_DESCRICAO")%></td>
<!--			<td id="<%'="linha_"&linha&"_col_5"%>"><%'if isNull(objRS("EQ_LOCALIZACAO")) then response.write "&nbsp;" else response.write objRS("EQ_LOCALIZACAO")%></td>-->
			<td id="<%="linha_"&linha&"_col_5"%>"><%if isNull(objRS("EQ_NUMEROSERIE")) then response.write "&nbsp;" else response.write objRS("EQ_NUMEROSERIE")%></td>
			<td id="<%="linha_"&linha&"_col_6"%>"><%if isNull(objRS("FAB_NOME")) then response.write "&nbsp;" else response.write objRS("FAB_NOME")%></td>
			<td id="<%="linha_"&linha&"_col_7"%>" align="center">
				<%=Sce.ImprimeStatusItem(objRS)%>
			</td>
<!--			<td id="<%'="linha_"&linha&"_col_8"%>" align="center"><%'=SimNao(objRS("EQ_INSTRUMENTAL"))%></td>-->
			<td id="<%="linha_"&linha&"_col_8"%>" align="center"><%=SimNao(objRS("EQ_CONFORME"))%></td>

<%      listaNF = Sce.PegaNotaFiscalItem(objRS("EQ_ID")) %>

			<td id="<%="linha_"&linha&"_col_9"%>"><%=IIf(listaNF = "", "&nbsp;", listaNF)%></td>
		</tr>
<%		if reservado <> "&nbsp;" then%>
		<tr style="color: red;">
			<td>&nbsp;</td>
			<td colspan="7"><b>Reservas AG:</b> <%=Replace(Replace(reservado, " ", ""), ",", "<br>")%></td>
		</tr>

<%		end if
		objRS.MoveNext
		linha = linha + 1
	wend%>
		</tbody>
		<script language="JavaScript">total_linhas = <%=linha-1%></script><%
end if%>
		</table>
		<!--</div>-->
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td align="center">
		<input type="Button" value=" Incluir " class="texto1" onClick="javascript:IncluiListaItens();">
		&nbsp;&nbsp;&nbsp;
		<input type="Button" value=" Voltar " class="texto1" onClick="javascript:window.close();">
	</td>
</tr>
</table>

<script type="text/javascript">
    var w = window.opener;
    /* verifica se ja existe o equipamento na lista */
    function ExisteItemLista(eq_id) {
	    var linha = 1;
	    while (w.document.all["linha_"+linha] != null) {
		    if(w.document.all["item_"+linha].eq_id == eq_id)
			    return true;
		    linha++;
	    }
	    return false;
    }

    /* inclui o item na janela pai */
    function IncluiListaItens()
    {
	    var f = document.all;
	    var i = 1, linha = 1;
	    linha = 0;
	    for(i=1; i <= total_linhas; i++) {
		    if( f["eq_id_"+i].checked ) {
			    if(ExisteItemLista(f["eq_id_"+i].value) ) 
			    //{
				    alert("O item " + f['linha_' + i + '_col_2'].innerText + ' já existe na lista !');
			    //}
			    //else {
				    /* insere o item e pega o numero da linha inserida na janela pai */
				    linha = w.InsereItem(1);

				    w.document.all["item_"+linha].eq_id = f["eq_id_"+i].value; // equip ID
				    w.document.all["item_"+linha].value = f["linha_"+(i)+"_col_2"].innerText; //cod barras
				    w.document.all["linha_"+linha+"_col_2"].innerText = f["linha_"+(i)+"_col_3"].innerText + ' <==> ' + f["linha_"+(i)+"_col_4"].innerText; //cod barras
			    //}
			    f["eq_id_"+i].disabled = true; f["eq_id_"+i].checked = false;
		    }
	    }
    }
    function avisoReserva(reservado, valor) {
	    if( (reservado != "") && (valor) )
		    alert("ATENÇÂO !\n\nEste item já está reservado.\n\nReserva(s): " + reservado);
    }
</script>

</form>
<br>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>