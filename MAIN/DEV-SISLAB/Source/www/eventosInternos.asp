<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
dim auxas,AUXrs,msSQL,combo

	select case cint(request("hdnEvento"))
			case 1
				call recuperaInfomacoesASUpload()
			case 2
				call recuperaInformacoesOSUpload()
			case 3 
				call recuperaMensagemsEmail()
			case 4
				call SalvaMensagemEmail()
			case 5
				call recuperaMensagemsAS(false)
			case 6
				call recuperaMensagemsAS(true)
			case 7
				call BuscaUserNameEBT()
			case 8
				call MostraHistoricoArquivo()
			case 9
				'-- vazio
			case 10
				call MostraHistoricoOS()
			case 11
				call apagaOrdemdeServico()
			case 12
				call MostraHistoricoAS()
			case 13
				call MostraDFD()
			case 14
				call MontaListaPlataformaEquipamento(request("mod_id"))
			case 15
				Call RecuperaMensagem
			case 16
				Call SalvaMensagem
	End Select


'XXXXXXXXXXXXXXXXXXX   FUNÇÕES   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

'-- preenche a lista de equipamentos da tela Cadastro de Equipamentos em Plataformas
Function MontaListaPlataformaEquipamento(mod_id)
	mod_id = request("mod_id")
	if mod_id <> "" Then
		s =	"SELECT EQ_ID, EQ_CODIGOBARRAS, MOD_CODNOME, MOD_DESCRICAO " & _
			"FROM SCE_Equipamentos e INNER JOIN SCE_Modelos m ON e.MOD_ID = m.MOD_ID " & _
			"WHERE m.MOD_ID = " & mod_id & " " & _
			"ORDER BY MOD_DESCRICAO, EQ_CODIGOBARRAS;"
		call Env.RecordSet(true, objRS, s)
		Response.Write "<scr" & "ipt lan" & "guage='JavaSc" & "ript'>" & VbCrLf
		Response.Write "var ultimo = 0;" & VbCrLf
		Response.Write "var lista = parent.document.all.eq_disp;" & VbCrLf
		Response.Write "lista.options.length = 0;" & VbCrLf
		while not objRS.Eof
			Response.Write "ultimo = lista.options.length;" & VbCrLf
			Response.Write "lista.options[ultimo] = new Option('" & objRS("EQ_CODIGOBARRAS") & " - " & objRS("MOD_CODNOME") & " - " & objRS("MOD_DESCRICAO") & "');" & VbCrLf
			Response.Write "lista.options[ultimo].value = '" & objRS("EQ_ID") & "';" & VbCrLf
			'Response.Write "lista.options[ultimo].title = '" & objRS("EQ_CODIGOBARRAS") & " - " & objRS("MOD_CODNOME") & " - " & objRS("MOD_DESCRICAO") & "';" & VbCrLf
			objRS.MoveNext
		wend
		call Env.RecordSet(false, objRS, null)
		Response.Write "</scr" & "ipt>" & VbCrLf
	End If
End Function


function MostraDFD()%>
	<html>
		<head>
		<title>DTE - SISLAB</title>
		<script type="text/javascript">
		function jczResetWindow(bmp) {
			self.moveTo(2,2); 
			self.resizeTo(bmp.width+50,bmp.height+70);
		}
		</script>
	</head>
	<!--<body onLoad="jczResetWindow(bmp);" >-->
	<body>
		<img src="img/dtecrt.jpg" name="bmp">
	</body>
	</html>
<%
end function

function apagaOrdemdeServico()
	Dim rs
	num_ag = request("num_ag")
	num_os = request("num_os")
	ssql = "exec sp_ApagaOrdemDeServico " & num_ag & "," & num_os
	Set rs = Env.oConn.execute(ssql)
	%>
	<html><body><form>
	<script type="text/javascript">
<%	if not (rs.Eof and rs.Bof) then
		if rs(0) < 0 then%>
		alert("Não foi possível excluir a OS solicitada");
<%		end if
	end if%>
		parent.Recarrega();
	</script>
	</form></html></body>
	<%
end function

