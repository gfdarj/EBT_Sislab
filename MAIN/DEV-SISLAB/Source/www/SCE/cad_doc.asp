<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/abre.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Cadastra Documento", "", "history.go(-1);")
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
<form method=post action="cad_doc2.asp" name="formulario"  onsubmit="vdform('formulario','doc_responsavel','Responsável','R','dia','Dia','RNumber','mes','Mes','RNumber','ano','Ano','RNumber','doc_numero','Número do Documento','R'); return document.ValorPassou;">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg")<>"" then response.write "<strong>Documento cadastrado com sucesso!</strong><br><br>"%></td>
	</tr>
	<TR>
		<TD CLASS="TEXTO">Responsável Técnico:&nbsp;
			<input type="text" class="form" name="doc_responsavel" size="30" maxlength="50">
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr> 
		<td>
			<TABLE WIDTH="600" cellpadding="0" cellspacing="0">
			<TR>
				<TD CLASS="TEXTO">Nome do Cliente:&nbsp;
					<input type="text" class="form" name="doc_nome" size="30" maxlength="50">
				</td>
				<TD CLASS="TEXTO">Email do Cliente:&nbsp;
					<input type="text" class="form" name="doc_mail" size="30" maxlength="50">
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td>
			<TABLE WIDTH="600" cellpadding="0" cellspacing="0">
			<TR>
				<TD CLASS="TEXTO">Identidade do Cliente:&nbsp;
					<input type="text" class="form" name="doc_ide" size="30" maxlength="50">
				</td>
				<TD CLASS="TEXTO">Telefone do Cliente:&nbsp;
					<input type="text" class="form" name="doc_fone" size="30" maxlength="50">
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td>
			<TABLE WIDTH="100%" cellpadding="0" cellspacing="0" CLASS="TEXTO">
			<TR>
				<TD>Empresa do Cliente:</td>
				<td>
					<%call comboFornecedor("enf_id", conn, "", "N", "FORNECEDOR", false)%>
				</td>
			</tr>
			<tr>
				<td align="right">OU PREENCHA:&nbsp;</td>
				<td><input type="text" class="form" name="doc_empresa" size="40" maxlength="50"></td>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr CLASS="TEXTO">
		<TD>Observação:<br>
			<textarea name="doc_observacao" class="form" cols="80" rows="5"></textarea>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr> 
		<td><input type="submit" name="Submit" value="Cadastrar" class="form"></td>
    </tr>
</table>
</form>
<%
conn.close
set conn=nothing

call ImprimeRodape (RODAPE_OFF)
%>