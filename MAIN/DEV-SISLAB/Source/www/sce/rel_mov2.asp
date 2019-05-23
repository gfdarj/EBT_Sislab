<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Relatório > Movimentação de Item" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    'Call Tela.ImprimeMenuSce()

    '-- request("ssql") é utilizado na exclusao de um movimento, faz com que esta página seja
    '-- recarregada
    if trim(request("ssql")) = "" then

	    ssql = "SELECT a.eq_id, a.eq_codigobarras as [EQ_CODIGOBARRAS_M], d.ASA AS [AS_M], " & VbCrLf
	    ssql = ssql & "CONVERT(VARCHAR, d.MOV_DATA, 103) AS [DATA_M], " & VbCrLf
	    ssql = ssql & "LEFT(CONVERT(VARCHAR, d.MOV_DATA, 114),8) AS [HORA_M], " & VbCrLf
	    ssql = ssql & "d.MOV_ID, c.fab_nome AS [FAB_NOME_M], b.MOD_CODNOME AS [MOD_CODNOME_M], " & VbCrLf
	    ssql = ssql & "d.MOV_SOLICITANTE AS [MOV_SOLICITANTE_M], d.MOV_PASSAGEM, h.nf_numeronota AS [NF_NUMERONOTA_M], " & VbCrLf
	    ssql = ssql & "d.CDE AS [CDE_M], doc.DOC_ID AS [DOC_ID_M], no_descricao as [NO_DESCRICAO_M], d.FL_CALIBRACAO AS [FL_CALIBRACAO_M] " & VbCrLf
	    ssql = ssql & "FROM SCE_Equipamentos a " & VbCrLf
	    ssql = ssql & "  INNER JOIN SCE_Modelos b ON a.MOD_ID = b.MOD_ID " & VbCrLf
	    ssql = ssql & "  INNER JOIN SCE_Fabricantes c ON b.FAB_ID = c.fab_id " & VbCrLf
	    ssql = ssql & "  INNER JOIN SCE_Movimentacao d ON a.EQ_ID = d.EQ_ID " & VbCrLf
	    ssql = ssql & "  LEFT OUTER JOIN SCE_Natureza_Operacao f ON d.NO_ID = f.NO_ID " & VbCrLf
	    ssql = ssql & "  LEFT JOIN SCE_Nota_Fiscal h ON d.nf_id = h.nf_id " & VbCrLf
	    ssql = ssql & "  LEFT JOIN SCE_Documentacao doc ON doc.doc_id = d.doc_id " & VbCrLf

	    if request("enf_id") <> "" then
		    ssql = ssql &" and h.enf_id = " & request("enf_id") & VbCrLf
	    end if

	    If request("plataforma") <> "" Then
		    ssql = ssql &  "  INNER JOIN PLATAFORMA_EQUIPAMENTOS plat ON plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = a.EQ_ID " & VbCrLf
	    End If
'			    " AND EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
'			    "WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = a.EQ_ID) "


	    '-- estava como: d.RESERVA = 0 , como eu nao sabia o motivo e para nao alterar muito
	    '-- o codigo, entao coloquei este 1 = 1
	    ssql = ssql &" WHERE 1 = 1 "
	    if request("noid") <> "" then
		    ssql = ssql &" and f.no_id = "& request("noid")
	    end if
	    if request("documento") <> "" and isnumeric(request("documento")) then
		    ssql = ssql & " and d.doc_id = " & request("documento") & " "
	    end if
	    if request("codbarras") <> "" then
		    ssql = ssql &" and a.eq_codigobarras like '%"& request("codbarras") &"%'"
	    end if
	    if request("localizacao") <> "" then
		    ssql = ssql &" and a.eq_localizacao like '%"& request("localizacao") &"%'"
	    end if
	    if request("fabricante") <> "" then
		    ssql = ssql &" and  b.fab_id = "& request("fabricante")
	    end if
	    if request("modelo") <> "" then
		    ssql = ssql &" and b.mod_codnome like '%"& request("modelo") &"%'"
	    end if
	    if request("notafiscal") <> "" then
		    'ssql = ssql &" and RTRIM(LTRIM(h.nf_numeronota)) = '" & Trim(request("notafiscal")) & "' "
		    ssql = ssql &" and h.nf_numeronota like '"& request("notafiscal") &"'"
	    end if
	    if request("numeroserie") <> "" then
		    ssql = ssql &" and a.eq_numeroserie like '%"& request("notipo") &"%'"
	    end if
	    if request("asa") <> "" then
		    ssql = ssql &" and d.asa like '%"& request("asa") &"%'"
	    end if
	    if request("solicitante") <> "" then
		    ssql = ssql &" and d.mov_solicitante like '%"& request("solicitante") &"%'"
	    end if
	    if request("cde") <> "" then
		    ssql = ssql &" and LTRIM(RTRIM(d.CDE)) = '"& trim(request("cde")) & "' "
	    end if
	    if request("dia") <> "" and request("mes") <> "" and request("ano") <> "" then
		    data = request("dia") &"/"& request("mes") &"/"& request("ano")
		    ssql =	ssql &" and d.MOV_DATA between CONVERT(datetime, '"& data &"', 103) AND " & _
				    "CONVERT(datetime, '"& data &"', 103) + 1"
	    end if
	    ssql = ssql & " order by a.eq_codigobarras ASC, d.MOV_DATA DESC, d.mov_id desc"
    else
	    ssql = request("ssql")
    end if

    'response.write ssql
    'response.end

    Set rec = Env.oconn.execute(ssql)

    If Env.PerfilSce = PERFIL_ADM Then