function MostraHistoricoArquivo()
	arquivo = request("arquivo")
	sSQL = "select * from historico_arquivos where ha_codarq = " & arquivo & " and ha_acao = 'Validar' ORDER BY HA_DATAATUALIZACAO;"
	call Env.RecordSet( true, AUXrsha, sSQL)

	sSQL = "select * from arquivos where arq_codarq = " & arquivo & ";"
	call Env.RecordSet( true, AUXrsar, sSQL)
	response.write "<title>Histórico Arquivos</title><font size='-1' face='Verdana'>"
	if AUXrsar.eof = false then
		str = "<B>Documento Aprovado em :</B> " & AUXrsar("arq_dataaprovacao") & "<br>" & _
			  "Responsável pela Aprovação : " & AUXrsar("arq_responsavel")  & "<br><br>"
	end if

	while  AUXrsha.eof = false 
		str = str & "<B>Documento Validado em : </B>" & AUXrsha("ha_dataatualizacao") & "<br>" & _
	  			    "Responsável pela Validação : " & AUXrsha("ha_usuario")  & "<br><br>"
		AUXrsha.movenext
	wend
	response.write str
end function

function MostraHistoricoOS()
	num_os = request("num_os")
	num_ag = request("num_ag")

	ssql = "select * from historico_eventosos h inner join situacoes s on h.id_situacao = s.id_situacao where OS_ID = " & num_os &  " and ag_numero = " & NUM_AG & ""
	call Env.RecordSet( true, objrs, sSQL)
	response.write "<title>Histórico Ordem de Serviço</title><font size='-1' face='Verdana'>"
	while objrs.eof = false 
		str = str & "<B>Situação : </B>" & objrs("s_descricao") & "<br>" & _
	  			    "Data Inicio : " & objrs("HEOS_DATAINICIO")  & "<br>"
					if objrs("HEOS_DATATERMINO") <> "" then
	  			    		str = str & "Data Término : " & objrs("HEOS_DATATERMINO")  & "<br>"
					end if
		str = str & "Motivo : " & objrs("HEOS_Motivo") & "<br><br>"
		objrs.movenext
	wend
	response.write str
end function

function MostraHistoricoAS()
	num_ag = request("num_ag")

	ssql = "select * from historico_eventos h inner join situacoes s on h.id_situacao = s.id_situacao where ag_numero = " & NUM_AG & ""
	call Env.RecordSet( true, objrs, sSQL)
	response.write "<title>Histórico Ordem de Serviço</title><font size='-1' face='Verdana'>"
	while objrs.eof = false 
		str = str & "<B>Situação : </B>" & objrs("s_descricao") & "<br>" & _
	  			    "Data Inicio : " & objrs("HE_DATAINICIO")  & "<br>"
					if objrs("HE_DATATERMINO") <> "" then
	  			    		str = str & "Data Término : " & objrs("HE_DATATERMINO")  & "<br>"
					end if
		str = str & "Motivo : " & objrs("HE_Motivo") & "<br><br>"
		objrs.movenext
	wend
	response.write str
end function

function BuscaUserNameEBT()
	dim username,ebt1
	dim ag_numero, objRS, sSQL, qualLista, ExisteNaBase

	ExisteNaBase = False

	username = trim(request("nome"))
	nomeControle = trim(request("nomeControle"))
	ag_numero = Trim(request("ag_numero"))	'-- preciso do agendamento para comparar com a base de dados
											'-- caso esteja vazio é um novo agendamento

	Set ebt1 = New TEbt

    Call ebt1.LoginUsuario(username)
	nomeReduzido = Ebt1.NomeReduzido
	username = Ebt1.Usuario()

	If Not Ebt1.ehFuncionario() Then%>
		<script type="text/javascript">
			alert("Funcionário inexistente na Embratel.");
		</script>
