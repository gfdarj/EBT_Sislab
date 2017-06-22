<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Cadastro > Documento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Call Tela.ImprimeMenuSce()

    Dim Combo
    Set Combo = New TCombo
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
<form method=post action="cad_doc2.asp" name="formulario"  onsubmit="vdform('formulario','doc_responsavel','Responsável','R','dia','Dia','RNumber','mes','Mes','RNumber','ano','Ano','RNumber','doc_numero','Número do Documento','R'); return document.ValorPassou;">
<table width="100%">
	<tr>
		<td class=texto1>
		<%if request("msg")<>"" then response.write "<strong>Documento cadastrado com sucesso!</strong><br><br>"%></td>
	</tr>
	<TR>
		<TD CLASS="texto1">Responsável Técnico:&nbsp;
			<input type="texto1" class="form" name="doc_responsavel" size="30" maxlength="50">
		</td>
	</tr>
	<tr class="texto1"><td>&nbsp;</td></tr>
	<tr> 
		<td>
			<TABLE WIDTH="600" cellpadding="0" cellspacing="0">
			<TR>
				<TD CLASS="texto1">Nome do Cliente:&nbsp;
					<input type="text" class="texto1" name="doc_nome" size="30" maxlength="50">
				</td>
				<TD CLASS="texto1">Email do Cliente:&nbsp;
					<input type="text" class="texto1" name="doc_mail" size="30" maxlength="50">
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto1"><td>&nbsp;</td></tr>
	<tr>
		<td>
			<TABLE cellpadding="0" cellspacing="0">
			<TR>
				<TD CLASS="texto1">Identidade do Cliente:&nbsp;
					<input type="text" class="form" name="doc_ide" size="30" maxlength="50">
				</td>
				<td width="60px">&nbsp;</td>
				<TD CLASS="texto1">Telefone do Cliente:&nbsp;
					<input type="text" class="form" name="doc_fone" size="30" maxlength="50">
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto1"><td>&nbsp;</td></tr>
	<tr>
		<td>
			<TABLE cellpadding="0" cellspacing="0" CLASS="texto1">
			<TR>
				<TD>Empresa do Cliente:&nbsp;</td>
				<td><%RW Combo.Fornecedor("enf_id", "", "N", "FORNECEDOR", False)%>
				</td>
			</tr>
			<tr>
				<td align="right">OU PREENCHA:&nbsp;</td>
				<td><input type="text" class="texto1" name="doc_empresa" size="40" maxlength="50"></td>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto1"><td>&nbsp;</td></tr>
	<tr CLASS="texto1">
		<TD>Observação:<br>
			<textarea name="doc_observacao" class="texto1" cols="80" rows="5"></textarea>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr> 
		<td><input type="submit" name="Submit" value="Cadastrar" class="texto1"></td>
    </tr>
</table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>