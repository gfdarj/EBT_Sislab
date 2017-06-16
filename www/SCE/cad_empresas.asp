<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#INCLUDE FILE="includes/estado.asp" -->
<!--#include file="includes/func.asp"-->
<script language="javascript">
function ValidaCampos()
{
	var frm = document.formulario;
	if (frm.enf_nome.value.length == 0)
	{
		alert("Defina o Nome da Empresa!");
		frm.enf_nome.focus()
		return false;
	}
	return true;
}

function Mascara (keypress, objeto){
	campo = eval (objeto);
	separador = '-'; 
	conjunto1 = 5;
	if (campo.value.length == conjunto1){
		campo.value = campo.value + separador;
	}
}

function Mascara2 (keypress, objeto){
	campo = eval (objeto);
	separador = '-'; 
	conjunto1 = 4;
	if (campo.value.length == conjunto1){
		campo.value = campo.value + separador;
	}
}
<!--#include file="includes/vform.js"-->
</script>
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Empresa", "", "history.go(-1);")
%>
<form method=post action="insCad_empresas.asp" name="formulario"  onsubmit="vdform('formulario','nome','Nome','R','endereco','Endereco','R','cidade','Cidade','R','uf','UF','R','ie','IE','R','cnpj','CNPJ','CNPJ','enf_cpf','CPF','CPF','tel','Telefone','Number','fax','Fax','Number'); return document.ValorPassou;">
<table width="100%">	
	<tr>
		<td class=texto>
		<%if request("msg") <> "" then response.write "<br><strong>Empresa cadastrada com sucesso!</strong><br><BR>"%></td>
	</tr>
    <tr> 
      <td>
  		<table width="100%" cellpadding=0 cellspacing=0>
    		<tr> 
      			<td bgcolor="#FFFFFF" align="left" class="texto">Nome da Empresa<br>
					<input type="text" class="form" name="nome" style="width:600px" maxlength="100"></td>
    		</tr>
    		<tr> 
      			<td bgcolor="#FFFFFF" class="texto">Endereço<br>
					<input type="text" class="form" name="endereco" style="width:600px" maxlength="150"></td>
    		</tr>
    		<tr>
				<td>
					<TABLE WIDTH="500" cellpadding="0" cellspacing="0">
							<TR>
								<TD CLASS="TEXTO">
								Cidade<br>
								<input type="text" class="form" name="cidade" style="width:300px" maxlength="50"></td>
	      						<td bgcolor="#FFFFFF" align="left" class="texto">Estado<br>
								<select name="enf_uf" class="form">
              			<% for i =1 to 27 %>
			           <option value="<%=i%>"><%=retestado(i)%></option>
					  <% next %>
           			 </select>&nbsp;&nbsp;&nbsp;</td>
	      						<td class="texto" bgcolor="#FFFFFF">Cep<br>
								<input type="text" class="form" name="cep" style="width:100px" maxlength="9" onKeyPress="Mascara(window.event.keyCode, this);" ></td>
							</tr>
						</table>
					</td>
				</tr>
			<tr> 
      			<td class="texto" bgcolor="#FFFFFF">
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<TD CLASS="TEXTO">
							IE<br>
								<input type="text" class="form" name="ie" style="width:170px" maxlength="20"></td>
					      	<td class="texto" bgcolor="#FFFFFF"> 
								CNPJ<br>
								<input type="text" class="form" name="cnpj" style="width:170px" maxlength="18" onkeydown="FormataCNPJ(this,event);"></td>
			      			
			  	  		</tr>
					</TABLE>
				</TD>
			</TR>
			<SCRIPT>

function FormataCpf(campo,tammax,teclapres) {
 var tecla = teclapres.keyCode;
  
 vr = event.srcElement.value;
 vr = vr.replace( "/", "" );
 vr = vr.replace( "/", "" );
 vr = vr.replace( ",", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 tam = vr.length;

 if (tam < tammax && tecla != 8){ tam = vr.length + 1 ; }

 if (tecla == 8 ){ tam = tam - 1 ; }
  
 if ( tecla == 8 || tecla >= 48 && tecla <= 57 || tecla >= 96 && tecla <= 105 ){
  if ( tam <= 2 ){ 
    event.srcElement.value = vr ; }
   if ( (tam > 2) && (tam <= 5) ){
    event.srcElement.value = vr.substr( 0, tam - 2 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 6) && (tam <= 8) ){
    event.srcElement.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 9) && (tam <= 11) ){
    event.srcElement.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 12) && (tam <= 14) ){
    event.srcElement.value = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 15) && (tam <= 17) ){
    event.srcElement.value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ;}
 }  
}
</script>
			
			<tr> 
      			<td class="texto" >
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR CLASS="TEXTO">
							<TD>CPF<br>
							<input type="text" class="form" name="enf_cpf" onKeyUp="FormataCpf('cpf',11,event)" maxLength=14>
							</TD>
							<td>
							Tipo da empresa<br>
							<select class="combo" name="tipoempresa"><option value="F">Fornecedora</option><option value="T">Transportadora</option></select>
							</td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
    		<tr> 
      			<td class="texto" bgcolor="#FFFFFF">
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<TD CLASS="TEXTO">Telefone<br>
							(<input type="text" class="form" name="ddd" style="width:30px"  maxlength="3">)&nbsp;<input type="text" class="form" name="tel" style="width:170px" maxlength="9" onKeyPress="Mascara2(window.event.keyCode, this);" ></TD>
							<TD CLASS="TEXTO">Contato<br>
							<input type="text" class="form" name="contato" style="width:300px" maxlength="50"></td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
			<tr> 
      			<td class="texto" bgcolor="#FFFFFF">
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<TD CLASS="TEXTO">Email<br>
							<input type="text" class="form" name="email" style="width:250px" maxlength="50"></TD>
							<td class="texto" bgcolor="#FFFFFF"> 
								Fax<br>
								(<input type="text" class="form" name="ddd_fax" style="width:30px" maxlength="3">)&nbsp;<input type="text" class="form" name="fax" style="width:150px" maxlength="9" onKeyPress="Mascara2(window.event.keyCode, this);"></td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
    	<!--	<tr>
				<td class="texto"><br>
				Categoria da Empresa:&nbsp;
				<select name="categoria" class="form">
				<option value="1">Fornecedor</option>
				<option value="2">Transportadora</option>
				<option value="3">Fabricante</option></td>
			</tr>-->
			<tr> 
      			<td class="texto"> 
					<br>Observação<br>
					<textarea class="form" name="observacao" rows="2" style="width:600px"></textarea><br><br><br></td>
    		</tr>
			<tr> 
      			<td><input type="submit" name="Submit" value="Cadastrar" class="form"></td>
		    </tr>
		</table>
      </td>
    </tr>
    
</form>
  </table>
<%
call ImprimeRodape (RODAPE_OFF)
%>