<%	Else
		if ag_numero <> "" then
			sSQL = _
				"SELECT * FROM PARTICIPANTES_EXTERNOS WHERE PE_EMPRESA = 'EBT' AND " & _
				"PE_USERNAME = '" & ucase(username) & "' AND AG_NUMERO = " & ag_numero
			Call Env.RecordSet(true, objRS, sSQL)

			If not (objRS.Eof and objRS.Bof) then
				ExisteNaBase = True
				if IsNull(objRS("PE_QUEMINCLUIU")) then
					qualLista = "Cliente"
				elseif objRS("PE_QUEMINCLUIU") = "CLI" then
					qualLista = "Cliente"
				elseif objRS("PE_QUEMINCLUIU") = "RTE" then
					qualLista = "Responsável Técnico"
				elseif objRS("PE_QUEMINCLUIU") = "RAT" then
					qualLista = "RAT"
				end if%>
			<script type="text/javascript">
				alert("Este usuário já está incluído na lista de <%=qualLista%>");
			</script>
<%			End If

			Call Env.RecordSet(false, objRS, null)
		End If

		If Not ExisteNaBase Then%>
			<script type="text/javascript">
				var frm = parent.document.forms[0];
				var nome = frm.txtNome<%=nomeControle%>;
				var motivo = frm.txtMotivo<%=nomeControle%>;
				var lista = frm.lst<%=nomeControle%>;
				var ultimo;
				ultimo = lista.options.length;
				lista.options[ultimo] = new Option('<%=ucase(username)%>' + ' <%=SEPARADOR_CAMPO%> ' + '<%=nomeReduzido%>' + ' <%=SEPARADOR_CAMPO%> ' + motivo.value);
				lista.options[ultimo].value = '<%=ucase(username)%>' + '<%=SEPARADOR_CAMPO%>' + '<%=nomeReduzido%>' + '<%=SEPARADOR_CAMPO%>' + motivo.value;
				lista.options[ultimo].title = '<%=ucase(username)%>' + '<%=SEPARADOR_CAMPO%>' + '<%=nomeReduzido%>' + '<%=SEPARADOR_CAMPO%>' + motivo.value;
				nome.value = "";
				motivo.value = "";
				nome.focus();
			</script>
<%	    End If
	End If

	Set ebt1  = Nothing
End Function


Function SalvaMensagemEmail()
	dim mensagem
	s_descricao = request("s_descricao")
	s_os = 0
	if request("s_os") then	s_os = 1
	mensagem = replace(request("mensagem"),"\n",vbcrlf)
	mensagem = replace(request("mensagem"),"<br>",vbcrlf)
	mensagem = replace(request("mensagem"),"'","")
	'mensagem = replace(request("mensagem"),chr(34),"")	
	msSQL = "update situacoes set s_mensagem = '" & mensagem  & "' where s_descricao = '" & s_descricao & "' and s_os = " & s_os
	call Env.RecordSet(true, AUXrs, msSQL)%>
	<script type="text/javascript">
		alert("Mensagem alterada com sucesso!");
	</script>
<%
end function

Function  recuperaMensagemsAS(popUp)
	dim auxAs
	auxAs = request("txAS")
	sSQL = _
		"Select AG_RElat_RT, AG_RElat_RAT, AG_Numero, S_DESCRICAO, TA_DESCRICAO, AG_RETIFICACAO, AG_CLIENTEEXTERNO " & _
		"from vw_Agendamento a " & _
		"WHERE a.AG_Numero = " & CInt(trim(auxAs))
	call Env.RecordSet( true, AUXrs, sSQL)
	'RESPONSE.WRITE AUXrs("AG_RElat_RAT")
	'RESPONSE.END

	IF NOT AUXrs.EOF THEN
		auxrelatrat = replace(AUXrs("AG_RElat_RAT") & "","'","")
		auxrelatrat = replace(AUXrs("AG_RElat_RAT") & "",chr(34),"")	

		auxrelatrt = replace(AUXrs("AG_RElat_RT") & "","'","")
		auxrelatrt = replace(AUXrs("AG_RElat_RT") & "",chr(34),"")	

		if not popUp then
