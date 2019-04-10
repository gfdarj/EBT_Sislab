<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp"-->
<!--#include file="includes/global.asp"-->
<!--#include file="includes/emailHTML.asp"-->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Upload.asp"-->
<%
Dim objSP, RS
Dim idacao, descricao, executante, prazo, conclusao, eficacia, obs, tipoacao, responsavel
Dim assunto, msg
Dim EhnovaAcao : EhnovaAcao = false


Response.Charset = Application("SISLAB_CHARSET")


Dim Form : Set Form = New ASPForm

Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.

pastaArquivos = Server.MapPath(".") & "\" & Application("SISLAB_FolderArquivosLB") & "\"

Const MaxFileSize = 25200000 ' Limite de 25,2 Mb de arquivo

If Form.State = 0 Then
    subPasta = Form.SubPastaLB(Form.Item("ocorrencia"))
    If subPasta <> "" Then subPasta = subPasta & "\" 


    '-- Excluir um arquivo anexo da ação
    If Form.Item("id_ArquivoExclusao") <> "" Then

	    call Env.StoredProcedure(true, objSP, "sp_ApagaLogBookAcaoTomadaArquivos")
	    with objSP
		    .Parameters.item("@pACA_ID") = Form.Item("id_ArquivoExclusao")
	    '	on error resume next
		    .Execute
	    '	on error goto 0
		    idacao = .Parameters.item("@pACA_ID")
	    end with
	    call Env.StoredProcedure(false, objSP, "sp_ApagaLogBookAcaoTomadaArquivos")

	    If idacao > -1 Then
		    'On Error Resume Next
		    Form.DeleteFile(pastaArquivos & subPasta & Form.Item("id_ArquivoExclusaoNome"))
		    'On Error Goto 0
	    End If

    Else
	    idacao = Form.Item("idacao")

	    If idacao = "" Then
		    idacao = Null
		    EhnovaAcao = True
	    End If

	    '-- Apaga uma ação tomada
	    If Form.Item("remover") = "1" Then

		    '-- Pego o nome dos arquivos para excluir fisicamente
		    Set RS = Env.oConn.Execute("SELECT ACA_LINK FROM LB_ACOESTOMADAS_ARQUIVOS WHERE ACT_ID = " & idacao)

		    '-- Apago as Acoes tomada
		    Call Env.StoredProcedure(true, objSP, "sp_ApagaLogBookAcaoTomada")
		    With objSP
			    .Parameters.item("@pACT_ID") = idacao
		    '	on error resume next
			    .Execute
		    '	on error goto 0
			    idacao = .Parameters.item("@pACT_ID")
		    End With
		    Call Env.StoredProcedure(false, objSP, "sp_ApagaLogBookAcaoTomada")

		    On Error Resume Next
		    While Not RS.Eof
		        Form.DeleteFile(pastaArquivos & subPasta & RS(0))
			    RS.MoveNext
		    WEnd
		    RS.Close
		    On Error Goto 0
		    Set RS = Nothing

	    Else

		    descricao = Form.Item("descricao")
		    if descricao = "" then descricao = null
		    executante = Form.Item("executor")
		    if executante = "" then executante = null
		    responsavel = Form.Item("responsavel")
		    if responsavel = "" then responsavel = null
		    prazo = Form.Item("anoprazo") & "-" & Form.Item("mesprazo") & "-" & Form.Item("diaprazo")
		    if trim(prazo) = "--" then prazo = null
		    conclusao = Form.Item("anoconc") & "-" & Form.Item("mesconc") & "-" & Form.Item("diaconc")
		    if trim(conclusao) = "--" then conclusao = null
		    eficacia = Form.Item("opteficacia")
		    if eficacia = "" then eficacia = null
		    obs = Form.Item("obs")
		    If obs = "" Then obs = Null
		    tipoacao = Form.Item("cmbAcao")
		    If tipoacao = "" Then tipoacao = Null Else tipoacao = cint(tipoacao)

    'response.write "<BR>idacao: " & idacao
    'response.write "<BR>ocorrencia: " & Form.Item("ocorrencia")
    'response.write "<BR>descricao: " & descricao
    'response.write "<BR>executante: " & executante
    'response.write "<BR>prazo: " & prazo
    'response.write "<BR>conclusao: " & conclusao
    'response.write "<BR>eficacia: " & eficacia
    'response.write "<BR>obs: " & obs
    'response.write "<BR>tipoacao: " & tipoacao
    'response.write "<BR>arquivo: " & arquivo
    'response.write "<BR>" & replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")

            For each Field in Form.Files.Items
                If Not VVVNZ(Field.FileName) Then
                    ' # Field.Filename : Nome do Arquivo que chegou.
                    ' # Field.ByteArray : Dados binários do arquivo, útil para subir em blobstore (MySQL).
                    Field.SaveAs pastaArquivos & subPasta & Field.FileName

                    chr_Arquivo = subPasta & Field.FileName
                Else
                    chr_Arquivo = Null
                End If

		        Call Env.StoredProcedure(true, objSP, "sp_CadLogBookAcaoTomada")
		        With objSP
			        .Parameters.item("@pACT_ID") = idacao
			        .Parameters.item("@pACT_LB") = Form.Item("ocorrencia")
			        .Parameters.item("@pACT_DESCRICAO") = descricao
			        .Parameters.item("@pACT_EXECUTANTE") = executante
			        .Parameters.item("@pACT_PRAZO") = prazo
			        .Parameters.item("@pACT_DATACONCLUSAO") = conclusao
			        .Parameters.item("@pACT_EFICACIA") = eficacia
			        .Parameters.item("@pACT_OBS") = obs
			        .Parameters.item("@pACT_TIPOACAO") = tipoacao
			        .Parameters.item("@pACT_ARQUIVO") = chr_arquivo
			        .Parameters.item("@pACT_USUARIOCADASTROU") = replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")
			        .Parameters.item("@pACT_RESPONSAVEL") = responsavel
		        '	on error resume next
			        .Execute
		        '	on error goto 0
			        idacao = .Parameters.item("@pACT_ID")
		        End With
		        Call Env.StoredProcedure(false, objSP, "sp_CadLogBookAcaoTomada")

		        '-- Usuario selecionou para responder por email ao Responsavel pela acao
		        If Form.Item("resposta") = "S" Then

			        assunto = "Gerenciamento do LogBook - Elaboração de Ações Tomadas"

			        If EhnovaAcao Then msg = "criada." Else msg = "alterada."

			        If Cstr(TipoAcao) = Cstr(LB_Acao_Imediata) Then
				        msg = "<b>imediata</b> foi " & msg
			        ElseIf Cstr(TipoAcao) = Cstr(LB_Acao_Corretiva) Then
				        msg = "<b>corretiva</b> foi " & msg
			        Else
				        msg = "<b>preventiva</b> foi " & msg
			        End If

			        msg = _
				        "Uma ação do logbook tipo " & msg & "<br><br>" & _
				        "Nº da Ocorrência : " & Form.Item("ocorrencia") &  "<br>" & _
				        "Prazo de conclusão: " & conclusao & "<br>" & _
				        "Responsável pela Ação: " & responsavel &  "<br>" & _
				        "Executor: " & executante & "<br>" & _
				        "Descrição da ação: " & descricao &  "<br>"


			        '###
			        '### houve uma reclamacao de que o email nao estava sendo enviado, entao comentei
			        '### a linha que verifica o usuário
			        '###									Gilberto (06/09/2010)
			        If Env.ExisteUsuario(responsavel) then
				        Call Enviar_Email(responsavel, responsavel, assunto, msg)
    				    Call Enviar_Email("gilbertorjo@gmail.com", "GILBERTO", assunto, msg)
			        End If
		        End If
            Next


	    End if

    End If


    Call Tela.ImprimeCabecalho2("", MENU_ON, true, "", "Pesquisa de Satisfação - CRT", linkVoltar, "")
    Response.Write "<div class='margem-10'>"
    If idacao <= 0 Then
	    Response.Write "<br><p>&nbsp;&nbsp;<b>Ocorreu um erro na execução desta ação</b></p>" & VbCrLf
    else
	    Response.Write "<scr" & "ipt lang" & "uage='JavaSc" & "ript'>" & VbCrLf

	    '-- Excluiu um arquivo anexo à ação
	    If Form.Item("id_ArquivoExclusao") <> "" Then
		    Response.Write "opener.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Form.Item("ocorrencia") & "';" & VbCrLf
		    Response.Write "location.href = 'cad_acLogBook.asp?idacao=" & Form.Item("idacao") & "&ocorrencia=" & Form.Item("ocorrencia") & "';" & VbCrLf
	    Else
		    '-- Remove uma acao tomada
		    if Form.Item("remover") = "1" then
			    Response.Write "location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Form.Item("ocorrencia") & "';" & VbCrLf
		    else
			    '-- se for nova acao chamo do form de ocorrencias! caso contrario
			    '-- chamo do form de acoes
			    if EhnovaAcao then
				    Response.Write "opener.frame_LB_acao.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Form.Item("ocorrencia") & "';" & VbCrLf
			    else
				    Response.Write "opener.location.href = 'cad_evLogBookAcoes.asp?ocorrencia=" & Form.Item("ocorrencia") & "';" & VbCrLf
			    end if
			    Response.Write "window.close();" & VbCrLf
		    end if
	    End If

	    Response.Write "</scri" & "pt>" & VbCrLf
    end if
    Response.Write "</div>"
    Call Tela.MostraRodape()
Else
    Call Tela.ImprimeCabecalho2("", MENU_ON, true, "", "Pesquisa de Satisfação - CRT", linkVoltar, "")
    RW "<div margem='10'>"
    RW "<br />"
    RW "<p>Ocorreu um erro ao tentar realizar este Upload.</p>"
    RW "<br />"
    RW "</div>"
    Call Tela.MostraRodape()
End If

Set Form = Nothing
%>
