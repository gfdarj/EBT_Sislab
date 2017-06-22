<%
'+-----------------------------------------------------------------------------------------------------
'+ Classe criada para armazenar as mensagens padronizadas do sistema
'+
'+ dependencia: Classe_Environment.asp
'+ 20/03/2012 
'+-----------------------------------------------------------------------------------------------------
Class TMensagem

Private chr_Texto
Private p_classe
Private p_classebotao
Private p_linkjs

Private Sub Class_Initialize()
    p_classe = "texto1"
    p_classebotao = "texto1"
    p_linkjs = ""
End Sub

Private Sub Class_Terminate()
End Sub

'-Property------------------------------------------------------------------------'

Public Property Let SetLinkVoltarJS(link)
	p_linkjs = link
End Property

Public Property Let SetClasse(classe)
	p_classe = classe
End Property

Public Property Let SetClasseBotao(classe)
	p_classebotao = classe
End Property

Public Property Get AcessoRestritoSCE()
	AcessoRestritoSCE = _
			"<BR><p class='" & p_classe & "' style='color: red;'>&nbsp;&nbsp;&nbsp;Acesso restrito ao Sistema de Controle de Equipamentos.</p>" & VbCrLf & _
		    "<p class='" & p_classe & "'>&nbsp;&nbsp;&nbsp;Clique <a href='#' onclick='javascript:history.go(-1);'><u>aqui</u></a> para voltar</p>"
End Property


'--------------------------------------------------------------------------------------------
'-- Imprime mensagem de erro em alguma transacao com o banco de dados
'-- Parametro: recebe o objeto Conection.Errors
'--------------------------------------------------------------------------------------------
Public Function ErroSql()
    Dim oErro
    Dim buf

    buf = _
	    "<p class='" & p_classe & "' style='color: red;'>&nbsp;&nbsp;&nbsp;Ocorreu um erro no banco de dados.</p>" & VbCrLf

    For Each oErro In Env.oConn.Errors
        buf = buf & _
            "<p class='" & p_classe & "'>&nbsp;&nbsp;&nbsp;Descrição: " & oErro.Description & "</p>" & VbCrLf
    Next

    buf = buf & _
        "" & VbCrLf & _
	    "<p class='" & p_classe & "'>&nbsp;&nbsp;&nbsp;<input type='Button' value='Voltar' class='" & p_classebotao & "' onclick='javascript:" & IIf(p_linkjs = "", "history.go(-1);", p_linkjs) & "'></p>" & VbCrLf

    ErroSql = buf
End Function

Public Function ObjetoErroSql(objetoErro)
    Dim oErro
    Dim buf

    buf = _
	    "<p class='" & p_classe & "' style='color: red;'>&nbsp;&nbsp;&nbsp;Ocorreu um erro no banco de dados.</p>" & VbCrLf

    For Each oErro In objetoErro.Errors
        buf = buf & _
            "<p class='" & p_classe & "'>&nbsp;&nbsp;&nbsp;Descrição: " & oErro.Description & "</p>" & VbCrLf
    Next

    buf = buf & _
        "" & VbCrLf & _
	    "<p class='" & p_classe & "'>&nbsp;&nbsp;&nbsp;<input type='Button' value='Voltar' class='" & p_classebotao & "' onclick='javascript:" & IIf(p_linkjs = "", "history.go(-1);", p_linkjs) & "'></p>" & VbCrLf

    ErroSql = buf
End Function


'---------------------------------------------------------------------------------'

Public Function AcessoNegadoSistema
    Dim bln_EmJanela : bln_EmJanela = (Request("janela") = "1")
    Dim buf

    buf = _
	    "<center>" & VbCrLf & _
	    "<br><br>" & VbCrLf & _
	    "<font face='verdana' color=#777777 size=5 style='font-size:20pt;'>Atualização de Informações:</font><br><br>" & VbCrLf & _
	    "<table width='70%' align='center'>" & VbCrLf & _
	    "<tr><td>" & VbCrLf & _
	    "<center>" & VbCrLf & _
	    "<br><br><br>" & VbCrLf & _
	    "<font face='verdana' color=#CC7777 size=5 style='font-size:18pt;'>USUÁRIO " & Replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","") & " NÃO  ESTÁ AUTORIZADO A ACESSAR ESTA ÁREA OU A SUA SESSÃO ESTÁ EXPIRADA.<BR><BR>" & VbCrLf

    If bln_EmJanela Then
	    buf = buf & "CLIQUE <a href='javascript:window.close();'>AQUI</a> PARA FECHAR ESTA JANELA" & VbCrLf
    Else
	    buf = buf & "REINICIE O BROWSER OU CLIQUE <a href='index.asp'>AQUI</a>, E CASO O ERRO PERSISTA CONTATE O ADMINISTRADOR DO SITE</font>" & VbCrLf
    End If

    buf = buf & _
	    "<br><br>" & VbCrLf & _
	    "<font face='verdana' color=#AAAAAA size=4 style='font-size:14pt;'>" & VbCrLf & _
	    "<br><br>" & VbCrLf & _
	    "</font>" & VbCrLf & _
	    "<br><br><br>" & VbCrLf & _
	    "</center>" & VbCrLf & _
	    "</td>" & VbCrLf & _
	    "</tr>" & VbCrLf & _
	    "</table>" & VbCrLf

    AcessoNegadoSistema = buf
End Function


End Class
%>
