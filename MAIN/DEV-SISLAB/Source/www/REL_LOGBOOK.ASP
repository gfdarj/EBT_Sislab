<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->

<script type="text/javascript">
    function chama_oc(cod_oc)
    {
        sel.selecao.value=cod_oc;
	    sel.submit();
    }
    function abreArquivo(oc, selecao){
	    var janela;
	    janela = window.open('rel_ativ_arquivos.asp?oc=' + oc + '&selecao=' + selecao, '', 'width=400,height=250,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	    janela.focus();
    }
</script>

<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de LOGBOOK - Quadro de Registros (OPM / AM, AC e AP) em Ocorrências", "", "")
%>
<div class="margem-10">
<%
Dim sSQL, objSiteRS, TipoRes, objConn

dim cWhere:cWhere = " where lb_id=lb_id "

if request("criticidade") <> "" then _
	cWhere = cWhere & " and lb_criticidade = " & request("criticidade")

if request("desc") <> "" then _
	cWhere = cWhere & " and LB_Descricao like '%" & request("desc") & "%'"

if request("ocorrencia") <> "" then _
	cWhere = cWhere & " and LB_ID = " & request("ocorrencia")

if request("rat") <> "" then _
	cWhere = cWhere & " and lb_ratresponsavel = '" & request("rat") & "'"

if request("responsavel") <> "" then _
	cWhere = cWhere & " and lb_respexec = '" & request("responsavel") & "'"

if request("tipoOcorrencia") <> "" then _
	cWhere = cWhere & " and l.lbto_id = " & request("tipoOcorrencia")

if request("cadastrante") <> "" then _
	cWhere = cWhere & " and lb_usernamecad = '" & request("cadastrante") & "'"

if request("chkAI") = "on" then _
	cWhere = cWhere & " and (SELECT COUNT(ACT_ID) FROM LB_ACOESTOMADAS WHERE ACT_TIPOACAO = 1 AND ACT_LB = LB_ID) > 0"

if request("chkAC") = "on" then _
	cWhere = cWhere & " and (SELECT COUNT(ACT_ID) FROM LB_ACOESTOMADAS WHERE ACT_TIPOACAO = 2 AND ACT_LB = LB_ID) > 0"

if request("chkAP") = "on" then _
	cWhere = cWhere & " and (SELECT COUNT(ACT_ID) FROM LB_ACOESTOMADAS WHERE ACT_TIPOACAO = 3 AND ACT_LB = LB_ID) > 0"

if request("chkAM") = "on" then _
	cWhere = cWhere & " and (SELECT COUNT(ACT_ID) FROM LB_ACOESTOMADAS WHERE ACT_TIPOACAO = 4 AND ACT_LB = LB_ID) > 0"

if request("chkOPM") = "on" then _
	cWhere = cWhere & " and LB_OPM =1"

if request("chkOcVencida") = "on" then _
	cWhere = cWhere & " and DATEADD(day,LB_PRAZO,LB_DATAHORACAD) < getdate()"

if request("estado") <> "" then 
	SELECT CASE REQUEST("ESTADO")
		CASE "NO"
			cWhere = cWhere & " AND (LB_CONCLUIDOGQ = 0) AND (LB_RATRESPONSAVEL IS NULL) "
		CASE "EA"
			cWhere = cWhere & " and (LB_CONCLUIDOGQ = 0) AND (NOT LB_RATRESPONSAVEL IS NULL) "
		CASE "C"
			cWhere = cWhere & " and (LB_CONCLUIDOGQ = 1) "
	END SELECT
end if

dataIniCad = request("diadataIniCad") & "/" & request("mesdataIniCad") & "/" & request("anodataIniCad")
dataFimCad = request("diadataFimCad") & "/" & request("mesdataFimCad") & "/" & request("anodataFimCad")

if dataIniCad <> "//" then _
	cWhere = cWhere & " and lb_datahoraoco > CONVERT(SMALLDATETIME,'" & dataIniCad & "',103) "

if dataFimCad <> "//" then _
	cWhere = cWhere & " and lb_datahoraoco < (CONVERT(SMALLDATETIME,'" & dataFimCad & "',103)+1) "

sSQL = "SELECT * from lb_logbook l left join lb_tipoocorrencia t on l.lbto_id=t.lbto_id " &  cWhere & " ORDER BY LB_ID DESC"
Call Env.RecordSet( true, objSiteRS, sSQL)

If Not ObjSiteRS.EOF Then
	%>
	<table border="1" style="width: 100%;" class="table-condensed">
	<tr>
		<th style="text-align: center; vertical-align:middle;">N&deg; OC</th>
		<th style="text-align: center; vertical-align:middle;">Estado</th>
		<th style="text-align: center; vertical-align:middle;">Ocorrência</th>
		<th style="text-align: center; vertical-align:middle;">Rat</th>
		<th style="text-align: center; vertical-align:middle;">Criticidade</th>
		<th style="text-align: center; vertical-align:middle;">Data<br>Conclus&atilde;o Prevista</th>
		<th style="text-align: center; vertical-align:middle;">Data<br>Conclus&atilde;o</th>
		<th style="text-align: center; vertical-align:middle;">Tipo Ocorrência</th>
		<th style="text-align: center; vertical-align:middle;">Análise</th>
	</tr>
<%  While Not objSiteRS.EOF 
        cor = ""
	    if DATEADD("D",CDATE(ObjSiteRS("LB_DataHoraOco")),"0" & ObjSiteRS("LB_PRAZO")) < date and ObjSiteRS("LB_CONCLUIDOGQ") = false then _
		    cor = "destaque atraso"

	    if ObjSiteRS("LB_CONCLUIDOGQ") = true then _
		    estado = "Concluido"

	    if ObjSiteRS("LB_CONCLUIDOGQ") = false and ObjSiteRS("LB_RATRESPONSAVEL") & "" <> "" then _
		    estado = "Em Análise"

	    if ObjSiteRS("LB_CONCLUIDOGQ") = false and ObjSiteRS("LB_RATRESPONSAVEL") & "" = "" then _
		    estado = "Novo"
		%>
	<tr class="<%=cor%>">
		<td style="text-align: center; vertical-align: top;">
			<a href="CadEvLogBook.asp?ocorrencia=<%=ObjSiteRS("LB_ID")%>"><%=ObjSiteRS("LB_ID")%></a>&nbsp;
		</td>
		<td style="text-align: center; vertical-align:top;">
			<%=estado%>&nbsp;
		</td>
		<td style="text-align: justify; vertical-align:top;">
			<%=ObjSiteRS("LB_Descricao")%>&nbsp;
		</td>
		<td style="text-align: center; vertical-align:top;">
			<%=ObjSiteRS("LB_RATRESPONSAVEL")%>&nbsp;
		</td>
		<td style="text-align: center; vertical-align:top;">
<%
        Select Case ObjSiteRS("LB_CRITICIDADE")
        Case "1"
	        response.write "<span class='text-success'>Baixa</span>"
        Case "2" 
	        response.write "<span class='text-warning'>Média</span>"
        Case "3"
	        response.write "<span class='text-danger'>Alta</span>"
        End Select
%>&nbsp;
		</td>
		<td style="text-align: center; vertical-align: top;">
				<%=DATEADD("D",CDATE(ObjSiteRS("LB_DataHoraOco")),"0" & ObjSiteRS("LB_PRAZO"))%>&nbsp;
		</td>
<%
		DATAfIM = day(ObjSiteRS("LB_DATAHORACONCLUSAO")) & "/" & month(ObjSiteRS("LB_DATAHORACONCLUSAO")) & "/" & year(ObjSiteRS("LB_DATAHORACONCLUSAO"))
		IF DATAfIM = "//" THEN DATAfIM = ""%>
			
		<td style="text-align: center; vertical-align: top;">
				<%=DATAfIM%>&nbsp;
		</td>
		<td  valign="baseline" align="center">
			<%=ObjSiteRS("LBTO_DESCRICAO")%>&nbsp;
		</td>
		<td  valign="baseline" align="center">
			<%=ObjSiteRS("LB_ANALISEGQ")%>&nbsp;
		</td>
	</tr>
<%
		sSQL = "SELECT *, CASE (SELECT COUNT(*) FROM LB_ACOESTOMADAS_ARQUIVOS lbaa WHERE lbaa.ACT_ID = a.ACT_ID) WHEN 0 THEN 'F' ELSE 'T' END AS TEM_ARQUIVO from lb_acoestomadas a INNER JOIN LB_TIPOACAOTOMADA ta ON a.ACT_TIPOACAO = ta.TAT_ID Where act_lb =" & ObjSiteRS("lb_id")
		call Env.RecordSet( true, objSiteRS2, sSQL)
		IF Not ObjSiteRS2.EOF then %>
    <tr>
	    <th style="text-align: center; vertical-align:middle;" ></th>
	    <th style="text-align: center; vertical-align:middle; width: 80px;" class="destaque titulo">Tipo da Ação</th>
	    <th style="text-align: center; vertical-align:middle;" class="destaque titulo" colspan="2">Descrição</th>
	    <th style="text-align: center; vertical-align:middle; width: 100px;" class="destaque titulo">Executante</th>
	    <th style="text-align: center; vertical-align:middle; width: 90px;" class="destaque titulo" colspan="1">Prazo Previsto<br>Conclus&atilde;o</th>
	    <th style="text-align: center; vertical-align:middle; width: 90px;" class="destaque titulo" colspan="1">Data<br>Conclus&atilde;o</th>
	    <th style="text-align: center; vertical-align:middle;" class="destaque titulo" colspan="2">Acompanhamento</th>
    </tr>
<%          While Not objSiteRS2.EOF%>
	<tr style="background-color: <%=cor%>;">
	    <td style="text-align: center; vertical-align: top;"></td>
	    <td style="text-align: center; vertical-align: top;"><%=ObjSiteRS2("tAT_descricao")%></td>
	    <td style="text-align: justify; vertical-align: top;" colspan="2">
<%
					If ObjSiteRS2("tem_arquivo") = "T" Then
						'Response.Write "<a href='#' title='Clique aqui para visualizar os arquivos' onclick='abreArquivo(" & ObjSiteRS("LB_ID") & ", " & ObjSiteRS2("ACT_ID") & ")'><img src='img/icnote.gif' title='Esta ocorrência possui arquivo(s) anexo(s)' border='0'></a>&nbsp;&nbsp;"
						Response.Write "<a href='#' title='Clique aqui para visualizar os arquivos' onclick='abreArquivo(" & ObjSiteRS("LB_ID") & ", " & ObjSiteRS2("ACT_ID") & ")'><span class='glyphicon glyphicon-paperclip' title='Este agendamento possui arquivo(s) anexo(s)' style='color: darkblue;'></span></a>&nbsp;&nbsp;"
    
					End If
					Response.Write ObjSiteRS2("act_descricao")
%>
        </td>				
		<td style="text-align: center; vertical-align: top;"><%=ObjSiteRS2("act_executante")%></td>
        <td style="text-align: center; vertical-align: top;" colspan="1"><%=ObjSiteRS2("ACT_PRAZO")%></td>
        <td style="text-align: center; vertical-align: top;" colspan="1">
<%              if isnull(ObjSiteRS2("ACT_DATACONCLUSAO")) then response.write "&nbsp;" else response.write ObjSiteRS2("ACT_DATACONCLUSAO") %>
        </td>
		<td style="text-align: justify; vertical-align: top;" colspan="2">
<%              if isnull(ObjSiteRS2("act_obs")) then response.write "&nbsp;" Else response.Write "<small>" & Replace(ObjSiteRS2("act_obs"), VbCrLf, "<br />") & "</small>"%>
		</td>
    </tr>
<%              objSiteRS2.movenext
			WEnd
		End If

	    objSiteRS.movenext
	WEnd%>
<%
Else %>

    <br />

	<table style="width: 100%;">
	<tr>
		<td colspan="4" style="text-align: center;">
			<i><b>Nenhum resultado foi encontrado neste período.</b></i>
		</td>
	</tr>
<%
End If

Set objSiteRS = Nothing
%>
    </table>

    <br />

    <form name="sel" action="ficha_oc.asp" method="post">
        <input type="hidden" name="selecao">
    </form>
</div>

<%
Call Tela.MostraRodape()
%>