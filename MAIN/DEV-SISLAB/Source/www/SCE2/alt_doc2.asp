<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Edita Documento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Valor
    Dim Combo
    Set Combo = New TCombo

    ssql = "select * from sce_documentacao where doc_id = "& request("doc_id")
    set rec = Env.oconn.execute(ssql)

    Call Tela.ImprimeMenuSce()
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
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
								<TD CLASS="texto1">Responsável Técnico:&nbsp;
								<input type="text" class="texto1" name="doc_responsavel" size="30" maxlength="50" value="<%=rec("doc_responsavel")%>"></td>
								<TD CLASS="texto1">Data de Emissão:&nbsp;
								<input type="text" class="texto1" disabled name="dia" size="3" maxlength="2" value="<%=right(rec("doc_datadocumento"),2)%>">&nbsp;/&nbsp;<input type="text" disabled class="texto1" name="mes" size="3" maxlength="2" value="<%=mid(rec("doc_datadocumento"),6,2)%>">&nbsp;/&nbsp;<input type="text" class="texto1" name="ano" size="4" maxlength="4" value="<%=left(rec("doc_datadocumento"),4)%>" disabled></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="texto1">Número de Documento:&nbsp;
								<input type="text" class="texto1" name="doc_numero" size="10" maxlength="50" value="<%=Zeros(rec("doc_id"),4)%>" disabled></td>
								<TD CLASS="texto1">Nome do Cliente:&nbsp;
								<input type="text" class="texto1" name="doc_nome" size="50" maxlength="50" value="<%=rec("doc_nome")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="texto1">Telefone do Cliente:&nbsp;
								<input type="text" class="texto1" name="doc_fone" size="30" maxlength="50" value="<%=rec("doc_fone")%>"></td>
								<TD CLASS="texto1">Email do Cliente:&nbsp;
								<input type="text" class="texto1" name="doc_mail" size="30" maxlength="50" value="<%=rec("doc_mail")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="texto1">Identidade do Cliente:&nbsp;
								<input type="text" class="texto1" name="doc_ide" size="30" maxlength="50" value="<%=rec("doc_ide")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="texto1" colspan=2>Empresa do Cliente:&nbsp;
<%			if IsNull(rec("enf_id")) then valor = "" else valor = cstr(rec("enf_id"))
			RW Combo.Fornecedor("enf_id", valor, "N", "FORNECEDOR", true)%>
								<br>OU PREENCHA:
								<input type="text" class="texto1" name="doc_empresa" size="50" maxlength="50" value="<%=rec("doc_empresa")%>"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				<td>
					<TABLE WIDTH="600">
							<TR>
								<TD CLASS="texto1">Observação:<br>
								<textarea name="doc_observacao" class="texto1" cols="80" rows="5"><%=rec("doc_observacao")%></textarea>
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
	      			<td><br><input type="submit" name="Submit" value=" Alterar " class="texto1">&nbsp;&nbsp;
	      			    <input type="submit" name="Submit" value=" Excluir " class="texto1" onClick="func();">
	      			</td>
			    </tr>
			</table>
      </td>
    </tr>
    
</form>
  </table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
