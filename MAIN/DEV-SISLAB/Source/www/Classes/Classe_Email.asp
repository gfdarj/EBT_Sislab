<%
Class TEmail

	Private Const cdoSendUsingMethod        = "http://schemas.microsoft.com/cdo/configuration/sendusing"
	Private Const cdoSendUsingPort          = 2
	Private Const cdoSMTPServer             = "http://schemas.microsoft.com/cdo/configuration/smtpserver"
	Private Const cdoSMTPServerPort         = "http://schemas.microsoft.com/cdo/configuration/smtpserverport"
	Private Const cdoSMTPConnectionTimeout  = "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout"

    Private objConfig
    Private objMessage
    Private Fields
    Private m_HTML
    Private m_To
    Private m_From
    Private m_Subject

    'Propriedades
    Public Property Get HTML()
          HTML = m_HTML
    End Property
    Public Property Let HTML(p_Data)
          m_HTML = p_Data
    End Property

    Public Property Get From()
          From = m_From
    End Property
    Public Property Let From(p_Data)
          m_From = p_Data
    End Property

    Public Property Get TO()
          TO = m_To
    End Property
    Public Property Let TO(p_Data)
          m_To = p_Data
    End Property

    Public Property Get Subject()
          Subject = m_Subject
    End Property
    Public Property Let Subject(p_Data)
          m_Subject = p_Data
    End Property

    Public Property Get ReplyTo()
          ReplyTo = m_ReplyTo
    End Property
    Public Property Let ReplyTo(p_Data)
          m_ReplyTo = p_Data
    End Property

    'Inicializacao
    Private Sub Class_Initialize()
        Set objConfig = Server.CreateObject("CDO.Configuration")
        Set Fields = objConfig.Fields

        ' Configuracoes para enviar utilizando SMTP nao autenticado
        With Fields
	        .Item(cdoSendUsingMethod)       = cdoSendUsingPort
	        .Item(cdoSMTPServer)            = "e-mail.alerj.rj.gov.br"
	        .Item(cdoSMTPServerPort)        = 25
	        .Item(cdoSMTPConnectionTimeout) = 30
	        .Update
        End With

        Set objMessage = Server.CreateObject("CDO.Message")
        Set objMessage.Configuration = objConfig
    End Sub

    Public Sub Enviar()	
        With objMessage
	        .To       = m_To
            If .ReplyTo <> "" Then .ReplyTo = m_ReplyTo End If
	        .From     = m_From
	        .Subject  = m_Subject
	        .HtmlBody = m_HTML
	        .Send()
        End With
    End Sub	

    Private Sub Class_Terminate()
        Set Fields = Nothing
        Set objMessage = Nothing
        Set objConfig = Nothing
    End Sub
End Class
%>
