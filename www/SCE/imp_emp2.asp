<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<!-- #INCLUDE FILE="includes/montacnpj.inc" -->
<%
ssql = "select * from sce_empresa_nota_fiscal where 1=1 "

if trim(replace(request("enf_nome"), "'", chr(39))) <> "" then
	ssql = ssql &" and enf_nome like '%"& trim(replace(request("enf_nome"), "'","")) &"%' "
end if
if trim(replace(request("enf_cidade"), "'", chr(39))) <> "" then
	ssql = ssql &" and enf_cidade like '%"& trim(replace(request("enf_cidade"), "'", "")) &"%' "
end if
if trim(replace(request("enf_cnpj"), "'", "")) <> "" then
	ssql = ssql &" and enf_cnpj like '%"& trim(replace(request("enf_cnpj"), "'", "")) &"%' "
end if
if trim(replace(request("enf_ie"), "'", "")) <> "" then
	ssql = ssql &" and enf_ie like '%"& trim(replace(request("enf_ie"), "'", "")) &"%' "
end if
if request("enf_uf") <> "" then
	ssql = ssql &" and enf_uf = "& request("enf_uf") 
end if

ssql = ssql &" order by enf_nome"

set rec = createobject("adodb.recordset")
rec.cursortype = 3 
rec.pagesize = 20
set rec = conn.execute(Ssql)
if not rec.eof then
	set rec = conn.execute(ssql)
	size = request("inicio")
	if size = "" then size = 1
	rec.absolutepage = size
	cont = 0
	if size <> 1 then rec.movenext
end if

call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Empresas", "", "history.go(-1);")
%>
<table width="100%">
	<tr>
	    <td class="texto">
			<table width="100%">
			<%if not rec.eof then%>
				<tr>
					<td class="titulo" width="200">Empresa</td>
					<td class="titulo" width="2"></td>
					<td class="titulo" width="140">CNPJ</td>
					<td class="titulo" width="2"></td>
					<td class="titulo" width="70">I.E.</td>
					<td class="titulo" width="2"></td>
					<td class="titulo" width="10">UF</td>
					<td class="titulo" width="2"></td>
					<td class="titulo" width="100">Cidade</td>
					<td class="titulo" width="2"></td>
					<td class="titulo" width="250">Endereço</td>
			    </tr>
			<%while (not rec.eof) and (cont <= rec.pagesize)
				cont = cont+1
				if (cont mod 2) = 0 then 
					bg = 1
				else
					bg = 0
				end if%>
				<tr  <%if bg = 1 then%>bgcolor="#C0E0EF"<%end if%>>
					<td class="texto"><a href="alt_empresas.asp?enf_id=<%=rec("enf_id")%>"><%=rec("enf_nome")%></a>&nbsp;</td>
					<td class="titulo" width="2"></td>										
					<td class="texto"><%=montacnpj(rec("enf_cnpj"))%>&nbsp;</td>
					<td class="titulo" width="2"></td>										
					<td class="texto"><%=rec("enf_ie")%>&nbsp;</td>
					<td class="titulo" width="2"></td>										
					<td class="texto"><%=retestado(rec("enf_uf"))%>&nbsp;</td>
					<td class="titulo" width="2"></td>										
					<td class="texto"><%=rec("enf_cidade")%>&nbsp;</td>
					<td class="titulo" width="2"></td>										
					<td class="texto"><%=rec("enf_endereco")%>&nbsp;</td>
			    </tr>
				<%rec.movenext
			wend
			else%>
				<tr>
					<td class="texto" align="center"><strong>Nenhuma Empresa cadastrada com esses parâmetros</strong></td>
				</tr>
			<%end if%>
			</table>
			<br><br>
			<%for i = 1 to rec.pagecount
				if i = cint(size) then
					response.write "<strong>"&i&"</strong> "
				else%>
					<a href="imp_emp2.asp?inicio=<%=i%>&enf_nome=<%=request("enf_nome")%>&enf_cnpj=<%=request("enf_cnpj")%>&enf_ie=<%=request("enf_ie")%>&enf_cidade=<%=request("enf_cidade")%>&enf_uf=<%=request("enf_uf")%>"><%=i%>&nbsp;</a>
				<%end if
			next%><div align=right class=texto>
				Para Impressão, clique no botão "Imprimir" e configure a página para ser impressa no formato de Paisagem.&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="window.print();" class=form>Imprimir</button></div>
		</td>
	</tr>
</table>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>