<%
'+-----------------------------------------------------------------------------------------------------
'+ Classe criada para armazenar as rotinas e informações do Módulo SCE
'+
'+ dependencia: Classe_Environment.asp
'+ 05/04/2012
'+-----------------------------------------------------------------------------------------------------
Class TSce

Private bln_TemErro
Private chr_MsgErro
Private p_classe

'-------------------------------------------------------------------------
Private Sub Class_Initialize()
    bln_TemErro = False
    chr_MsgErro = ""
    p_classe = "texto1"
End Sub

Private Sub Class_Terminate()
End Sub

'-------------------------------------------------------------------------
Public Property Let SetClasse(classe)
	p_classe = classe
End Property

'-------------------------------------------------------------------------

'Defino as regras entre o Tipo de Movimentação e o STATUS dos equipamentos/acessórios
Public Function Maquina_de_Estados(notipo)
	dim status_equipamento

	status_equipamento = cint(notipo)

	if (status_equipamento = cint(MOV_ENTRADA)) or (status_equipamento = cint(MOV_LOGISTICA_ENTRADA)) then
		status_equipamento = cint(STATUS_EM_ESTOQUE)  '-- estoque

	elseif status_equipamento = cint(MOV_EXPEDICAO) then '-- expedicao
		status_equipamento = cint(STATUS_EXPEDIDO)      '-- expedido

	elseif status_equipamento = cint(MOV_EXPEDICAO_SUBST) then '-- expedicao com substituicao
		status_equipamento = cint(STATUS_EXPEDIDO_SUBST)      '-- expedido com substituicao

	else '-- logistica saida
		status_equipamento = cint(STATUS_EM_USO) '-- em uso
	end if

	Maquina_de_Estados = status_equipamento
End Function

Public Function VerificaReservaItem(apenasConta, agendamento, item, ehHTML)
	'-- Retorno a lista de agendamentos na qual um determinado item esta reservado.
	'-- OBS: a reserva é passada caso a mesma esteja sendo alterada,
	'-- caso seja vazio significa uma nova reserva

	Dim rec, s, retorno
	if apenasConta then
		s =	"SELECT DISTINCT count(*) "
	else
		s =	"SELECT re.AG_NUMERO, r.RES_RESPONSAVEL, " & _
			"CONVERT(VARCHAR, re.REQ_DATAINICIO, 103) AS AG_DATAINICIO, " & _
			"CONVERT(VARCHAR, re.REQ_DATATERMINO, 103) AS AG_DATATERMINO "
	end if

	s = s & _
		"FROM SCE_Reserva_Equipamentos re inner join SCE_Reserva_Equipamentos re1 " & _
			"on (re.EQ_ID = re1.EQ_ID and re1.AG_NUMERO <> re.AG_NUMERO) " & _
			"inner join SCE_Reserva r on r.AG_NUMERO = re.AG_NUMERO " & _
		"WHERE ((re.REQ_DATAINICIO BETWEEN re1.REQ_DATAINICIO AND re1.REQ_DATATERMINO) " & _
			"OR (re.REQ_DATATERMINO BETWEEN re1.REQ_DATAINICIO AND re1.REQ_DATATERMINO)) " & _
			"AND re.REQ_MOVIMENTOU = 0 AND re1.EQ_ID = " & item & " AND " & _
			"re1.AG_NUMERO = " & agendamento & " "

	if not apenasConta then _
		s = s & "ORDER BY re.AG_NUMERO, re.REQ_DATAINICIO, re.REQ_DATATERMINO"

'response.write s
'response.end

	Set rec = Env.oConn.execute(s)

	retorno = ""

	if apenasConta then
		if rec(0) > 0 then retorno = cstr(rec(0))
	else
		while not rec.eof
			retorno = retorno & rec("AG_NUMERO") & " (" & rec("RES_RESPONSAVEL") & _
				" - " & rec("AG_DATAINICIO") & " até " & rec("AG_DATATERMINO") & ")"
			rec.MoveNext
			if not rec.eof then retorno = retorno & ", "
		wend
	end if

	rec.Close
	set rec = nothing

	retorno = Trim(retorno)
	if ehHTML then retorno = replace(retorno, " ", "&nbsp;")
	if ehHTML and retorno = "" then retorno = "&nbsp;"

	VerificaReservaItem = retorno
End Function