%>	
		<script type="text/javascript">
			var frm = parent.document.forms[0];
			frm.RelatRAT.disabled = false;
			frm.RelatRT.disabled = false;

			<%if not (AUXrs.eof) then%>
				frm.RelatRAT.value = "<%=replace(auxrelatrat & "",vbcrlf,"\n")%>";
				frm.RelatRT.value = "<%=replace(auxrelatrt & "",vbcrlf,"\n")%>";
			<%ELSE%>
				frm.RelatRAT.value = "";
				frm.RelatRAT.value = "";
			<%end if%>
			frm.btSubmit.disabled = false;
		</script><%
		else
%>
		<html>
            <title><%=TITULO_SITE%></title>
		<%if auxrelatrat <> "" then%>
			<font face="verdana" size="2" color="#000000">
			<b>Mensagem do RAT</b><br>
			<%=replace(auxrelatrat & "",vbcrlf,"<BR>")%><br><br>
		<%end if%>

		<%if auxrelatrt <> "" then%>
			<font face="verdana" size="2" color="#000000">
			<b>Mensagem do RT</b><br>
				<%=replace(auxrelatrt & "",vbcrlf,"<BR>")%><br><br>
		<%end if%>

			<div style="text-align: center">
		        <a href="javascript:window.close()">Fechar</a>
			</div>
		</html>
<%		end if
	ELSE
		if not popUp then
%>	
		<script type="text/javascript">
			var frm = parent.document.forms[0];
				frm.RelatRAT.value = "AS INEXISTENTE";
				frm.RelatRT.value = "AS INEXISTENTE";
				frm.RelatRAT.disabled = true;
				frm.RelatRT.disabled = true;
		</script><%
		END IF
	END IF
End function

function recuperaMensagemsEmail()
	s_descricao = request("s_descricao")
	s_os = 0
	if request("s_os") then	s_os = 1
	msSQL = "Select s_mensagem from situacoes where s_descricao = '" & s_descricao & "' and s_os = " & s_os
	call Env.RecordSet( true, AUXrs, msSQL)
%>
	<script type="text/javascript">
		<%if not (AUXrs.eof and AUXrs.bof) then%>
			var frm = parent.document.forms[0];
			frm.mensagem.value = '<%=replace(AUXrs("s_mensagem"),vbcrlf,"\n")%>';
			frm.mensagem.disabled = false;
			frm.botao.disabled = false;

		<%else%>
			var frm = parent.document.forms[0];
			frm.mensagem.value = '-- Situação Inexistente --';
			frm.mensagem.disabled = true;
			frm.botao.disabled = true;
		<%end if%>
	</script>
<%
end function

function recuperaInformacoesOSUpload()
	auxas = request("as")
	auxos = request("os")
	msSQL = "Select os_id as valor, os_id as descricao from ordem_de_servico where ag_numero = '" & auxas & "'"
	call Env.RecordSet( true, AUXrs, msSQL)
	combo = SubstituiComboCScript(request("label"),"cmbOs","OSCelula","","-------","valor","descricao",AUXrs,"atualizaOS()")
	msSQL3 = "SELECT COUNT(A.AG_NUMERO)+1 AS CONTADOR FROM AGENDAMENTO A INNER JOIN DIAGRAMAS D ON A.AG_NUMERO = D.AG_NUMERO INNER JOIN ARQUIVOS F ON F.ARQ_CODARQ = D.ARQ_CODARQ WHERE A.AG_NUMERO = " & auxas & " AND F.ARQ_CODARQTIPO = 8"
	call Env.RecordSet( true, AUXrs3, msSQL3)
		%>
		<script type="text/javascript">
			var frm = parent.document.forms[0];
			frm.contdia.value = "<%=AUXrs3("CONTADOR")%>";
			<%if combo then%>
				frm.cmbOs.focus();
				<%if auxos <> "" then%>
					frm.cmbOs.value = "<%=auxos%>";
				<%end if%>
			<%else%>
				frm.tipoarquivo.focus();
			<%end if%>
		</script>
	<%
end function

function recuperaInfomacoesASUpload()
	auxas = request("as")
	auxos = request("os")
	msSQL = "Select os_id as valor, os_id as descricao from ordem_de_servico where ag_numero = '" & auxas & "'"
	call Env.RecordSet( true, AUXrs, msSQL)

