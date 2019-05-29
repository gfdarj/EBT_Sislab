<%
'#################################################################################################
'#	Cópia das rotinas utilizadas pelo SCE
'#
'#	Futuramente quando as rotinas estiverem integradas, usaremos esta com coisas básicas somente
'#	do SCE, acessando tudo do SISLAB
'#################################################################################################

'-- monta combo de fornecedores
Sub ComboFornecedor(nome, objConn, padrao, todos, tipo, completa)
	dim ssql

	ssql = "select enf_id as VALOR, (case when enf_nome is null then '' else LEFT(enf_nome, 50) end) + "

	if completa then
		ssql = ssql & "(case when enf_cidade is null or enf_cidade = '' then '' else ' / ' + enf_cidade end) + "
	end if

	ssql = ssql & _
			"(case when enf_cnpj is null or enf_cnpj = '' then '' else '&nbsp;&nbsp;(' + " & _
			"left(enf_cnpj, 2) + '.' + substring(enf_cnpj, 3, 3) + '.' + substring(enf_cnpj, 6, 3) + '/' + substring(enf_cnpj, 9, 4) + '-' + right(enf_cnpj, 2) + ')' end) "

	if completa then
		ssql = ssql & " + ' [' + ENF_TIPOEMPRESA + ']' "
	end if

	ssql = ssql & _
			"as DESCRICAO " & _
			"from sce_empresa_nota_fiscal "

	if ucase(tipo) = "FORNECEDOR" then
		ssql = ssql & "where enf_tipoempresa = 'F'"
	elseif ucase(tipo) = "TRANSPORTADORA" then
		ssql = ssql & "where enf_tipoempresa = 'T'"
	end if

	ssql = ssql & "order by enf_nome, enf_cidade"

	call comboBDSQL(nome, objConn, sSQL, padrao, todos)
End Sub

%>