%>
<script type="text/javascript">
    function alteraMovimentacao(mov_id) {
	    var d = document.forms[0];
	    d.mov_id.value = mov_id;
	    d.action = "sel_mov_acessorio.asp";
	    d.target = "_blank";
	    d.submit();
    }
    function excluiMovimentacao(mov_id) {
	    var d = document.forms[0];
	    if( confirm("Deseja realmente apagar este movimento ?" ) ) {
		    d.mov_id.value = mov_id;
		    d.action = "exc_mov.asp";
		    d.target = "";
		    d.submit();
	    }
    }
</script>

<div class="margem-10">
    <form name="formulario" action="sel_mov_acessorio.asp" method="post">
        <input type="hidden" name="mov_id" value="" />
        <input type="hidden" name="ssql" value="<%=ssql%>" />
    </form>
<%
end if

Dim url_xls
url_xls = "<div align='right'><a href=""../excel.asp?TITULO=Relatório de Movimentação de Item&SQL=" & Server.UrlEncode(ssql) & """ target='_blank' alt='Exporta esta listagem para o Excel'><font color='#008000'><b>XLS</b></font></a></div>"
%>
<table width="100%" cellpadding="2" cellspacing="0" >
<tr>
	<td>Listagem do relatório de movimentação de itens</td>
	<td align="right"><%=url_xls%></td>
</tr>
</table>
<BR>
<table class="largura-total table-condensed table-bordered table-striped table-hover">
<%
    if rec.eof and rec.bof then %>
	<tr><td class="texto-centralizado">Nenhum registro encontrado !</td></tr>
<%  else %>
	<tr>
<%	    if Env.PerfilSce = PERFIL_ADM then%>
		<th class="texto-centralizado">&nbsp;</th>
		<th class="texto-centralizado">&nbsp;</th>
<%	    end if%>
		<th class="texto-centralizado">Item</th>
		<th class="texto-centralizado">Modelo</th>
		<th class="texto-centralizado">Fabricante</th>
		<th class="texto-centralizado">AS</th>
		<th class="texto-centralizado">Solicitante</th>
		<th class="texto-centralizado">CDE</th>
		<th class="texto-centralizado">NF</th>
		<th class="texto-centralizado">Doc</th>
		<th class="texto-centralizado">Data de Movimentação (tipo)</th>
	</tr>
<%	    Dim bg, cont
	    cont = 0
	    while not rec.eof
		    cont = cont + 1
%>
	<tr>
<%		    if Env.PerfilSce = PERFIL_ADM then%>
		<td class="texto-centralizado">
            <a href="#" onClick="javascript:alteraMovimentacao(<%=rec("MOV_ID")%>);">
                <!--<img src="img/edit.gif" border="0" alt="Clique aqui para editar esta movimentação">-->
                <span class="glyphicon glyphicon-edit" style="color: darkblue;" title="Clique aqui para editar esta movimentação"></span>
            </a>
		</td>
		<td class="texto-centralizado">
            <a href="#" onClick="javascript:excluiMovimentacao(<%=rec("MOV_ID")%>);"><img src="img/btn_excluir.gif" border="0" alt="Clique aqui para apagar esta movimento"></a>
		</td>
<%		    end if%>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("eq_codigobarras_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("mod_codnome_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("fab_nome_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("as_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("mov_solicitante_M"))%>
			<%if rec("MOV_PASSAGEM") then response.write "&nbsp;<b>(*)</b>" end if%>
		</td>
		<td class="texto-centralizado <%=IIf(rec("FL_CALIBRACAO_M"), """ bg-danger"" title=""Envio para Calibração""", """")%>>
			<%=ConverteNuloHTML(rec("cde_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(rec("nf_numeronota_M"))%>
		</td>
		<td class="texto-centralizado">
			<%=Zeros(ConverteNuloHTML(rec("DOC_ID_M")),4)%>
		</td>
		<td class="texto-centralizado">
			<%=ConverteNuloHTML(ConcatenaDataHora(rec("data_M"), rec("hora_M")))%><br><small><%="("&ConverteNuloHTML(rec("no_descricao_M"))&")"%></small>
		</td>
	</tr>
<%		    rec.movenext

            If (cont mod 15) Then Response.Flush()
	    wend
    end if%>
    </table>
    <br />
    <p>
        <small>
            (*) Movimentação de passagem de carga<br />
            (**) Os CDE´s em <span class="bg-danger">marcados</span> indicam envio para calibração
        </small>
    </p>
    <br />
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
