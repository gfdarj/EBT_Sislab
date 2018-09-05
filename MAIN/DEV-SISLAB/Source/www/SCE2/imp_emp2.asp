<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/estado.asp"-->
<!--#include file="includes/montacnpj.inc" -->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Empresa" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()

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
    Env.oConn.CursorLocation = 3    '<---- mudei para fazer funcionar a paginacao !
    rec.pagesize = 20
    rec.CacheSize = 20
    set rec = Env.oconn.execute(Ssql)
    if not rec.eof then
	    set rec = Env.oconn.execute(ssql)
	    size = request("inicio")
	    if size = "" then size = 1
	    rec.AbsolutePage = size
	    cont = 0
	    if size <> 1 then rec.movenext
    end if
%>
<table width="100%" class="texto1">
	<tr>
	    <td class="texto1">
			<table width="100%" class="texto1" cellpadding="0" cellspacing="0">
			<%if not rec.eof then%>
				<tr>
					<th width="200" align="left">Empresa</th>
					<th width="2" align="left"></td>
					<th width="140" align="left">CNPJ</th>
					<th width="2" align="left"></td>
					<th width="70" align="left">I.E.</th>
					<th width="2" align="left"></th>
					<th width="10" align="left">UF</th>
					<th width="2" align="left"></th>
					<th width="100" align="left">Cidade</th>
					<th width="2" align="left"></th>
					<th width="250" align="left">Endereço</th>
			    </tr>
			<%while (not rec.eof) and (cont <= rec.pagesize)
				cont = cont+1
				if (cont mod 2) = 0 then 
					bg = 1
				else
					bg = 0
				end if%>
				<tr  <%if bg = 1 then%>bgcolor="#C0E0EF"<%end if%>>
					<td class="texto1"><a href="alt_empresas.asp?enf_id=<%=rec("enf_id")%>"><%=rec("enf_nome")%></a>&nbsp;</td>
					<td class="texto1" width="2"></td>										
					<td class="texto1"><%=montacnpj(rec("enf_cnpj"))%>&nbsp;</td>
					<td class="texto1" width="2"></td>										
					<td class="texto1"><%=rec("enf_ie")%>&nbsp;</td>
					<td class="texto1" width="2"></td>										
					<td class="texto1"><%=retestado(rec("enf_uf"))%>&nbsp;</td>
					<td class="texto1" width="2"></td>										
					<td class="texto1"><%=rec("enf_cidade")%>&nbsp;</td>
					<td class="texto1" width="2"></td>										
					<td class="texto1"><%=rec("enf_endereco")%>&nbsp;</td>
			    </tr>
				<%rec.movenext
			wend
			else%>
				<tr>
					<td class="texto1" align="center"><strong>Nenhuma Empresa cadastrada com esses parâmetros</strong></td>
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
					<button onclick="window.print();" class="texto1">Imprimir</button></div>
		</td>
	</tr>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>