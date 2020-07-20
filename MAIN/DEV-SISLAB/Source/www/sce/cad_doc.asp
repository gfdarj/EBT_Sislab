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
Tela.SCE = True
Tela.SetNomeTela = "Cadastro > Documento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Call Tela.ImprimeMenuSce()

    Dim Combo
    Set Combo = New TCombo
%>
<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
</script>

<div class="margem-10">
    <form method=post action="cad_doc2.asp" name="formulario"  onsubmit="vdform('formulario','doc_responsavel','Responsável','R','dia','Dia','RNumber','mes','Mes','RNumber','ano','Ano','RNumber','doc_numero','Número do Documento','R'); return document.ValorPassou;">
        <table >
	        <tr>
		        <td>
		        <%if request("msg")<>"" then response.write "<strong>Documento cadastrado com sucesso!</strong><br><br>"%></td>
	        </tr>
	        <tr>
		        <td>Responsável Técnico:&nbsp;<input type="text" name="doc_responsavel" size="30" maxlength="50"></td>
	        </tr>
	        <tr><td>&nbsp;</td></tr>
			<tr>
				<td>Nome do Cliente:&nbsp;
					<input type="text"  name="doc_nome" size="30" maxlength="50">
				</td>
			</tr>
	        <tr><td>&nbsp;</td></tr>
			<tr>
				<td>Email do Cliente:&nbsp;
					<input type="text"  name="doc_mail" size="30" maxlength="50">
				</td>
			</tr>
	        <tr><td>&nbsp;</td></tr>
			<tr>
				<td>Identidade do Cliente:&nbsp;
					<input type="text"  name="doc_ide" size="30" maxlength="50">
				</td>
			</tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr>
				<td>Telefone do Cliente:&nbsp;
					<input type="text"  name="doc_fone" size="30" maxlength="50">
				</td>
	        </tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr>
		        <td>
			        <table class="largura-total">
			        <tr>
				        <td>Empresa do Cliente:&nbsp;</td>
				        <td><%RW Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", False)%></td>
			        </tr>
			        <tr>
				        <td class="texto-direito text-info">Ou Preencha:&nbsp;</td>
				        <td><input type="text"  name="doc_empresa" size="40" maxlength="50"></td>
			        </tr>
			        </table>
		        </td>
	        </tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr>
		        <TD>Observação:<br>
			        <textarea name="doc_observacao"  cols="80" rows="5"></textarea>
		        </td>
	        </tr>
	        <tr><td>&nbsp;</td></tr>
	        <tr> 
		        <td><input type="submit" class="btn btn-primary" name="Submit" value="Cadastrar" ></td>
            </tr>
        </table>
    </form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>