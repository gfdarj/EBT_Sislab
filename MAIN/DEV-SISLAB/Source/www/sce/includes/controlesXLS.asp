<%
Public Sub criaExcel( Titulo, objRS, ordenacao)
	Dim str
	if not(isNull(ordenacao) or ordenacao = "") then _
		objRS.SORT = ordenacao 'trocaAspasColchetes(ordenacao)
	Call montaListagemExcel( objRS, Titulo, Null, Null,str )
	str = "<HTML><HEAD><META HTTP-EQUIV=""Content-Type"" CONTENT=""application/vnd.ms-excel""><title>teste</title></HEAD><BODY>" & str & "</BODY></HTML>"
	Response.ContentType = "application/excel"
	Response.Clear
	'Se tirarmos o attachment da linha baixo, ele não vai pedir 2 vezes pra abrir, mas vai abrir na própria janela...
	Response.AddHeader "Content-Disposition", "filename=" & chr(34) & "Relatorio.xls" & chr(34)
	Response.Write (str)
	'Response.end
End Sub

Sub montaListagemExcel( objRecordSet, Titulo, Link, Acao,str )
	Dim tmp, cont, exibeLink, i, colspan

	cont = 0

	If( NOT( isNull(Acao) ) )Then
		Acao = Left(Acao, inStr(Acao, ")")-1)
	End If

	cont = 0
	str = str & "<TABLE cellspacing=1 cellpadding=1 border=1>"

	'-- conto o numero de campos visíveis
	colspan = 0
	For i = 0 to objRecordSet.Fields.Count - 1
		If objRecordSet.Fields(i).Name <> "ID" and Right(objRecordSet.Fields(i).Name, 2) = "_M" Then
			colspan = colspan + 1
		End if
	Next

	If( NOT( isNull( Titulo ) ) )Then
		str = str & "<tr bordercolor=""white""><td align=center colspan=" & colspan & " bordercolor=""white""><FONT size=2 color""#CCCC00""><b>" & Titulo & "</b></FONT></TD></TR>"
		str = str & "<tr bordercolor=""white""><td colspan=" & colspan & "></tr></td>"
	End If

	If( NOT( objRecordSet.EOF ) )Then
		'<!-- Cabeçalho da tabela -->
		str = str & "<TR>"
		For each tmp in objRecordSet.Fields
			If(tmp.Name <> "ID" and Right(tmp.Name, 2) = "_M")Then
				str = str & "<td bgcolor=""black""><b><FONT color=""white"">" & replace(replace(tmp.Name,"_M",""),"_"," ") & "</b></font></td>"
			End If
		Next
		str = str & "</tr>"

		'<!-- Elementos da tabela -->
		While( NOT( objRecordSet.EOF ) )
			exibeLink = True
			If( (cont Mod 2) = 0)Then
		    	 str = str & "<tr bgcolor=""Silver"">"
			Else
			     str = str & "<tr>"
			End If

			For each tmp in objRecordSet.Fields
				If(tmp.Name <> "ID" and Right(tmp.Name, 2) = "_M")Then
					str = str & "<td>"
					If(isNull(Link) AND isNull(Acao) AND NOT(isNull(tmp.Value)))Then
						If tmp.Type = adCurrency Then
							str = str & FormatCurrency(Replace(trim(tmp.Value), "_¿", ""))
						ElseIf tmp.Type = adNumeric Then
							str = str & FormatNumber(Replace(trim(tmp.Value), "_¿", ""), 2)
						Else
							str = str & Replace(trim(tmp.Value), "_¿", "")
						End If
					End If
					str = str & "</td>"
					exibeLink = False
				End If
			Next
			objRecordSet.MoveNext
			cont = cont + 1
			str = str & "</tr>"
		Wend
	Else
		str = str & "<tr>"
		str = str & "<td>   Sua consulta não retornou nenhum registro!</td>"
		str = str & "</tr>"
	End If
	str = str & "</table>"
End Sub
%>