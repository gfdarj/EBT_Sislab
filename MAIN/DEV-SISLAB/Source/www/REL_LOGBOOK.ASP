<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<script>
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
<style>
.celula
{        
	BORDER-TOP: black thin inset; 
}
</style> 
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de LOGBOOK - Quadro de Registros (OPM / AM, AC e AP) em Ocorrências", "", "")

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
	call Env.RecordSet( true, objSiteRS, sSQL)
	IF not ObjSiteRS.EOF then
	%>
	<table width="100%" cellspacing="0" border="1">
		<tr>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">N&deg; OC</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Estado</font>
		</td>

		<td class="celula"  valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Ocorrência</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Rat</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Criticidade</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Data<br>Conclus&atilde;o Prevista</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Data<br>Conclus&atilde;o</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Tipo Ocorrência</font>
		</td>
		<td class="celula" valign="baseline" align="center">
			<font face="verdana" color="#000000" class="FontMenu1">Análise</font>
		</td></tr>
		<%while not objSiteRS.EOF 
			cor = ""
			if DATEADD("D",CDATE(ObjSiteRS("LB_DataHoraOco")),"0" & ObjSiteRS("LB_PRAZO")) < date and ObjSiteRS("LB_CONCLUIDOGQ") = false then _
			cor = "#EFD0D0"
			if ObjSiteRS("LB_CONCLUIDOGQ") = true then _
				estado = "Concluido"

			if ObjSiteRS("LB_CONCLUIDOGQ") = false and ObjSiteRS("LB_RATRESPONSAVEL") & "" <> "" then _
				estado = "Em Análise"

			if ObjSiteRS("LB_CONCLUIDOGQ") = false and ObjSiteRS("LB_RATRESPONSAVEL") & "" = "" then _
				estado = "Novo"

		%>
			<tr bgcolor="<%=cor%>">
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><a href="CAD_evLogBook.asp?ocorrencia=<%=ObjSiteRS("LB_ID")%>"><%=ObjSiteRS("LB_ID")%></a>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%=estado%>&nbsp;</font>
			</td>
			<td class="celula"  valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS("LB_Descricao")%>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS("LB_RATRESPONSAVEL")%>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%
				select case ObjSiteRS("LB_CRITICIDADE")
				case "1"
					response.write "baixa"
				case "2" 
					response.write "media"
				case "3"
					response.write "alta"
				end select
				%>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"> <%=DATEADD("D",CDATE(ObjSiteRS("LB_DataHoraOco")),"0" & ObjSiteRS("LB_PRAZO"))%>&nbsp;</font>
			</td>
			<%
			DATAfIM = day(ObjSiteRS("LB_DATAHORACONCLUSAO")) & "/" & month(ObjSiteRS("LB_DATAHORACONCLUSAO")) & "/" & year(ObjSiteRS("LB_DATAHORACONCLUSAO"))
			IF DATAfIM = "//" THEN DATAfIM = ""%>
			
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"> <%=DATAfIM%>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS("LBTO_DESCRICAO")%>&nbsp;</font>
			</td>
			<td class="celula" valign="baseline" align="center">
				<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS("LB_ANALISEGQ")%>&nbsp;</font>
			</td></tr>
		<%
			sSQL = "SELECT *, CASE (SELECT COUNT(*) FROM LB_ACOESTOMADAS_ARQUIVOS lbaa WHERE lbaa.ACT_ID = a.ACT_ID) WHEN 0 THEN 'F' ELSE 'T' END AS TEM_ARQUIVO from lb_acoestomadas a INNER JOIN LB_TIPOACAOTOMADA ta ON a.ACT_TIPOACAO = ta.TAT_ID Where act_lb =" & ObjSiteRS("lb_id")
			call Env.RecordSet( true, objSiteRS2, sSQL)
			IF not ObjSiteRS2.EOF then%>
				<tr>
				<td class="celula" valign="baseline" align="center" bgcolor="#ffffff"></td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" width="80px">
					<font face="verdana" color="#ffffff" class="FontMenu1">Tipo da Ação</font>
				</td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" colspan="2">
					<font face="verdana" color="#ffffff" class="FontMenu1">Descrição</font>
				</td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" width="100px">
					<font face="verdana" color="#ffffff" class="FontMenu1">Executante</font>
				</td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" colspan="1" width="90px">
					<font face="verdana" color="#ffffff" class="FontMenu1">Prazo Previsto<br>Conclus&atilde;o</font>
				</td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" colspan="1" width="90px">
					<font face="verdana" color="#ffffff" class="FontMenu1">Data<br>Conclus&atilde;o</font>
				</td>
				<td class="celula" valign="baseline" align="center" bgcolor="#b1b1b1" colspan="2">
					<font face="verdana" color="#ffffff" class="FontMenu1">Acompanhamento</font>
				</td>

<%				while not objSiteRS2.EOF%>
					<tr bgcolor="<%=cor%>">
					<td class="celula" valign="baseline" align="center" bgcolor="#ffffff"></td>
					<td class="celula" valign="baseline" align="center">
						<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS2("tAT_descricao")%></font>
					</td>
					<td class="celula" valign="baseline" align="center" colspan="2">
						<font face="verdana" color="#000000" class="FontMenu1">
<%
					If ObjSiteRS2("tem_arquivo") = "T" Then
						Response.Write "<a href='#' title='Clique aqui para visualizar os arquivos' onclick='abreArquivo(" & ObjSiteRS("LB_ID") & ", " & ObjSiteRS2("ACT_ID") & ")'><img src='img/icnote.gif' title='Esta ocorrência possui arquivo(s) anexo(s)' border='0'></a>&nbsp;&nbsp;"
					End If
					Response.Write ObjSiteRS2("act_descricao")
%>
						</font>
					</td>				
					<td class="celula" valign="baseline" align="center">
						<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS2("act_executante")%></font>
					</td>
					<td class="celula" valign="baseline" align="center" colspan="1">
						<font face="verdana" color="#000000" class="FontMenu1"><%=ObjSiteRS2("ACT_PRAZO")%></font>
					</td>
					<td class="celula" valign="baseline" align="center" colspan="1">
						<font face="verdana" color="#000000" class="FontMenu1"><%if isnull(ObjSiteRS2("ACT_DATACONCLUSAO")) then response.write "&nbsp;" else response.write ObjSiteRS2("ACT_DATACONCLUSAO")%></font>
					</td>
					<td class="celula" valign="baseline" align="center" colspan="2">
						<font face="verdana" color="#000000" class="FontMenu1"><%if isnull(ObjSiteRS2("act_obs")) then response.write "&nbsp;" else response.write ObjSiteRS2("act_obs")%></font>
					</td>				
				<%objSiteRS2.movenext
				wend
			END IF
			objSiteRS.movenext
		wend%>
	<%else%>
	<br>
	<table width="100%" cellspacing="0" border="0">
	<tr>
		<td colspan="4" align="center">
			<font class="texto1"><i><b>Nenhum resultado foi encontrado neste período.</b></i></font>
		</td>
	</tr>		
<%	end if
set objSiteRS = Nothing
%>

</table>
<form name="sel" action="ficha_oc.asp" method="post">
<input type="hidden" name="selecao">
</form>

<%
Call Tela.MostraRodape()
%>