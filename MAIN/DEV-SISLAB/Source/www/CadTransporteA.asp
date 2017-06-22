<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim id_Horario
Dim chr_Ida
Dim chr_Volta
Dim chr_SQL
Dim bln_Apaga

chr_Ida = RQ("Ida")
chr_Volta = RQ("Volta")
id_Horario = RQ("Horario")
bln_Apaga = (UCase(RQ("excluir")) = "S")

If bln_Apaga Then
	chr_SQL = _
		"DELETE FROM Transporte " & _
		"WHERE CodHorario = " & id_horario
Else
	If Not VVVNZ(id_horario) Then
		chr_SQL = _
			"UPDATE Transporte " & _
			"SET DeHoraIda = '" & chr_Ida & "', DeHoraVolta = '" & chr_Volta & "' " & _
			"WHERE CodHorario = " & id_horario
	Else
		chr_SQL = _
			"INSERT INTO Transporte (DeHoraIda, DeHoraVolta) " & _
			"VALUES ('" & chr_Ida & "', '" & chr_Volta & "')"
	End If
End If

On Error Resume Next

Call Env.oConn.Execute(chr_SQL)

If Env.oConn.Errors.Count > 0 Then
	RW "<script language='javascript'>alert('ERRO\n\nNúmero: " & Err.Number & "\nDescrição: " & Err.Description & "');</script>"
Else
	If VVVNZ(id_horario) Or bln_Apaga Then
		RW "<script language='javascript'>parent.location.href='CadTransporte.asp?altera=" & RQ("altera") & "';</script>"
	End If
End If

On Error Goto 0
%>
