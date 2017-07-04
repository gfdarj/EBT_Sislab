<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Relatório de Movimentação de Consumivel", "", "history.go(-1);")

Response.write "<br><p class='texto'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Página em construção...</b></p>"
Response.end

%>
<form name="formulario" method="post" action="rel_con3.asp">
 <table>
	<tr><td  valign="middle" class="titulo">Busque o Consumível:</td></tr>
	 <tr>
		<td> 
      		<table border="0">
			<tr>
				<td valign="top" CLASS="texto">
			Tipo de Movimentação:<br>
			
			<select name="notipo" class="form">
				<option value=""> -- Escolha o Tipo de Movimentação --</option>
				<option value="1">Entrada </option>
				<option value="2">Saída </option>
				<option value="3">Volta ao LOG</option>
 			</select>
						</td>
						<td class="texto" >
Descrição:&nbsp;<input type="text" class="form" name="descricao" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>

						
	</tr>	
	<tr>
					<td class="texto" colspan="2"><br></td>
				</tr>
	  			<tr>
						<td class="texto" >
Localizacao:&nbsp;<input type="text" class="form" name="localizacao" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>
<td class="texto">
					Data da Movimentação:&nbsp;<input type="text" class="form" name="dia" size=2 maxlength="2">&nbsp;/&nbsp;<input type="text" class="form" name="mes" size=2 maxlength="2">&nbsp;/&nbsp;<input type="text" class="form" name="ano" size=4 maxlength="4"></td>
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
      	</td>
    </tr>
  </table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>
