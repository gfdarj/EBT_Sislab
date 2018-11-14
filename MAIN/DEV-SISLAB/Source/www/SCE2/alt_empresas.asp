<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/estado.asp" -->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<!-- #INCLUDE FILE="includes/bib_str.asp" -->
<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
</script>
<%
call ImprimeCabecalho ("", MENU_ON, true, "Alterar Empresa", "", "history.go(-1);")

ssql = "select * from sce_empresa_nota_fiscal where enf_id = "& request("enf_id")
set rec = conn.execute(ssql)%>
<form method=post action="alt_empresas2.asp" name="formulario"  onSubmit="vdform('formulario','enf_cnpj','CNPJ','CNPJ','enf_cpf'); return document.ValorPassou; ">
<input type="hidden" name="enf_id" value="<%=request("enf_id")%>">
<div align="center">
<table width="100%">	
    <tr> 
      <td>
  		<table width="100%" cellpadding=0 cellspacing=0>
    		<tr> 
      			<td  align="left" class="texto">Nome da Empresa<br>
					<input type="text" class="form" name="enf_nome" style="width:600px" maxlength="100" value="<%=rec("enf_nome")%>"></td>
    		</tr>
    		<tr> 
      			<td  class="texto">Endereço<br>
					<input type="text" class="form" name="enf_endereco" style="width:600px" maxlength="150" value="<%=rec("enf_endereco")%>"></td>
    		</tr>
    		<tr>
				<td>
					<TABLE WIDTH="500" cellpadding="0" cellspacing="0">
							<TR>
								<TD CLASS="TEXTO">
								Cidade<br>
								<input type="text" class="form" name="enf_cidade" style="width:300px" maxlength="50" value="<%=rec("enf_cidade")%>"></td>
	      						<td  align="left" class="texto">Estado<br>
								<select name="enf_uf" class="form">
              			<% for i =1 to 27 %>
			           <option value="<%=i%>" <%if i = rec("enf_uf") then response.write " selected"%>><%=retestado(i)%></option>
					  <% next %>
           			 </select>&nbsp;&nbsp;&nbsp;</td>
	      						<td class="texto" >Cep<br>
								<input type="text" class="form" name="enf_cep" style="width:100px" maxlength="9" value="<%=rec("enf_cep")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
			<tr> 
      			<td class="texto" >
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<TD CLASS="TEXTO">
							IE<br>
								<input type="text" class="form" name="enf_ie" style="width:170px" maxlength="20"  value="<%=rec("enf_ie")%>"></td>
								<script language="JavaScript1.1">
function FormataCNPJ(Campo, teclapres){

	var tecla = teclapres.keyCode;

	var vr = new String(Campo.value);
	vr = vr.replace(".", "");
	vr = vr.replace(".", "");
	vr = vr.replace("/", "");
	vr = vr.replace("-", "");

	tam = vr.length + 1 ;

	
	if (tecla != 9 && tecla != 8){
		if (tam > 2 && tam < 6)
			Campo.value = vr.substr(0, 2) + '.' + vr.substr(2, tam);
		if (tam >= 6 && tam < 9)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,tam-5);
		if (tam >= 9 && tam < 13)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,3) + '/' + vr.substr(8,tam-8);
		if (tam >= 13 && tam < 15)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,3) + '/' + vr.substr(8,4)+ '-' + vr.substr(12,tam-12);
		}
}
</script>
					      	<td class="texto" > 
								CNPJ<br>
								<input type="text" class="form" name="enf_cnpj" style="width:170px" onKeydown="JavaScript:FormataCNPJ(this,event)" maxLength=18 value="<%=FormataCnpj(rec("enf_cnpj"))%>"></td>
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
							<input type="text" class="form" name="enf_cpf" onKeyUp="FormataCpf('cpf',11,event)" maxLength=14  value="<%=rec("enf_cpf")%>">
							</TD>
							<td>
							Tipo da empresa<br>
							<select  name="tipoempresa"><option value="F" <%if rec("ENF_TIPOEMPRESA") = "F" then response.write "selected" end if%>>Fornecedora</option><option value="T" <%if rec("ENF_TIPOEMPRESA") = "T" then response.write "selected" end if%>>Transportadora</option></select>
							</td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
    		<tr> 
      			<td class="texto">
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<TD CLASS="TEXTO">Telefone<br>
							(<input type="text" class="form" name="ddd" style="width:30px" maxlength="20" value="<%=rec("enf_ddd")%>">)&nbsp;<input type="text" class="form" name="enf_tel" style="width:170px" maxlength="20"  value="<%=rec("enf_tel")%>"></TD>
							<TD CLASS="TEXTO">Contato<br>
							<input type="text" class="form" name="enf_contato" style="width:300px" maxlength="50" value="<%=rec("enf_contato")%>"></td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
			<tr> 
      			<td class="texto" >
					<TABLE WIDTH="550" cellpadding="0" cellspacing="0">
						<TR>
							<td class="texto">
								Fax<br>
								(<input type="text" class="form" name="ddd_fax" style="width:30px" maxlength="20" value="<%=rec("enf_ddd_fax")%>">)&nbsp;<input type="text" class="form" name="enf_fax" style="width:150px" maxlength="20" value="<%=rec("enf_fax")%>"></td>
							<TD CLASS="TEXTO">Email<br>
							<input type="text" class="form" name="email" style="width:300px" maxlength="50" value="<%=rec("enf_email")%>"></td>
  	  					</tr>
					</TABLE>
				</TD>
			</TR>
			<tr> 
      			<td class="texto"> 
					<br>Observação<br>
					<textarea class="form" name="enf_observacao" rows="2" style="width:600px"><%=rec("enf_observacao")%></textarea></td>
    		</tr>
			<script>
			function func2(){
				document.formulario.action = "exc_empresas.asp"
			}
			</script>
			<tr><td>&nbsp;</td></tr>
			<tr> 
      			<td><input type="submit" name="Submit" value=" Alterar " class="form">&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onclick="func2();"></td>
		    </tr>
		</table>
      </td>
    </tr>
    
</form>
  </table>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
