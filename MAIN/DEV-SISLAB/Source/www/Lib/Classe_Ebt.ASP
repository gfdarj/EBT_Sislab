<%
Class TEbt

Private chr_Matricula
Private bln_ehFuncionario
Private chr_Nome_Reduzido
Private chr_Sigla_Orgao
Private chr_DN
Private chr_UF_Com
Private chr_CID_COM
Private chr_TEL1_COM
Private bln_ehGerente
Private chr_Sigla_Orgao_Gerente

Private Sub Class_Initialize()
	bln_ehFuncionario = False
	chr_Nome_Reduzido = ""
	chr_Sigla_Orgao = ""
	chr_DN = ""
	chr_UF_Com = ""
	chr_CID_COM = ""
	chr_TEL1_COM = ""
	bln_ehGerente = False
	chr_Matricula = ""
	chr_Sigla_Orgao_Gerente = ""
End Sub

Private Sub Class_Terminate()
End Sub


'-Property------------------------------------------------------------------------'

Public Property Get ehFuncionario()
	ehFuncionario = bln_ehFuncionario
End Property

Public Property Get Matricula()
	Matricula = chr_Matricula
End Property

Public Property Get Nome_Reduzido()
	Nome_Reduzido = chr_Nome_Reduzido
End Property

Public Property Get Sigla_Orgao()
	Sigla_Orgao = chr_Sigla_Orgao
End Property

Public Property Get DN()
	DN = chr_DN
End Property

Public Property Get UF_Com()
	UF_Com = chr_UF_Com
End Property

Public Property Get CID_COM()
	CID_COM = chr_CID_COM
End Property

Public Property Get TEL1_COM()
	TEL1_COM = chr_TEL1_COM
End Property

Public Property Get ehGerente()
	ehGerente = bln_ehGerente
End Property

Public Property Get Sigla_Orgao_Gerente()
	Sigla_Orgao_Gerente = chr_Sigla_Orgao_Gerente
End Property

'---------------------------------------------------------------------------------'

Public Sub BuscaDadosEmbratel(chr_Usuario)
	Dim sql
	Dim rst
	Dim obj1
	Dim objConn
	Dim objRS

	If Left(Application("SISLAB_AMBIENTE"), 3) = "LOC" Then
		bln_ehFuncionario = True
		chr_Nome_Reduzido = "Nome de Teste Local"
		chr_Sigla_Orgao = "LOCAL"
		chr_DN = "0"
		chr_UF_Com = "RJ"
		chr_CID_COM = "9876-5432"
		chr_TEL1_COM = "1234-5678"
		bln_ehGerente = True
		chr_Sigla_Orgao_Gerente = "LOCAL"
		chr_matricula = "000000"
	Else
		On Error Resume Next

		Set obj1 = Server.CreateObject("WebEmbratel.ClsUsername")
		chr_matricula = trim(obj1.GetMatricula(chr_Usuario))
		set	obj1 = nothing

		Set obj1 = Server.CreateObject("WebEmbratel.ClsCadastro")
		Set rst = obj1.GetDados(chr_Matricula)

	 	If rst Is Nothing Then
			bln_ehFuncionario = False
		Else
			bln_ehFuncionario = True
			chr_Nome_Reduzido = trim(rst("Nome_Reduzido"))
 			chr_Sigla_Orgao = trim(rst("SiglaOrgao"))
			chr_DN = trim(rst("DN"))
			chr_UF_Com = trim(rst("UF_Com"))
 			chr_CID_COM = trim(rst("CID_COM"))
			chr_TEL1_COM =  trim(rst("TEL1_COM")) ' caso nulo usuario nao atualizou no CTE

			'-- verifico se o usuário é do órgão de gerencia do CRT
			sql = "SELECT ORGA_SIGLA FROM ORGAO WHERE ORGA_USERIDCHEFE = '" & chr_Usuario & "'"
			Call Env.RecordSet(True, objRS, sql)

			If Not (objRS.Eof and objRS.Bof) Then
				bln_ehGerente = True
				chr_Sigla_Orgao_Gerente = objRS("ORGA_SIGLA")
			End if

			Call Env.RecordSet(False, objRS, Null)
		End If

		Set obj1 = nothing
		Set rst = nothing

		If Err.Count > 0 Then
			bln_TemErro = True
			Call ImprimeErrosConexao(Err)
		End If

		On Error Goto 0

	End If

End Sub

Public Function ExisteUsuario(chr_Usuario)
	Dim chr_Matricula
	Dim obj1
	Dim rst

	On Error Resume Next

	Set obj1 = Server.CreateObject("WebEmbratel.ClsUsername")
	chr_Matricula = trim(obj1.GetMatricula(chr_Usuario))
	Set obj1 = Nothing

	Set obj1 = Server.CreateObject("WebEmbratel.ClsCadastro")
	Set rst = obj1.GetDados(chr_Matricula)

	ExisteUsuario = True
 	If rst Is Nothing Then
		ExisteUsuario = False
	End If

	On Error Goto 0

	Set obj1 = Nothing
	Set rst = Nothing
End Function

Public Function AchaNomeEmbratel(chr_Usuario)
	Dim chr_Matricula
	Dim rst
	Dim obj1

	If Left(Application("SISLAB_AMBIENTE"), 3) = "LOC" Then
		AchaNomeEmbratel = "Ambiente de Testes"
	Else
		On Error Resume Next

		Set obj1 = Server.CreateObject("WebEmbratel.ClsUsername")
		chr_Matricula = trim(obj1.GetMatricula(chr_Usuario))
		set	obj1 = nothing

		Set obj1 = Server.CreateObject("WebEmbratel.ClsCadastro")
		Set rst = obj1.GetDados(chr_Matricula)

	 	If rst Is Nothing Then
			AchaNomeEmbratel = ""
		Else
			AchaNomeEmbratel = trim(rst("Nome_Reduzido"))
		End If

		Set obj1 = nothing
		Set rst = nothing

		If Err.Count > 0 Then
			bln_TemErro = True
			Call ImprimeErrosConexao(Err)
		End If

		On Error Goto 0

	End If

End Function

End Class
%>