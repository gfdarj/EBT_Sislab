<%
'+-------------------------------------------------------------------------------------------
'+ Monta o código HTML de combos padronizadas ou não que são utilizadas pelo SISLAB
'+
'+ dependencia: SCE2/Global_SCE.asp
'+              Geral_Lib.asp
'+-------------------------------------------------------------------------------------------
Class TCombo

Private buffer
Private p_classe

Private Sub Class_Initialize()
    p_classe = "texto1"
    buffer = ""
End Sub

Private Sub Class_Terminate()
    buffer = ""
End Sub

'Public Property Get RetornaCaminhoAnterior()
'	If chr_CaminhoAnt = "" Then RetornaCaminhoAnterior = "index.asp" Else RetornaCaminhoAnterior = chr_CaminhoAnt
'End Property
Public Property Let SetClasse(classe)
	p_classe = classe
End Property

'antiga comboBDSQL
'monta o html da combo a partir do sql vindo com os campos VALOR, DESCRICAO
Public Function PadraoSql(nome, SQL, padrao, todos)
	Dim objRecordSet
	Dim valor, descricao

	Call Env.RecordSet(true, objRecordSet, SQL)

    buffer = "<select class='" & p_classe & "' name='" & nome & "' id='ID_" & nome & "'>" & VbCrLf

	If todos = "N" Then
	    buffer = buffer & "<option value=''>--</option>" & VbCrLf
	End If
	If todos = true Then
		buffer = buffer & "<option value='' " & IIf(padrao="", "selected", "") & ">-- Todos --</option>" & VbCrLf
	End If

	If IsNull(padrao) Then padrao = ""

	While Not objRecordSet.EOF
		Valor = objRecordSet("VALOR")
		If IsNull(Valor) Then Valor = ""
		Descricao = objRecordSet("DESCRICAO")
		If IsNull(descricao) Then descricao = ""

        buffer = buffer & "<option " & IIf(CStr(Valor) = CStr(padrao), "selected", "") & " value='" & valor & "'>" & descricao & "</option>"

		objRecordSet.MoveNext
	Wend
	Call Env.RecordSet(False, objRecordSet, Null)

	buffer = buffer & "</select>" & VbCrLf

    PadraoSql = buffer
End Function

Public Function SimNao(nome, todos)
	Dim s
	s = "select 'S' as valor, 'Sim' as descricao UNION SELECT 'N', 'Não' ORDER BY valor desc"
	SimNap = PadraoSql(nome, s, "", todos)
End Function

'antiga ComboDB e ComboDBPadrao
Public Function OptionBD(ByVal sql, ByVal padrao, ByVal selected)
	Dim rs
	buffer = ""
	call Env.RecordSet(True, rs, sql)

	If Not (IsEmpty(padrao) Or padrao = "" Or IsNull(padrao)) Then
	    buffer = "<option value=''>" & padrao & "</option>" & VbCrLf
	end if

	While not rs.EOF
		buffer = buffer & "<option value='" & Server.HtmlEncode(rs("valor")) & "'"

        If Not IsNull(selected) then
		    If CStr(selected) = CStr(rs("valor")) And Not (IsEmpty(selected) Or selected = "") Then
		        buffer = buffer & " selected"
    		End If
		End If

		buffer = buffer &  ">" & rs("descricao") & "</option>" & VbCrLf
		rs.MoveNext()
	WEnd
	Call Env.RecordSet( false, rs, null)
	OptionBD = buffer
End Function


'antiga comboRATeRT
'retorna uma combo com todos os RTs visiveis
Public Function RATeRT(nome, todos)
	Dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where (rt = 1 or rat=1) and exibir =1  and not matricula is null order by nome"
	RATeRT = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboRatERtTodos
Public Function RatERtTodos(nome, todos)
	Dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where (rt = 1 or rat=1) order by nome"
	RatERtTodos = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboRt
Public Function Rt(nome, todos)
	Dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rt = 1 and exibir =1  and not matricula is null order by nome"
	Rt = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboRtTodos
Public Function RtTodos(nome, todos)
	Dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rt = 1 order by nome"
	RtTodos = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboRat
Public Function Rat(nome, todos)
	Dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rat = 1 and exibir =1  and not matricula is null order by nome"
	Rat = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboRatTodos
Public Function RatTodos(nome, todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rat = 1 order by nome"
	RatTodos = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboUserCRT
'retorna uma combo com todos os usuários visiveis
Public Function UserCRT(nome, todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT where exibir =1 and not matricula is null order by nome"
	UserCRT = Me.PadraoSql( nome, sSQL, "", todos)
End Function

'antiga comboUserCRTVivoEMortos
Public Function UserCRTVivoEMortos(nome, todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT order by nome"
	UserCRTVivoEMortos = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboUSERCRTVIVOEMORTOSSomenteID
Public Function UserCRTVivoEMortosSomenteID(nome, padrao, todos)
	dim sSQL
	sSQL = "select upper(userid) as valor, upper(userid) as descricao from userCRT order by userid"
	UserCRTVivoEMortosSomenteID = Me.PadraoSql(nome, sSQL, padrao, todos)
End Function

'antiga comboServicosPlataformas
Public Function ServicosPlataformas(nome, todos, servico_ou_plataforma)
	Dim sSQL

	If servico_ou_plataforma = "S" then
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas where s_servico = 1 order by s_descricao"
	Elseif servico_ou_plataforma = "P" then
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas where s_servico = 0 order by s_descricao"
	Else
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas order by s_descricao"
	End if

	ServicosPlataformas = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboUSERCRTcDefault
Public Function UserCRTcDefault(nome, def, todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT where exibir =1 and not matricula is null order by nome"
	UserCRTcDefault = Me.PadraoSql(nome, sSQL, def, todos)
End Function

'antiga comboDePara
Public Function DePara(nome, todos)
	dim sSQL

	sSQL = "select 'Orgao' as valor,'Orgão do Solicitante' as descricao union "
	sSQL = sSQL & "(select 'OrgaoInterno' as valor, 'Órgão Interno' as descricao) union "
	sSQL = sSQL & "(select 'ClienteExterno' as valor,'Cliente Externo' as descricao) union "
	sSQL = sSQL & "(select 'TipoAtividade' as valor,'Tipo de Atividade' as descricao) union "
	sSQL = sSQL & "(select 'Tecnologia' as valor,'Tecnologia' as descricao)  UNION"
	sSQL = sSQL & "(select 'Equipamento' as valor,'Equipamento' as descricao)  UNION"
	sSQL = sSQL & "(select 'Testes' as valor,'Testes' as descricao) UNION "
	sSQL = sSQL & "(select 'TipoTeste' as valor, 'TipoTeste' as descricao) UNION "
	sSQL = sSQL & "(select 'Servicos' as valor, 'Serviços' as descricao) UNION "
	sSQL = sSQL & "(select 'Plataformas' as valor, 'Plataformas' as descricao) UNION "
	sSQL = sSQL & "(select 'LB_TipoOcorrencia' as valor,'Tipo de Ocorrência LogBook' as descricao) UNION "
	sSQL = sSQL & "(select 'TipoArquivo' as valor,'Tipo de Arquivo' as descricao) "
	sSQL = sSQL & "ORDER BY descricao"
	DePara = Me.PadraoSql( nome, sSQL, "", todos)
End Function

'antiga comboTecnologia
Public Function Tecnologia(nome, todos)
	dim sSQL
	sSQL = "select tec_id as valor,tec_nome as descricao from tecnologia ORDER BY TEC_NOME"
	Tecnologia = Me.PadraoSQl(nome, sSQL, "", todos)
End Function

'antiga comboTipoAtividade
Public Function TipoAtividade(nome, todos)
	dim sSQL
	sSQL = "select ta_id as valor,ta_descricao as descricao from tipo_atividade ORDER BY ta_descricao"
	TipoAtividade = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboAreaTecnologica
Public Function AreaTecnologica(nome, todos)
	dim sSQL
	sSQL = "select at_id as valor,at_nome as descricao from area_tecnologica ORDER BY at_nome"
	AreaTecnologica = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga comboTipoTeste
Public Function TipoTeste(nome, padrao, todos)
	dim sSQL
	sSQL = "select tit_id as valor, tit_descricao as descricao from Tipo_Teste ORDER BY tit_descricao"
	TipoTeste = Me.PadraoSql(nome, sSQL, padrao, todos)
End Function

'antiga comboOrgaoHierarquia
Public Function OrgaoHierarquia(nome, todos)
	dim sSQL
	sSQL = "select orga_id as valor, (case when orga_hierarquia is not null then '(' + cast(orga_hierarquia as varchar) + ') ' else '' end) + orga_sigla + ' - ' + orga_descricao as descricao from orgao order by orga_hierarquia, orga_sigla"
	OrgaoHierarquia = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga ComboOrgao
Public Function Orgao(nome, todos)
	dim sSQL
	sSQL = "select orga_id as valor,orga_sigla + ' - ' + orga_descricao as descricao from orgao order by orga_sigla"
	Orgao = Me.PadraoSql(nome, sSQL, "", todos)
End Function

'antiga ComboData
Public Function Data(nome)
	Dim i, auxi, cbano

    buffer = _
	    "<select name='dia" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
	    "   <option value=''>Dia</option>" & VbCrLf

    for i=1 to 31
	    If i < 10 Then
		    auxi = "0" & i
		Else
			auxi = i
		End If
		buffer = buffer & "    <option value='" & auxi & "'>" & auxi & "</option>" & VbCrLf
	Next

    buffer = buffer & _
    	"</select>" & VbCrLf

    buffer = buffer & _
	    "<select name='mes" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		    opt_meses(10) & VbCrLf & _
	    "</select>&nbsp;"

    buffer = buffer & _
	    "<select name='ano" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"    <option value=''>Ano</option>" & VbCrLf
    For i=-1 To 10
        cbano = year( now ) - i
        buffer = buffer & "   <option value='" & cbano & "'>" & cbano & "</option>"
    Next

    buffer = buffer & _
	    "</select>"

    Data = buffer
End Function

Private Function itoa(num, tam)
	If isnull(num) Then
		itoa = ""
	Else
		itoa = cstr( num )
		If( Len( itoa ) < tam ) Then itoa = String( tam - Len( itoa ), "0" ) & itoa
	End If
End Function

Private Function opt_meses(ntabs)
	Dim i
	Dim meses : meses = Array( "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" )

	opt_meses = "<option value="""">M&ecirc;s</option>" & vbCrLf
	For i = 1 To 12
		opt_meses = opt_meses & String( ntabs, vbTab ) & "<option value=""" & itoa( i, 2 ) & """>" & server.HTMLencode( meses( i - 1 ) ) & "</option>" & vbCrLf
	Next
End Function

'antiga comboHorario
Public Function Horario(nome)
    buffer = _
	    "<select name='hora" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"    <option value=''>Hora</option>" & VbCrLf
    For i = 0 To 23
	    If i<10 Then
		    auxi = "0" & i
	    Else
		    auxi = i
	    End If

        buffer = buffer & "   <option value='" & auxi & "'>" & auxi & "</option>" & VbCrLf
    next

    buffer = buffer & _
	    "</select>&nbsp;:&nbsp;"

    buffer = buffer & _
	    "<select name='minuto" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"    <option value=''>Minuto</option>" & VbCrLf
    For i = 0 To 59
	    cbhora = i
	    If i<10 Then
		    auxi = "0" & i
	    Else
		    auxi = i
	    End If
        buffer = buffer & "    <option value='" & auxi & "'>" & auxi & "</option>"
    Next

    buffer = buffer & _
	    "</select>" & VbCrLf

    Horario = buffer
End Function

'antiga comboCriticidade
Public Function Criticidade(nome)
    Criticidade = _
	    "<select name='" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"    <option value='' selected>--</option>" & VbCrLf & _
		"    <option value='1'>1 - Baixa</option>" & VbCrLf & _
		"    <option value='2'>2 - M&eacute;dia</option>" & VbCrLf & _
		"    <option value='3'>3 - Alta</option>" & VbCrLf & _
	    "</select>" & VbCrLf
End Function

'antiga comboEstadoOCorrencia
Public Function EstadoOcorrencia(nome)
    buffer = "<select name=' " & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		     "<option value='' selected>--</option>" & VbCrLf & _ 
		     "<option value='NO'>Nova Ocorrência</option>" & VbCrLf & _
		     "<option value='EA'>Em Análise</option>" & VbCrLf & _
		     "<option value='C'>Concluido</option>" & VbCrLf & _
	         "</select>" & VbCrLf
    EstadoOcorrencia = buffer
End Function


'+-----------------------------------------------------------------------------------------
'+ SCE
'+-----------------------------------------------------------------------------------------

'-- monta combo de fornecedores
Public Function Fornecedor(ByVal nome, ByVal padrao, ByVal todos, ByVal tipo, ByVal completa)
	Dim ssql

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

	Fornecedor = PadraoSql(nome, sSQL, padrao, todos)
End Function


'-- monta uma combo de fornecedores mais avançada
Public Function FornecedorFiltroCnpjDescricao(nome, padrao, todos, tipo, completa, cnpj, descricao)
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
			"from sce_empresa_nota_fiscal " & _
			"where 1 = 1 "

	If cnpj <> "" Then ssql = ssql & "AND enf_cnpj LIKE '%" & cnpj & "%' "
	If descricao <> "" Then ssql = ssql & "AND enf_nome LIKE '%" & ucase(descricao) & "%' "

	if ucase(tipo) = "FORNECEDOR" then
		ssql = ssql & "AND enf_tipoempresa = 'F' "
	elseif ucase(tipo) = "TRANSPORTADORA" then
		ssql = ssql & "AND enf_tipoempresa = 'T' "
	end if

	ssql = ssql & "order by enf_nome, enf_cidade"

	FornecedorFiltroCnpjDescricao = PadraoSql(nome, sSQL, padrao, todos)
End Function

'antiga comboAgendamentoJS
'cria a busca em javascript de uma combo
Private Function MeusAgendamentosJS(nomeText, nomeCombo)

    buffer = _
        "<script l" & "anguage='javasc" & "ript'>" & VbCrLf & _
	    "function comboAgendamentoBuscaAS" & nomeText & "() {" & VbCrLf & _
		"    var frm = document.forms[0];" & VbCrLf & _
		"    var combo = frm." & nomeCombo & ";" & VbCrLf & _
		"    indice = -1;" & VbCrLf & _
		"    for(i=0; i<combo.length; i++)" & VbCrLf & _
		"	    if (combo[i].value == frm." & nomeText & ".value)" & VbCrLf & _
		"	    indice = i;" & VbCrLf & _
        "" & VbCrLf & _
		"    if (indice != -1)" & VbCrLf & _
	  	"	    combo.options[indice].selected = true" & VbCrLf & _
		"    else" & VbCrLf & _
		"	    combo.options[0].selected = true" & VbCrLf & _
	    "}" & VbCrLf & _
	    "</scr" & "ipt>" & VbCrLf & _
	    "<input class='" & p_classe & "' type='Text' name='" & nomeText & "' size='4' onKeyUp='comboAgendamentoBuscaAS" & nomeText & "();'>&nbsp;" & VbCrLf

    MeusAgendamentosJS = buffer
End Function

'antiga comboAgendamento
'combo dos agendamentos do usuário
Public Function MeusAgendamentos(meuAgendamento, nomeText, nomeCombo, padrao, todos)
	Dim where

	If meuAgendamento Then
		where = "UPPER(AG_RESPONSAVEL) = '" & Env.Usuario & "' "
	Else
		'where = "UPPER(AG_RESPONSAVEL) <> '" & Env.Usuario & "' "
		where = "1 = 1 "
	End If

	MeusAgendamentos = MeusAgendamentosJS(nomeText, nomeCombo)

	MeusAgendamentos = MeusAgendamentos & Me.PadraoSql(nomeCombo, _
		"select AG_NUMERO as VALOR, Cast(AG_NUMERO as VARCHAR(10)) + '-' + AG_TITULO AS DESCRICAO " & _
		"from Agendamento where " & where & " order by AG_NUMERO desc", padrao, todos)
		'"CASE WHEN AG_OBJETIVO IS NULL THEN '' ELSE ' - ' + SUBSTRING(AG_OBJETIVO, 1, 50) END as DESCRICAO "
End Function

'-- monta combo de Nota Fiscal
Public Function NotaFiscal(nomeText, nomeCombo, padrao, todos, tipoNF, filtroFornecedor)
	Dim sSQL, where
	Dim buf

    buf = _
	    "<script language='JavaScript'>" & VbCrLf & _
	    "function comboNotaFiscalBuscaNF() {" & VbCrLf & _
		"    var frm = document.forms[0];" & VbCrLf & _
		"    var combo = frm." & nomeCombo & ";" & VbCrLf & _
		"    indice = -1;" & VbCrLf & _
		"    for(i=0; i<combo.length; i++)" & VbCrLf & _
		"	    if (combo[i].text.substr(0, frm." & nomeText & ".value.length) == frm." & nomeText & ".value)" & VbCrLf & _
		"		    indice = i;" & VbCrLf & _
        "" & VbCrLf & _
		"    if (indice != -1)" & VbCrLf & _
	  	"	    combo.options[indice].selected = true" & VbCrLf & _
		"    else" & VbCrLf & _
		"	    combo.options[0].selected = true" & VbCrLf & _
	    "}" & VbCrLf & _
	    "</script>" & VbCrLf & _
	    "<input class='" & p_classe & "' type='Text' name='" & nomeText & "' size='4' onKeyUp='comboNotaFiscalBuscaNF();'>&nbsp;" & VbCrLf

	if tipoNF = NF_ENTRADA then
		where = "where NF_TIPO = " & NF_ENTRADA
	elseif tipoNF = NF_SAIDA then
		where = "where NF_TIPO = " & NF_SAIDA
	else
		where = ""
	end if

	if filtroFornecedor <> "" then
		if where = "" then
			where = "where "
		else
			where = where & " and "
		end if
		where = where & "e.ENF_ID = " & filtroFornecedor & " "
	end if

	sSQL =	"select nf_id as VALOR, CAST(nf.nf_numeronota as VARCHAR) + " & _
			"' - ' + e.enf_nome as DESCRICAO from sce_nota_fiscal nf inner join " & _
			"sce_empresa_nota_fiscal e on e.enf_id = nf.enf_id " & where & " " & _
			"order by nf.nf_numeronota"

    NotaFiscal = buf & PadraoSql(nomeCombo, sSQL, padrao, todos)
    'NotaFiscal = PadraoSql(nomeCombo, sSQL, padrao, todos)
End Function

Public Function EquipamentoConforme(nome, mesmalinha)
    buffer = _
	    "Conforme" & IIf(mesmalinha, ":&nbsp;", "<br>") & VbCrLf & _
	    "<select name='" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"    <option value=''>Todos</option>" & VbCrLf & _
		"    <option value='1'>Sim</option>" & VbCrLf & _
		"    <option value='0'>Não</option>" & VbCrLf & _
	    "</select>" & VbCrLf
    EquipamentoConforme = buffer
End Function

Public Function PropriedadeEquipamento(nome, mesmalinha)
    buffer = _
	    "Propriedade" & IIf(mesmalinha, ":&nbsp;", "<br>") & VbCrLf & _
	    "<select name='" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
	    "	<option value=''>Todos</option>" & VbCrLf & _
	    "	<option value='" & EQ_PROPRIEDADE_TER & "'>Terceiros</option>" & VbCrLf & _
	    "	<option value='" & EQ_PROPRIEDADE_COM & "'>" & Application("SISLAB_NOME_EMPRESA") & " - Comodato</option>" & VbCrLf & _
	    "	<option value='" & EQ_PROPRIEDADE_CRT & "'>" & Application("SISLAB_NOME_EMPRESA") & " - CRT</option>" & VbCrLf & _
	    "	<option value='" & EQ_PROPRIEDADE_EBT & "'>" & Application("SISLAB_NOME_EMPRESA") & " - Outros</option>" & VbCrLf & _
	    "	<option value=""'" & EQ_PROPRIEDADE_COM & "','" & EQ_PROPRIEDADE_EBT & "','" & EQ_PROPRIEDADE_CRT & "'"">" & Application("SISLAB_NOME_EMPRESA") & " - Todos</option>" & VbCrLf & _
	    "</select>" & VbCrLf
	PropriedadeEquipamento = buffer
End Function

Public Function SituacaoEquipamento(nome, mesmalinha, todos, mostraCadastrado, padrao)
    buffer = _
	    "Situação" & IIf(mesmalinha, ":&nbsp;", "<br>") & VbCrLf & _
	    "<select name='" & nome & "' class='" & p_classe & "'>" & VbCrLf & _
		"   <option value=''>" & IIf(todos, "Todos", "--") & "</option>" & VbCrLf

	If mostraCadastrado Then
        buffer = buffer & _
            "   <option value='" & STATUS_CADASTRADO & "' " & IIf(padrao = STATUS_CADASTRADO, "selected", "") & ">Cadastrado</option>" & VbCrLf
	End If

    buffer = buffer & _
        "   <option value='" & STATUS_EM_ESTOQUE & "' " & IIf(padrao = STATUS_EM_ESTOQUE, "selected", "") & ">Em estoque</option>" & VbCrLf & _
	    "   <option value='" & STATUS_EM_USO & "' " & IIf(padrao = STATUS_EM_USO, "selected", "") & ">Em uso</option>" & VbCrLf & _
	    "   <option value='" & STATUS_EXPEDIDO & "' " & IIf(padrao = STATUS_EXPEDIDO, "selected", "") & ">Expedido</option>" & VbCrLf & _
	    "   <option value='" & STATUS_EXPEDIDO_SUBST & "' " & IIf(padrao = STATUS_EXPEDIDO_SUBST, "selected", "") & ">Substituído</option>" & VbCrLf & _
        "</select>" & VbCrLf

    SituacaoEquipamento = buffer
End Function

Public Function SimNaoInstrumental(nome, mesmalinha)
    buffer = _
		"Instrumental" & IIf(mesmalinha, ":&nbsp;", "<br>") & VbCrLf & _
		"<select name='instrumental' class='" & p_classe & "'>" & VbCrLf & _
		"	<option value=''>Todos</option>" & VbCrLf & _
		"	<option value='1'>Sim</option>" & VbCrLf & _
		"	<option value='0'>Não</option>" & VbCrLf & _
		"</select>" & VbCrLf

    SimNaoInstrumental = buffer
End Function

Public Function AmostraEquipamento(nome, mesmalinha)
    buffer = _
		"Eq. Setup" & IIf(mesmalinha, ":&nbsp;", "<br>") & VbCrLf & _
		"<select name='setup' class='" & p_classe & "'>" & VbCrLf & _
		"	<option value=''>Todos</option>" & VbCrLf & _
		"	<option value='" & EQSETUP_AMOSTRA & "'>Amostra</option>" & VbCrLf & _
		"	<option value='" & EQSETUP_EQUIPAMENTO & "'>Equipamento</option>" & VbCrLf & _
		"</select>" & VbCrLf

    AmostraEquipamento = buffer
End Function

End Class
%>