Public Function ImprimeStatusItem(rec)
    Dim buf
    Dim status, localiz, retorno

	if isNull(rec("STATUS")) then
	    status = -1
	else
	    status = rec("STATUS")
	end if
	if isNull(rec("EQ_LOCALIZACAO")) then
	    localiz = ""
	else
	    localiz = rec("EQ_LOCALIZACAO")
	end if

	if status = STATUS_EM_USO then
	    if not isNull(rec("AG_NUMERO")) then
	        retorno = rec("AG_NUMERO")
	    end if
		if not isNull(rec("MOV_SOLICITANTE")) then
		    if retorno <> "" then retorno = retorno & " - "
			retorno = retorno & Trim(rec("MOV_SOLICITANTE"))
		end if

		if retorno <> "" then
			buf = "Em Uso" & "<br>" & retorno
		else
			buf = "Em Uso"
		end if

	elseif status = STATUS_EM_ESTOQUE then
			'if ehHTML then retorno = "Em Estoque" & "<br>" & local else retorno = "Em Estoque - " & localiz
            buf = "Em Estoque" & "<br>" & localiz

	elseif status = STATUS_EXPEDIDO then
			buf = "Expedido"

	elseif status = STATUS_EXPEDIDO_SUBST then
			buf = "Substituído"

	elseif status = STATUS_CADASTRADO then
			'if ehHTML then buf = "Cadastrado" & "<br>" & localiz else buf = "Cadastrado - " & localiz
			buf = "Cadastrado" & "<br>" & localiz
	end if

	'if ehHTML then retorno = replace(retorno, " ", "&nbsp;")
	'if ehHTML and retorno = "" then retorno = "&nbsp;"

    ImprimeStatusItem = buf
End Function

Public Function PegaStatusItem(item, ehHTML)
	'-- Retorno o RT´s que foi o responsavel pela saida do material da logistica

	Dim rec, s, status, local
	Dim retorno : retorno = ""

	if item <> "" then
		s = "SELECT STATUS, EQ_LOCALIZACAO FROM SCE_Equipamentos WHERE EQ_ID = " & item
		Set rec = Env.oConn.execute(s)
		if not (rec.eof and rec.bof) then
			if isNull(rec("STATUS")) then status = -1 else status = rec("STATUS")
			if isNull(rec("EQ_LOCALIZACAO")) then local = "" else local = rec("EQ_LOCALIZACAO")
		end if
		rec.Close

		if status = STATUS_EM_USO then
			'-- PEGO A ULTIMA MOVIMENTACAO DO ITEM
			s =	"SELECT m.ASA AS AG_NUMERO, MOV_SOLICITANTE FROM vw_SCE_Movimentacao_Atual m " & _
				"INNER JOIN SCE_Natureza_Operacao n ON n.NO_ID = m.NO_ID " & _
				"WHERE n.NO_TIPO = " & MOV_LOGISTICA_SAIDA & " AND EQ_ID = " & item & " "
			Set rec = Env.oConn.execute(s)

			if not (rec.eof and rec.bof) then
				if not isNull(rec("AG_NUMERO")) then retorno = rec("AG_NUMERO")
				if not isNull(rec("MOV_SOLICITANTE")) then
					if retorno <> "" then retorno = retorno & " - "
					retorno = retorno & Trim(rec("MOV_SOLICITANTE"))
				end if
			end if

			if retorno <> "" then
				if ehHTML then retorno = "Em Uso" & "<br>" & retorno else retorno = "Em Uso - " & retorno
			else
				retorno = "Em Uso"
			end if
			rec.Close

		elseif status = STATUS_EM_ESTOQUE then
			if ehHTML then retorno = "Em Estoque" & "<br>" & local else retorno = "Em Estoque - " & local

		elseif status = STATUS_EXPEDIDO then
			retorno = "Expedido"

		elseif status = STATUS_EXPEDIDO_SUBST then
			retorno = "Substituído"

		elseif status = STATUS_CADASTRADO then
			if ehHTML then retorno = "Cadastrado" & "<br>" & local else retorno = "Cadastrado - " & local

		end if
	end if

	retorno = Trim(retorno)
	if ehHTML then retorno = replace(retorno, " ", "&nbsp;")
	if ehHTML and retorno = "" then retorno = "&nbsp;"

	PegaStatusItem = retorno
End Function

Public Function ResponsavelAS(ag_numero)
	Dim s, objRS
	s = "SELECT AG_RESPONSAVEL FROM Agendamento where AG_NUMERO = " & ag_numero
	Set objRS = Env.oConn.Execute(s)
	if not (objRS.Eof and objRS.Bof) then _
		if IsNull(objRS("AG_RESPONSAVEL")) then ResponsavelAS = "" else ResponsavelAS = objRS("AG_RESPONSAVEL")
	objRS.Close
	Set objRS = Nothing
End Function

