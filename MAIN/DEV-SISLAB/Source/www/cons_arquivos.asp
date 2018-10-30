<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim objSiteRS, cont, sSQL,tot, auxidorgao, EhGQ,EHrat, EHRt, auxusername, i,objConn, EHCrt
Dim auxassunto, auxresponsavel, auxtipoarq,auxsitarq, contaFlush

auxusername = Env.NomeReduzido()
EH_CRT = Env.usuarioCRT()
EH_GQ = Env.ehGQ()
EHrat =  Env.ehRAT()
EHrt =  Env.ehRT()
contaFlush = 0

'---debug---
'eh_GQ = false
'EH_CRT = false
'EHRat = false
'EHrt = false

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Sistema de Gestão - Consulta de Arquivos"
Tela.SetLinkVoltar = "location.href='arq_disp.asp';"
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sistema de Gestão - Consulta de Arquivos", "", "")

auxsitarq = RQ("sitarquivo")
auxidorgao = RQ("orgao")
auxassunto = RQ("assunto")
auxresponsavel = RQ("responsavel") 

if request.form("tipoarquivo")<>"" Then
	auxtipoarq=cint(request.form("tipoarquivo"))
else
	auxtipoarq=0
end if
%>
<script type="text/javascript">
    function Valida(arquivo)
    {
	    frm = document.forms[0];
	    frm.action = "cad_arquivo.asp?ehValidacao=1&arquivos="+ arquivo;
	    frm.method = "post";
	    frm.submit();
    }
    function Historico(arquivo)
    {
	    strurl = "eventosinternos.asp?hdnEvento=8&arquivo="+ arquivo;
	    window.open(strurl,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=400,height=300,top=0,left=0');
    }

    function janelalink(link)
    {
        window.open(link,'','toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=no,copyhistory=no,width=800,height=600,top=0,left=0');
    }

    function janelaespecial(link1)
    {
        window.open(link1,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=no,width=800,height=600,top=0,left=0');
    }
</script>

<div class="margem-10">
<form method="post" action="cad_arquivo.asp">
<%
tot=0

'Crio um RecordSet para Montar Consulta
'Consulta de Todas os arquivos segundo filtros

sSQL = "Select * From vw_Consarq "
sSQL = sSQL & " WHERE ARQ_IDOrgao >= 0 "

if AuxIdOrgao<>0 then
  sSQL = sSQL & " AND ARQ_IDOrgao = " & auxIdorgao 
end if

if Auxtipoarq<>0 then
  sSQL = sSQL & " AND ARQ_CodArqTipo= " & auxtipoarq 
else
  'sSQL = sSQL & " AND ARQ_CodArqTipo <> 7 " 'Sem Laudo
end if

if AuxAssunto<>"" then
  sSQL = sSQL & " AND ARQ_Link Like '%" & auxAssunto & "%'" 
end if

if AuxResponsavel<>"" then
  sSQL = sSQL & " AND ARQ_responsavel='" & auxResponsavel & "'"
end if

If AuxSitArq <> "" then
	sSQL = sSQL & " AND arq_idSituacao=" & auxSitArq & ""
Else
	If Not EH_GQ Then
		If EH_CRT Or EHRat Or EHrt Then
			sSQL = sSQL & " AND arq_idSituacao IN (SELECT SAR_CodSitArquivo from SituacaoArquivo WHERE SAR_SitArquivo IN('Aprovado', 'Cancelado', 'Em consenso'))"
		Else
			sSQL = sSQL & " AND arq_idSituacao IN (SELECT SAR_CodSitArquivo from SituacaoArquivo WHERE SAR_SitArquivo IN('Aprovado'))"
		End If
	End If
End if

sSQL = sSQL & " ORDER BY ARQ_Link  DESC; "

'response.write ssql & " & " & eh_gq
'response.end

Call Env.RecordSet( true, objSiteRS, sSQL)

If Not objSiteRS.EOF Then%>
<table width="100%" class="table-bordered table-striped table-hover table-condensed" style="width: 100%;">
<tr>
	<th>Arquivo</th>
	<th width="12%" style="text-align: center;">Tipo</th>
	<th width="8%" style="text-align: center;">Situação</th>
	<th width="10%" style="text-align: center;">Data</td>
	<th width="10%" style="text-align: center;">Respons&aacute;vel</th>
	<th width="10%" style="text-align: center;">Expira em</td>
</tr>
<%
	Do while Not(objSiteRS.EOF)
		EXPIRADO = FALSE
		COR = "#E4EEEE"
		if objSiteRS("ARQ_DATAEXPIRACAO") <> "" and objSiteRS("arq_idSituacao") = 2 and objSiteRS("ARQ_CodArqTipo") <> 30 THEN
			IF CDATE(objSiteRS("ARQ_DATAEXPIRACAO")) < DATE() THEN
				COR = "#EFD0D0"
				EXPIRADO = TRUE
			END IF

			IF CDATE(objSiteRS("ARQ_DATAEXPIRACAO")) >  DATE() and objSiteRS("arq_idSituacao") = 2 and objSiteRS("ARQ_CodArqTipo") <> 30 THEN
				IF CDATE(objSiteRS("ARQ_DATAEXPIRACAO")) < DATEADD("m",1,DATE()) then
					COR = "YELLOW"
					EXPIRADO = TRUE
				END IF
			end if
		end if
%>
<tr>
    <td align="left">
        <B>
<!--
Parte do código que define se arquivos devem ou não ser exibidos de acordo com o usuario logado
-->
<%		if objSiteRS("ARQ_Ocultar") = TRUE then
			if EH_CRT = TRUE or objSiteRS("AG_RESPONSAVEL") = Env.usuario then%>
		    <a href="javascript:janelaespecial('arquivos/<%=Replace(objSiteRS("ARQ_NomeArq"), "\", "/")%>');"><%=objSiteRS("ARQ_Link")%></a>
<%		    Else%>
    		<%=objSiteRS("ARQ_Link")%>
	<%		End If
		Else %>
	    	<a href="javascript:janelaespecial('arquivos/<%=Replace(objSiteRS("ARQ_NomeArq"), "\", "/")%>');"><%=objSiteRS("ARQ_Link")%></a>
<%		End If%>
        </B>
    </td>

    <td align="center">
<%if objSiteRS("TAR_TipoArquivo") <> "" then  response.write objSiteRS("TAR_TipoArquivo") else response.write "N/A" end if%>
    </td>

    <td align="center">
<%if objSiteRS("SAR_SitArquivo") <> "" then 
        response.write "<span style='background-color: " & cor & "';>" & objSiteRS("SAR_SitArquivo") & "</span>"
  else
        response.write "N/A" 
  end if%>
    </td>

    <td align="center">
<%'=formataDatadisplay(objSiteRS("ARQ_DataAtualizacao"))%> 
	<%=objSiteRS("ARQ_DataAPROVACAO")%> 
	<% if objSiteRS("ARQ_DATAEXPIRACAO") <> ""  then %>
	<B></B><br> REV: <%=objSiteRS("ARQ_VERSAO")%> 
	<% end if%>
    </td>

    <td align="center">
    <%=objSiteRS("ARQ_responsavel")%>
    </td>

    <td align="center">
<%		If objSiteRS("ARQ_DATAEXPIRACAO") <> "" and objSiteRS("arq_idSituacao") = 2 and objSiteRS("ARQ_CodArqTipo") <> 30 then  
			response.write day(objSiteRS("ARQ_DATAEXPIRACAO")) & "/" & month(objSiteRS("ARQ_DATAEXPIRACAO")) & "/" & year(UCase(objSiteRS("ARQ_DATAEXPIRACAO")))
			If ((Env.ehRT or  Env.ehRAT or Env.ehGQ)) and expirado then
				response.write "<br><a href='javascript:Valida(" & objSiteRS("ARQ_codarq") & ")'><B>Validar</B></a>"
			End If
		Else
			response.write "N/A" 
		End If

		If CINT(objSiteRS("VALIDACAO")) > 0 and objSiteRS("ARQ_DATAEXPIRACAO") <> "" THEN
			response.write "<br><a href='javascript:Historico(" & objSiteRS("ARQ_codarq") & ")'><B>Historico</B></a>"
		End If
%>
    </td>
</tr>
<%		objSiteRS.movenext
        contaFlush = contaFlush + 1
        If contaFlush mod 30 Then
            Response.Flush
        End If
	Loop%>
</table>
<%
Else
%>
<br>
<p align="center">
<b>Nenhum arquivo foi encontrado com estes critérios de consulta.</b>
<br><br>
<input type="button" value="Voltar" class="texto1" onclick="javascript:history.go(-1);">
</p>
<%
End If
%>

<br />

<%  If Err then%>


<center>
<table width="450">
    <tr>
        <td>
            <center>
            Ocorreu algum erro no carregamento desta página.<br><br>
            Qualquer dúvida entre em contato com o CRT no Ramal 8297.
            </center>
        </td>
    </tr>
</table>
</form>
</left>

<%end if%>
</center>
</div>
<%
Call Tela.MostraRodape()
%>
