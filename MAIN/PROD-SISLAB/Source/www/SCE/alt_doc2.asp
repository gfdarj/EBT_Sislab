<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<script>
	<!--#include file="includes/vform.js"-->
</script>
<%
Dim Valor

call ImprimeCabecalho ("", MENU_ON, true, "Edição de Documento", "", "history.go(-1);")

ssql = "select * from sce_documentacao where doc_id = "& request("doc_id")
set rec = conn.execute(ssql)
%>
<form method=post action="alt_doc3.asp" name="formulario"  onsubmit="vdform('formulario','doc_responsavel','Responsável','R','dia','Dia','RNumber','mes','Mes','RNumber','ano','Ano','RNumber','doc_numero','Número do Documento','R'); return document.ValorPassou;">
<input type=hidden name=doc_id value="<%=request("doc_id")%>">
<div align="left">
<table width="810px">	
    <tr> 
      <td>
  		<table width="100%" cellpadding=0 cellspacing=0>
    		  <tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO">Responsável Técnico:&nbsp;
								<input type="text" class="form" name="doc_responsavel" size="30" maxlength="50" value="<%=rec("doc_responsavel")%>"></td>
								<TD CLASS="TEXTO">Data de Emissão:&nbsp;
								<input type="text" class="form" disabled name="dia" size="3" maxlength="2" value="<%=right(rec("doc_datadocumento"),2)%>">&nbsp;/&nbsp;<input type="text" disabled class="form" name="mes" size="3" maxlength="2" value="<%=mid(rec("doc_datadocumento"),6,2)%>">&nbsp;/&nbsp;<input type="text" class="form" name="ano" size="4" maxlength="4" value="<%=left(rec("doc_datadocumento"),4)%>" disabled></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO">Número de Documento:&nbsp;
								<input type="text" class="form" name="doc_numero" size="10" maxlength="50" value="<%=Zeros(rec("doc_id"),4)%>" disabled></td>
								<TD CLASS="TEXTO">Nome do Cliente:&nbsp;
								<input type="text" class="form" name="doc_nome" size="50" maxlength="50" value="<%=rec("doc_nome")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO">Telefone do Cliente:&nbsp;
								<input type="text" class="form" name="doc_fone" size="30" maxlength="50" value="<%=rec("doc_fone")%>"></td>
								<TD CLASS="TEXTO">Email do Cliente:&nbsp;
								<input type="text" class="form" name="doc_mail" size="30" maxlength="50" value="<%=rec("doc_mail")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO">Identidade do Cliente:&nbsp;
								<input type="text" class="form" name="doc_ide" size="30" maxlength="50" value="<%=rec("doc_ide")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO" colspan=2>Empresa do Cliente:&nbsp;
<%			if IsNull(rec("enf_id")) then valor = "" else valor = cstr(rec("enf_id"))
			call comboFornecedor("enf_id", conn, valor, "N", "FORNECEDOR", true)%>
								<br>OU PREENCHA:
								<input type="text" class="form" name="doc_empresa" size="50" maxlength="50" value="<%=rec("doc_empresa")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="TEXTO">Observação:<br>
								<textarea name="doc_observacao" class="form" cols="80" rows="5"><%=rec("doc_observacao")%></textarea>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<script>
					function func(){
						document.formulario.action = "exc_doc.asp";
					}
				</script>
				<tr> 
	      			<td><br><input type="submit" name="Submit" value=" Alterar " class="form">&nbsp;&nbsp;<input type="submit" name="Submit" value=" Excluir " class="form" onClick="func();"></td>
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