Public Function ReservaFechada(ag_numero)
	Dim s, objRS, total, total_mov
	s = "SELECT count(*) FROM SCE_Reserva_Equipamentos where AG_NUMERO = " & ag_numero
	Set objRS = Env.oConn.Execute(s)
	total = objRS(0)
	objRS.Close
	s = "SELECT count(*) FROM SCE_Reserva_Equipamentos where REQ_MOVIMENTOU = 1 AND AG_NUMERO = " & ag_numero
	Set objRS = Env.oConn.Execute(s)
	total_mov = objRS(0)
	Set objRS = Nothing
'	if total = total_mov then ReservaFechada = True else ReservaFechada = False
	ReservaFechada = (total = total_mov)
End Function

Public Function PegaNotaFiscalItem(item)
	Dim objRS, s
	s =	"SELECT DISTINCT nf.NF_NUMERONOTA FROM SCE_Nota_Fiscal nf " & _
			"INNER JOIN SCE_Movimentacao m ON m.NF_ID = nf.NF_ID " & _
			"WHERE m.EQ_ID = " & item & " ORDER BY nf.NF_NUMERONOTA"
	Set objRS = Env.oConn.Execute(s)
	PegaNotaFiscalItem = ""
	if not (objRS.Eof and objRS.Bof) then
		while not objRS.Eof
			PegaNotaFiscalItem = PegaNotaFiscalItem & objRS(0)
			objRS.MoveNext
			if not objRS.Eof then PegaNotaFiscalItem = PegaNotaFiscalItem & ", "
		wend
	end if
	objRS.Close
	Set objRS = Nothing
	PegaNotaFiscalItem = Trim(PegaNotaFiscalItem)
End Function

'deixei a titulo de compatibilidade com algumas telas
Public Function ImprimeConteudoTela
%>
<script type="text/javascript">
    function imprimeConteudoSCE() {
        // Esconde o menu e o cabecalo do sistema deixando apenas a parte
        // do conteudo, chamando o metodo de impressao
        var undef; var w;

        //		document.all.tr_princ_cabecalho.style.display = "none";

        if (document.all.tr_princ_cabecalho_menu != undef)
            document.all.tr_princ_cabecalho_menu.style.display = "none";
        if (document.all.tr_princ_cabecalho_separador1 != undef)
            document.all.tr_princ_cabecalho_separador1.style.display = "none";
        if (document.all.tr_princ_cabecalho_separador2 != undef)
            document.all.tr_princ_cabecalho_separador2.style.display = "none";
        if (document.all.tr_princ_cabecalho_nometela != undef)
            document.all.tr_princ_cabecalho_nometela.style.display = "none";
        if (document.all.tr_princ_rodape != undef)
            document.all.tr_princ_rodape.style.display = "none";

        w = document.all.div_telaprincipal.style.width;
        document.all.div_telaprincipal.style.width = "640px";

        window.print();

        document.all.div_telaprincipal.style.width = w;

        //		document.all.tr_princ_cabecalho.style.display = "block";

        if (document.all.tr_princ_cabecalho_menu != undef)
            document.all.tr_princ_cabecalho_menu.style.display = "block";
        if (document.all.tr_princ_cabecalho_separador1 != undef)
            document.all.tr_princ_cabecalho_separador1.style.display = "block";
        if (document.all.tr_princ_cabecalho_separador2 != undef)
            document.all.tr_princ_cabecalho_separador2.style.display = "block";
        if (document.all.tr_princ_cabecalho_nometela != undef)
            document.all.tr_princ_cabecalho_nometela.style.display = "block";
        if (document.all.tr_princ_rodape != undef)
            document.all.tr_princ_rodape.style.display = "block";
    }
</script>
<%
End Function

Public Function LinkEquipamento(codEquipamento, texto, novaJanela)
    LinkEquipamento = "<a href='cad_acess_item.asp?eq_id=" & codEquipamento & "' class='" & p_classe & "'" & IIf(novaJanela, " target='_blank'", "") & ">" & texto & "</a>"
End Function

'-- UTILIZADA PELAS TELAS DE CADASTRO DE RESERVA DE ITENS --
Public Function MarcaItemReservado(reservado, linhaTabela)
	Dim color

	if reservado then color = "#FF0000" else color = "#000000"
%>	<script type="text/javascript">
  	    f.document.all["linha_<%=linhaTabela%>"].style.color = '<%=color%>';
  	    f.document.all["item_<%=linhaTabela%>"].style.color = '<%=color%>';
  	    f.document.all["dt_ini_<%=linhaTabela%>"].style.color = '<%=color%>';
  	    f.document.all["dt_fim_<%=linhaTabela%>"].style.color = '<%=color%>';
  	    f.document.all["cmb_setup_<%=linhaTabela%>"].style.color = '<%=color%>';
	</script>
<%
End Function

End Class
%>