<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Server.ScriptTimeout = 10000

    Call Tela.ImprimeMenuSce()

    ssql =	"select nf.NF_VALORTOTAL AS [NF_VALORTOTAL_M], nf.NF_DEVOLUCAOCOMPLETA AS [NF_DEVOLUCAOCOMPLETA_M], " & _
		    "nf.nf_id, nf.nf_numeronota AS [NF_NUMERONOTA_M], nf.nf_cfop AS [NF_CFOP_M], " & _
		    "nf.nf_validade AS [NF_VALIDADE_M], no.NO_DESCRICAO AS [NO_DESCRICAO_M], " & _
		    "CASE WHEN NF_TIPO = 1 THEN 'Entrada' WHEN NF_TIPO = 2 THEN 'Saída' END AS NF_TIPONOTA_M, " & _
		    "CONVERT(varchar, nf.nf_dataemissao, 103) AS NF_DATAEMISSAO_M, " & _
		    "CONVERT(varchar, nf.nf_recebimento, 103) AS NF_RECEBIMENTO_M, emp.enf_nome AS ENF_NOME_M, " & _
		    "CASE WHEN nf.NF_VALIDADE IS NULL THEN NULL ELSE CONVERT(varchar, nf.nf_dataemissao + CAST(nf.nf_validade AS INT), 103) END AS NF_DATAVENCIMENTO_M, " & _
		    "(SELECT nn1.NF_NUMERONOTA FROM SCE_Nota_Fiscal nn1 WHERE nn1.NF_ID = nf.nf_id_pai) AS NF_NUMERONOTA_PAI_M " & _
		    "from sce_nota_fiscal nf left join " & _
		    "sce_empresa_nota_fiscal emp on nf.enf_id = emp.enf_id " & _
		    "left join sce_natureza_operacao no on no.no_id = nf.no_id " & _
		    "where 1=1 "

    if request("pendentes") = "1" then
	    ssql = ssql & " and (NF_CARTA = 'P' or NF_ACEITE = 0) "
    end if

    '--pego as notas com prazo de validade, porém nao pego as 
    '--com devolucao completa = OK pois elas sao consideradas finalizadas
    if request("vencidas") = "1" then
	    ssql = ssql & " and (nf.nf_dataemissao + CAST(nf.nf_validade AS INT)) < getdate() AND no.PRAZO = 1 AND nf.NF_DEVOLUCAOCOMPLETA = 0 "
    end if
    if request("avencer") = "1" then
	    'ssql = ssql & " and ((nf.nf_dataemissao + CAST(nf.nf_validade AS INT)) BETWEEN getdate() AND getdate() + 21) AND no.PRAZO = 1 AND nf.NF_DEVOLUCAOCOMPLETA = 0 "
	    ssql = ssql & " and CAST( nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) > getdate() AND no.PRAZO = 1 AND nf.NF_DEVOLUCAOCOMPLETA = 0 "
	    'ssql = ssql & " and CAST( nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) IS NOT NULL "
    end if
    '--

    if request("nf_numeronota") <> "" then
	    ssql = ssql &" and nf.nf_numeronota like '"& request("nf_numeronota") &"' "
    end if
    if request("tiponota") <> "" then
	    ssql = ssql &" and nf.nf_tipo = " & request("tiponota") & " "
    end if
    'if request("nf_cfop") <> "" then
    '	ssql = ssql &" and nf.nf_cfop like '%"& request("nf_cfop") &"%' "
    'end if
    if request("diae_ini") <> "" and request("mese_ini") <> "" and request("anoe_ini") <> "" then
	    ssql = ssql &" and nf.nf_dataemissao BETWEEN CAST('" & _
		    request("anoe_ini") & "/" & request("mese_ini") &"/"& request("diae_ini") & _
		    " 00:00:00.001' AS DATETIME) AND "

	    if request("diae_fim") <> "" and request("mese_fim") <> "" and request("anoe_fim") <> "" then
		    ssql = ssql & "CAST('" & request("anoe_fim") & "/" & request("mese_fim") &"/"& request("diae_fim") & " 23:59:59' AS DATETIME) "
	    else
		    ssql = ssql & "GETDATE() "
	    end if
    end if
    if request("diar_ini") <> "" and request("mesr_ini") <> "" and request("anor_ini") <> "" then
	    ssql = ssql &" and nf.nf_recebimento BETWEEN CAST('" & _
		    request("anor_ini") & "/" & request("mesr_ini") &"/"& request("diar_ini") & _
		    " 00:00:00.001' AS DATETIME) AND "

	    if request("diar_fim") <> "" and request("mesr_fim") <> "" and request("anor_fim") <> "" then
		    ssql = ssql & "CAST('" & request("anor_fim") & "/" & request("mesr_fim") &"/"& request("diar_fim") & " 23:59:59' AS DATETIME) "
	    else
		    ssql = ssql & "GETDATE() "
	    end if
    end if
    if request("diaent_ini") <> "" and request("mesent_ini") <> "" and request("anoent_ini") <> "" then
	    ssql = ssql &" and nf.nf_recebimento BETWEEN CAST('" & _
		    request("anoent_ini") & "/" & request("mesent_ini") &"/"& request("diaent_ini") & _
		    " 00:00:00.001' AS DATETIME) AND "

	    if request("diaent_fim") <> "" and request("mesent_fim") <> "" and request("anoent_fim") <> "" then
		    ssql = ssql & "CAST('" & request("anoent_fim") & "/" & request("mesent_fim") &"/"& request("diaent_fim") & " 23:59:59' AS DATETIME) "
	    else
		    ssql = ssql & "GETDATE() "
	    end if
    end if

    if request("enf_id") <> "" then
	    ssql = ssql &" and nf.enf_id = "& request("enf_id") & " "
    end if
    if request("no_id") <> "" then
	    ssql = ssql &" and no.no_id = "& request("no_id") & " "
    end if

    'if request("pendentes") = "1" or request("vencidas") = "1" or request("avencer") = "1" then
    '	ssql = ssql & " ORDER BY CAST(nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) ASC, enf_nome ASC, nf_numeronota ASC"
    'else
    '	ssql = ssql & " ORDER BY enf_nome ASC, CAST(nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) ASC, nf_numeronota ASC"
    'end if

    If request("ordenacao") = "1" Then
	    ssql = ssql & " ORDER BY enf_nome ASC, CAST(nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) ASC, nf_numeronota ASC"
    ElseIf request("ordenacao") = "2" Then
	    ssql = ssql & " ORDER BY CAST(nf.nf_dataemissao + CAST(nf.nf_validade AS INT) AS DATETIME) ASC, enf_nome ASC, nf_numeronota ASC"
    Else
	    ssql = ssql & " ORDER BY nf_numeronota"
    End If

    'response.write ssql
    'response.end

    response.write "<!--" & ssql & " -->"

    Set rec = Env.oconn.execute(Ssql)

    titulo = ""
    if request("vencidas") = "1" then
	    titulo = " (Vencidas"
	    if request("pendentes") <> "1" and request("avencer") <> "1" then titulo = titulo & ")"
    end if
    if request("pendentes") = "1" then
	    if titulo <> "" then
		    titulo = titulo & "/ pendentes"
	    else
		    titulo = " (Pendentes"
		    if request("avencer") <> "1" then titulo = titulo & ")"
	    end if
    end if
    if request("avencer") = "1" then
	    if titulo <> "" then
		    titulo = titulo & "/ à vencer)"
	    else
		    titulo = " (À vencer)"
	    end if
    end if

	Dim url_xls
	url_xls = "<div align='right'><a href=""../excel.asp?TITULO=Relatório de Notas Fiscais" & titulo & "&SQL=" & Server.UrlEncode(ssql) & """ target='_blank' alt='Exporta esta listagem para o Excel'><font color='#008000'><b>XLS</b></font></a></div>"
%>
<div class="margem-10">

<table class="largura-total">
<tr>
	<th>Listagem de Notas Fiscais<%=titulo%></th>
	<th class="texto-direito"><%=url_xls%></th>
</tr>
</table>

<%    if not rec.eof then %>
<p><small>As notas em destaque (<span class="bg-danger">&nbsp;&nbsp;</span>) est&atilde;o com vencidas.</small></p>

<table class="largura-total table-condensed table-bordered table-striped table-hover">
	<tr>
		<th>Fornecedor</th>
		<th>Data de Emissão</th>
		<th>Data de Receb. / Expedição</th>
		<th>Número /<BR>Valor</th>
		<th>Natureza Opera&ccedil;&atilde;o</th>
		<th>Tipo</th>
		<th>Validade (dias)</th>
		<th>Data de Venc.</th>
		<th>NF Aquis.</th>
		<th>Dev. Tot.</th>
    </tr>
<%  	cont = 0
	    while (not rec.eof)
		    cont = cont+1
    		if (cont mod 2) = 0 then bg = 1 else bg = 0
%>
<!--	<tr <%'if bg = 0 then%>bgcolor="#C0E0EF"<%'end if%>> -->
	<tr <%if not IsNull(rec("nf_datavencimento_M")) then if cdate(rec("nf_datavencimento_M")) < date() and (rec("nf_devolucaocompleta_M") = 0) then response.write "class='bg-danger'" end if %>>
		<td ><%=ConverteNuloHTML(rec("enf_nome_M"))%>&nbsp;</td>
		<td class="texto-centralizado"><%=ConverteNuloHTML(rec("nf_dataemissao_M"))%></td>
		<td class="texto-centralizado"><%=ConverteNuloHTML(rec("nf_recebimento_M"))%></td>
		<td class="texto-centralizado">
<%	    		if Env.PerfilSce <> PERFIL_RAT then%>
			<a href=cad_nf.asp?nf_id=<%=rec("nf_id")%>>
<%	    		end if%>
			<%=ConverteNuloHTML(rec("nf_numeronota_M"))%>
<%	    		if Env.PerfilSce <> PERFIL_RAT then%>
			</a>
<%		    	end if%>
			
<%			    if Not IsNull(rec("NF_VALORTOTAL_M")) Then%>
			<BR><BR>R$ <%=trim(replace(cstr(FormatCurrency(rec("nf_valortotal_M"))), "R$", ""))%>
<%	    		Else%>
			&nbsp;
<%		    	End If %>
		</td>
		<td ><%=ConverteNuloHTML(rec("NO_DESCRICAO_M"))%></td>
		<td class="texto-centralizado"><%=Left(ConverteNuloHTML(rec("NF_TIPONOTA_M")), 1)%></td>
		<td class="texto-centralizado"><%=ConverteNuloHTML(rec("nf_validade_M"))%></td>
		<td class="texto-centralizado"><%=ConverteNuloHTML(rec("nf_datavencimento_M"))%></td>
		<td class="texto-centralizado"><%=ConverteNuloHTML(rec("nf_numeronota_PAI_M"))%></td>
		<td class="texto-centralizado">
<%
		'If Left(rec("NF_TIPONOTA"), 1) = "S" Then
			Response.Write SimNao(rec("NF_DEVOLUCAOCOMPLETA_M"))
		'Else
		'	Response.Write "&nbsp;"
		'End If
%>
		</td>
    </tr>
<%	    	rec.movenext
	    wend %>
</table>

    <p class="texto-direito"><small>Registros encontrados: <%=cont%></small></p>
<%  else %>
	<p class="texto-centralizado"><i>Nenhuma Nota Fiscal encontrada</i></p><%
    End if %>
</div>
<br />
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>