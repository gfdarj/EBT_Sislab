<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<%
Dim RS
Dim chr_Buf
Dim chr_SQL
Dim id_Noticia
Dim chr_Noticia
Dim chr_Link

id_Noticia = RQ("id_noticia")

If Not VVVNZ(id_Noticia) Then
	chr_SQL = "SELECT PLA_TITNOTICIA, PLA_LINK FROM Plantao WHERE pla_codnoticia = " & id_Noticia

	Call Env.RecordSet(True, RS, chr_SQL)

	If Not (RS.Eof And RS.Bof) Then
		chr_Noticia = RS("PLA_TITNOTICIA")
		chr_Link = RS("PLA_LINK")

		Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, true, "", chr_Noticia, "window.close();", "")

		chr_Buf = VbCrLf & _
				"<table class='tabela1' border='0' width='100%' height='500px'>" & VbCrLf & _
				"<tr>" & VbCrLf & _
				"	<td width='100%' valign='top'>" & VbCrLf & _
				"		<br><br>" & VbCrLf

		If Not VVVN(chr_Link) Then
			chr_Buf = chr_Buf & VbCrLf & _
				"		<iframe src='" & chr_Link & "' frameborder='0' width='100%' height='500px' scrolling='yes' name='noticias_iframe'><font face='Arial, Helvetica, sans-serif' size='1'>Sorry your browser does not support IFRAMES.</font></iframe>" & VbCrLf
		End If

		chr_Buf = chr_Buf & VbCrLf & _
				"	</td>" & VbCrLf & _
				"</tr>" & VbCrLf & _
				"</table>" & VbCrLf & _
				"<br><br>" & VbCrLf		
	Else
		chr_Noticia = "Nenhuma notícia encontrada."

		Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, true, "", "Notícias CRT", "window.close();", "")

		chr_Buf = VbCrLf & _
				"<table class='tabela1' border='0' width='100%' height='100%'>" & VbCrLf & _
				"<tr>" & VbCrLf & _
				"	<td width='100%' align='center'>" & VbCrLf & _
				"		<br><br><span><i>" & chr_Noticia & "</i></span>" & VbCrLf & _
				"		<br><br>" & VbCrLf & _
				"	</td>" & VbCrLf & _
				"</tr>" & VbCrLf & _
				"</table>" & VbCrLf & _
				"<br><br>" & VbCrLf
	End If

	Call Env.RecordSet(False, RS, Null)

Else
	chr_Noticia = "Código da Notícia inválido."
	chr_Link = ""

	Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, true, "", "Notícias CRT", "window.close();", "")

		chr_Buf = VbCrLf & _
				"<table class='tabela1' border='0' width='100%' height='100%'>" & VbCrLf & _
				"<tr>" & VbCrLf & _
				"	<td width='100%' align='center'>" & VbCrLf & _
				"		<br><br><span><i>" & chr_Noticia & "</i></span>" & VbCrLf & _
				"		<br><br>" & VbCrLf & _
				"	</td>" & VbCrLf & _
				"</tr>" & VbCrLf & _
				"</table>" & VbCrLf & _
				"<br><br>" & VbCrLf		
End If

RW chr_Buf

Call Tela.MostraRodape()
%>
