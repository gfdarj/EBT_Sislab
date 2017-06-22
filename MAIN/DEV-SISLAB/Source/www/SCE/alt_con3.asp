<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Alterar Consumível", "", "history.go(-1);")

ssql = "select * from sce_consumiveis where con_id = "& request("con_id")
set record = conn.execute(ssql)
%>
<script>
	<!-- #INCLUDE FILE="includes/vform.js" -->
</script>
<form method=post action="alt_con4.asp" name="formulario"  onsubmit="vdform('formulario','categoria','Categoria','R','codbarras','Codigo de Barras','R','localizacao','Localizacao','R','numeroserie','Numero de serie','R','unidade','Unidade','Number','estoque','Estoque','Number','calibracao','Período de Calibração','Number','manutencao','Período de Manutenção','Number'); return document.ValorPassou;">
<input type=hidden name=con_id value="<%=request("con_id")%>">
   <table>
	<tr> 
      <td>
 		 <table width="100%" cellpadding=0 cellspacing=0 border=0>
		 	<tr>
				<td  bgcolor="#FFFFFF" align="left" class="texto"> 
				Descrição do Consumível<br>
					<input type="text" class="form" name="descricao" style="width:200" maxlength="16" value="<%=record("con_desc")%>">
				</td>
				<td bgcolor="#FFFFFF" align="left" class="texto"> 
				Localização<br>
				<input type="text" class="form" name="localizacao" style="width:150" maxlength="20" value="<%=record("con_localizacao")%>"></td>
    		</tr>
			<tr> 
      			<td bgcolor="#FFFFFF" align="left" colspan="3" class="texto"><br></td>
			</tr>
			<tr> 
      			<td bgcolor="#FFFFFF" colspan="3" class="texto">Observações<br>
				<textarea class="form" name="obs" cols="100" rows="5" maxlength="255"><%=record("con_obs")%></textarea></td>
			</tr>
			<tr> 
      			<td bgcolor="#FFFFFF" align="left" colspan="3" class="texto"><br></td>
			</tr>
			<tr> 
      			<td bgcolor="#FFFFFF" align="left" colspan="3" class="texto"><br></td>
			</tr>
			<tr> 
				<td bgcolor="#FFFFFF" class="texto">Unidade:<br>
				<input type="text" class=disabled name="unidade" size="20" value="<%=record("con_unidade")%>" disabled>
				</td>
				<td bgcolor="#FFFFFF" class="texto">Estoque:<br>
				<input type="text" class=disabled name="estoque" size="20" value="<%=record("con_estoque")%>" disabled>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br></td>
			</tr>
			<tr>
				<td colspan="3"><hr width="700" size="1"></td>
			</TR>
			<%if request("nf_id")="" then%>
			<tr>
				<td class="titulo" colspan="3">Nota Fiscal:</td>
			</tr>
			<tr>
				<td colspan="3"><br></td>
			</tr>
			<SCRIPT LANGUAGE="jscript">				
	var idfornecedor = new Array();
	var idnota = new Array();				
	var numero = new Array();
			
			<%
				ssql = "select * from sce_nota_fiscal order by nf_numeronota"
				set rec = conn.execute(ssql)
				if not rec.eof then	
				i=0
				do while not rec.eof
					response.write ("idfornecedor[" & i & "]=" & rec("enf_id") & ";" & chr(13))
					response.write ("idnota[" & i & "]=" & rec("nf_id") & ";" & chr(13))
					response.write ("numero[" & i & "]='" & rec("nf_numeronota") & "';" & chr(13))
					i=i+1					
				rec.movenext
				loop
				end if%>
			
function func(){
	objfabr=document.formulario.enf_id;
	objmod=document.formulario.nf_id;
	
	while (objmod.options.length!=0)
	{
		objmod.options.remove(0);	
	}
	var temp = document.createElement("OPTION");
	objmod.options.add(temp);
	
	for (i=0; i<idfornecedor.length; i++){
		if (idfornecedor[i]==objfabr.options[objfabr.selectedIndex].value){
			var oOption = document.createElement("OPTION");
			
			objmod.options.add(oOption);
			oOption.innerText = numero[i];
			oOption.value = idnota[i];
		}
	}
}
</script>
			<tr>	
				<td class="texto">Fornecedor:<br>
				<select name="enf_id" class="form" onchange="func();">
				<option value="" selected></option>
				<%ssql = "select * from sce_empresa_nota_fiscal order by enf_nome"
				set recenf = conn.execute(Ssql)
				if not recenf.eof then
					fab = request("fabricante")
					if fab = "" then fab = 0
					while not recenf.eof%>
						<option value="<%=recenf("enf_id")%>" <%if cint(fab) = recenf("enf_id") then response.write " selected"%>><%=recenf("enf_nome")%></option>
						<%recenf.movenext
					wend
				else
					response.write "<strong>Clique <a href=cad_empresas.asp>aqui</a> para cadastrar Fornecedor.</strong>"
					n = 1
				end if%>
				</select></td>
				<td bgcolor="#FFFFFF" class="texto">Número da Nota:<br>
				<select name="nf_id" class="form">
				<%if request("fabricante") <> "" then 
					ssql = "select * from sce_nota_fiscal where enf_id = "& request("fabricante")
					set rec = conn.execute(ssql)
					if not rec.eof then
						while not rec.eof%>
							<option value=<%=rec("nf_id")%> <%if rec("nf_id") = record("nf_id") then response.write " selected"%>><%=rec("nf_numeronota")%></option>
							<%rec.movenext
						wend
					end if
				end if%>
										</select></td>
			    <!--<td bgcolor="#FFFFFF" class="texto">STE:<br>
				<input type="text" class="form" name="ste" size=20 maxlength="50"></td>-->
			</tr>
			<tr> 
      			<td bgcolor="#FFFFFF" align="left" colspan="3" class="texto"><br></td>
			</tr>
			<%else%>
			<input type=hidden name=nf_id value="<%=request("nf_id")%>">
			<%end if%>
		</table>
      </td>
    </tr>
	<tr>
		<td><%if request("nf_id") <>"" then%>&nbsp;<%else%><hr width="700" size="1"><%end if%></td>
	</TR>
	<tr>
		<td CLASS="TITULO">Documento:</td>
	</TR>
	<tr>
		<td class="texto">Documento:<br>
			<select name="doc_id" class="form">
			<option value="" selected></option>
			<%ssql= "select * from sce_documentacao order by doc_id"
			set r = conn.execute(ssql)
			if not r.eof then
				while not r.eof%>
					<option value="<%=r("doc_id")%>"><%=Zeros(r("doc_id"), 4)%></option>
					<%r.movenext
				wend
			end if%>
		</td>
	</tr>
	<tr>
		<td><hr width="700" size="1"></td>
	</TR>
	<script>
		function fo(){
			document.vp = true;
			if (document.formulario.nf_id.value == ""){
				if (document.formulario.doc_id.value == ""){
					alert('Você deve escolher uma nota fiscal ou um documento!');
					document.vp = false;
				}
			}
		}
		function faction(){
			document.formulario.action="exc_con.asp";
			document.formulario.submit();
		}
	</script>
	<tr> 
      <td><br>
	  <%if n <> 1 then%><input type="submit" name="Submit" value="Alterar" class="form" onclick="fo(); return document.vp;">&nbsp;&nbsp;<input type=submit value="Excluir" class=form onclick="faction();"><%end if%></td>
    </tr>
  </table>
  </form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
