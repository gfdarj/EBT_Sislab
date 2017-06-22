<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->


<!--#incl ude file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#inc lude file="includes/padraoHTML.asp"-->
<!--#INC LUDE FILE="includes/abre.asp" -->
<%
Tela.SetNomeTela = "SCE > Consulta > Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script>
<!--#include file="includes/vform.js"-->
</script>
<table width="780">	
	<%ssql = "select * from sce_nota_fiscal where nf_numeronota = "& request("numeronota") 
	set rec = Env.oConn.execute(ssql)%>
	<tr>
		<td valign="top"  valign="middle" class="destaque">Nota(s) fiscal(is) encontrada(s)<br><br></td>
	</tr>
	<%if not rec.eof then
		while not rec.eof
			ssql = "select * from sce_empresa_nota_fiscal where enf_id = "& rec("enf_id")
			set rec2 = Env.oConn.execute(Ssql)
			if not rec2.eof then%>
				<tr>
					<td valign="top" valign="middle" class=texto>
						<a href=cad_nf.asp?nf_id=<%=rec("nf_id")%>><%=rec("nf_numeronota")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%=rec2("enf_cnpj")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%=rec2("enf_nome")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<%				If rec("nf_tipo") = 1 Then
					Response.Write "Entrada"
				ElseIf rec("nf_tipo") = 2 Then
					Response.Write "Saída"
				Else
					Response.Write "&nbsp;"
				End If
%>						</a>
					</td>
				</tr>
			<%end if
			rec.movenext
		wend
	end if%>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
