<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Movimentação de Consumivel", "", "history.go(-1);")

Response.write "<br><p class='texto'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Página em construção...</b></p>"
Response.end
%>
<form name="formulario" method="post" action="sel_mov_consumivel2.asp">
<input type="Hidden" name="busca" value="1">
  <table width="100%">
    <tr> 
		<td class="titulo">
		<div class="texto"><%if request("msg") <> "" then response.write " <strong><div align=center>Movimentação efetuada com sucesso.<br> Foi criado um histórico de movimentação com estes dados.</div></strong><br><br>"%></div>
	</td>
	</tr>
	 <tr>
		<td> 
      		<table border="0">
	  			<tr>
						<td class="texto" >
Localizacao:&nbsp;<input type="text" class="form" name="localizacao" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>
						<td class="texto" >
Descrição:&nbsp;<input type="text" class="form" name="descricao" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td class="texto" colspan="2"><br></td>
				</tr>
				<%ssql = "select * from sce_empresa_nota_fiscal order by enf_nome"
					set recenf = conn.execute(ssql)
					if not recenf.eof then%>
						<tr>
						<td class=texto>	
						Fornecedor				
							<select name=enf_id class=form>
							<option value="">Todos</option>
							<%while not recenf.eof%>
								<option value="<%=recenf("enf_id")%>"><%=recenf("enf_nome")%></option>
								<%recenf.movenext
							wend%>
							</select>
						</td>
						<td class="texto">
					Nota Fiscal:&nbsp;<input type="text" class="form" name="notafiscal" style="width:200px" maxlength="50"></td>
					</tr>
					<tr>
	  			
					<td class="texto" colspan="2"><br></td>
				</tr>
					<%end if%>
				<tr>
					<td class="texto" colspan="2" align="right"><input type="submit" name="buscar" value="buscar &gt;&gt;" class="form"></td>
				</tr>
</table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
