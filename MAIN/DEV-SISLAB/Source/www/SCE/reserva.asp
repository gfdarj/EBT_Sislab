<!-- #include file="../includes/controleshtml.asp" -->
<!-- #include file="../includes/global.asp" -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->

<%
call ImprimeCabecalho ("", MENU_ON, true, "Reserva de Item", "", "history.go(-1);")
%>

<script language=javascript>
	<!--#include file="includes/vform.js"-->
</script>

<form name="formulario" method="post" action="reserva2.asp" onsubmit="vdform('formulario','numeroserie','Número de Série','Number','notafiscal','Nota Fiscal','Number'); return document.ValorPassou;">
<input type=hidden name=busca value=1>
 <table>
	<tr>
		<td width="780" class="titulo">
			<i>Reserva de Itens</i>&nbsp;>><a href="javascritp:history.back()">voltar</a>
		</td>
	</tr>
	<tr>
		<td width="780" class="texto">
		<br><br>
		<br><%if request("msg") <> "" then response.write " Reserva efetuada com sucesso.<br> Foi criado um histórico de reserva com estes dados.<br><br>"%></td>
	</tr>
	<tr>
	    <td  valign="middle" class="titulo">Selecione o Equipamento:</td>
	</tr>
	 <tr>
		<td> 
      		<table border="0">
	  			<tr>
	    			<td class="texto" colspan="2">
Código Barras:&nbsp;<input type="text" class="form" name="codbarras" style="width:200px" maxlength="50">&nbsp;&nbsp;
						<!--<input type="Button" value=" Procurar " onclick="buscaCB()" class="form">--></td>
				</tr>
				<tr>
					<td class="texto" colspan="2"><br></td>
				</tr>
				<SCRIPT LANGUAGE="jscript">				
	var idfabricante = new Array();
	var idmodelo = new Array();				
	var codnome = new Array();
<%				ssql = "select * from sce_modelos order by mod_codnome"
				set rec = conn.execute(ssql)
				if not rec.eof then	
				i=0
				do while not rec.eof
					response.write ("idfabricante[" & i & "]=" & rec("fab_id") & ";" & chr(13))
					response.write ("idmodelo[" & i & "]=" & rec("mod_id") & ";" & chr(13))
					response.write ("codnome[" & i & "]='" & rec("mod_codnome") & "';" & chr(13))
					i=i+1					
				rec.movenext
				loop
				end if%>

function func(){
	objfabr=document.formulario.fabricante;
	objmod=document.formulario.modelo;
	
	while (objmod.options.length!=0)
	{
		objmod.options.remove(0);	
	}
	var temp = document.createElement("OPTION");
	objmod.options.add(temp);
	
	for (i=0; i<idfabricante.length; i++){
		if (idfabricante[i]==objfabr.options[objfabr.selectedIndex].value){
			var oOption = document.createElement("OPTION");
			
			objmod.options.add(oOption);
			oOption.innerText = codnome[i];
			oOption.value = idmodelo[i];
		}
	}
}
</script>

				<tr>
	    			<td class="texto">
Fabricante:&nbsp;<select name="fabricante" class="form" onchange="func();">
				<option value="">Todos</option>
				<%ssql = "select * from sce_fabricantes order by fab_nome"
				set rec = conn.execute(ssql)
				if not rec.eof then
					while not rec.eof%>
						<option value="<%=rec("fab_id")%>"><%=rec("fab_nome")%></option>
						<%rec.movenext
					wend
				end if%>
				</select>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="texto">
Modelo:&nbsp;<select name="modelo" class="form">
				<option value="">Todos</option>
				
				</select></td>
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
					<td class="texto">
					Número de Série:&nbsp;<input type="text" class="form" name="numeroserie" style="width:200px" maxlength="50"></td>
				</tr>
				
	  			<tr>
					<td class="texto" colspan="2"><br></td>
				</tr>
				<tr>
					<td class="texto" colspan="2" align="right"><input type="submit" name="buscar" value="próximo &gt;&gt;" class="form"></td>
				</tr>
				
				<!--tr>
					<td colspan="2" class="texto">Selecione um Acessório para Edição: (aparece de acordo com as seleçoes acima)z</td>
				</tr>
				<tr>
					<td colspan="2" class="texto">
					<select name="ac_id" class="form" size="6" style="width:600" onchange="navselecao();" ondblclick="navselecao();">
					<option value="">código de barras</option>
					</select></td>
			    </tr-->
			</table>
      	</td>
    </tr>
  </table>
</form>

</center>
<%
call ImprimeRodape (RODAPE_OFF)
%>