'response.write mssql
'response.end

	combo = SubstituiComboCScript(request("label"),"cmbOs","OSCelula","","-------","valor","descricao",AUXrs,"atualizaOS()")

	msSQL2 = "Select * from agendamento where ag_numero = " & auxas & ""
	call Env.RecordSet( true, AUXrs2, msSQL2)

	msSQL3 = "SELECT COUNT(A.AG_NUMERO)+1 AS CONTADOR FROM AGENDAMENTO A INNER JOIN DIAGRAMAS D ON A.AG_NUMERO = D.AG_NUMERO INNER JOIN ARQUIVOS F ON F.ARQ_CODARQ = D.ARQ_CODARQ WHERE A.AG_NUMERO = " & auxas & " AND F.ARQ_CODARQTIPO = 8"
	call Env.RecordSet( true, AUXrs3, msSQL3)

	%>
		<script type="text/javascript">
			var frm = parent.document.forms[0];
				<%if AUXrs2("AG_SIGILO") <> "0" then%>
					frm.chkconfidencial.checked = true;
				<%end if%>
			frm.responsavel.value = "<%=ucase(AUXrs2("AG_RESPONSAVEL"))%>";
			//frm.area.value = "<%'=AUXrs2("AT_ID")%>";
			//alert("<%'=replace(AUXrs2("AG_OBJETIVO"),vbcrlf,"\n") & ""%>");
			//frm.descricao.value = "<%'=replace(AUXrs2("AG_OBJETIVO"),vbcrlf,"\n") & ""%>";
			frm.contdia.value = "<%=AUXrs3("CONTADOR")%>";
			//frm.chkconfidencial.disabled = true;
			//frm.responsavel.disabled = true;
			//frm.area.disabled = true;
			//frm.responsavel.style.backgroundColor = "#EEEEEE";
			//frm.area.style.backgroundColor = "#EEEEEE";
				<%if combo then%>
					frm.cmbOs.focus();
					<%if auxos <> "" then%>
						frm.cmbOs.value = "<%=auxos%>";
					<%end if%>
				<%else%>
					frm.tipoarquivo.focus();
				<%end if%>
		</script>
		<%
end function

Function RecuperaMensagem()
	Dim msSQL
	Dim RS
	Dim id_msg

	id_msg = IIf(Request("s_descricao") = "", "0", Request("s_descricao"))
	msSQL = "Select TextoMensagem FROM Mensagem WHERE CodMensagem = " & id_msg & ""
	Set RS = Env.oConn.Execute(msSQL)
%>
	<script type="text/javascript">
		<%if not (RS.eof and RS.bof) then%>
			var frm = parent.document.forms[0];
			frm.mensagem.value = '<%=Replace(IIf(IsNull(RS("TextoMensagem")), "", RS("TextoMensagem")), vbcrlf, "\n")%>';
			frm.mensagem.disabled = false;
			frm.botao.disabled = false;
		<%else%>
			var frm = parent.document.forms[0];
			frm.mensagem.value = ''; // -- Mensagem não existe --';
			frm.mensagem.disabled = true;
			frm.botao.disabled = true;
		<%end if%>
	</script>
<%
	Set RS = Nothing
End function

Function SalvaMensagem()
	Dim mensagem
	Dim id_msg
	Dim RS

	id_msg = IIf(Request("s_descricao") = "", "0", Request("s_descricao"))

	mensagem = replace(request("mensagem"),"\n",vbcrlf)
	mensagem = replace(request("mensagem"),"<br>",vbcrlf)
	mensagem = replace(request("mensagem"),"'","")
	'mensagem = replace(request("mensagem"),chr(34),"")
	mensagem = IIf(VVVN(mensagem), "NULL", "'" & mensagem & "'")

	msSQL = "UPDATE Mensagem SET TextoMensagem = " & mensagem  & " WHERE CodMensagem = " & id_msg & ""
	Set RS = Env.oConn.Execute(msSQL) %>
	<script type="text/javascript">
		alert("Mensagem alterada com sucesso!");
	</script>
<%
End Function
%>
