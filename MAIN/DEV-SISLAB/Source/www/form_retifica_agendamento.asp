<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%
'On Error Resume Next

'Chama função em config.inc que faz a conexão com o Banco de dados
Conecta True

Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT" 
Response.Addheader "Cache-Control","no-cache, must-revalidate" 
Response.Addheader "Pragma","no-cache" 
%>
<html>
<head>
    <title>Retificação de Agendamento</title>
    <link rel="stylesheet" href="estilos/style.css">
</head>
<%
'Chamo a Barra comum a todas as paginas

Call MostraHeader 
%>
<script language="javascript" src="includes/anexo.js"></script>
<script language="JavaScript">
function initCampos()
// Inicializa os campos
{
  var frm = document.frmRetificaAgenda;
  frm.txtData.value = "<%= day(date) & "/" & month(date) & "/" & year(date)%>";
  frm.txtAgenda.focus();
}

function validaCampos(form)
// Valida os campos do formulario
{
  if (form.txtAgenda.value == "") 
  {
    alert("O campo 'Nº do Agendamento' deve ser preenchido.");
    form.txtDescricao.focus();
    return(false);
  }
  if (form.txtDescricao.value == "") 
  {
    alert("O campo 'Texto' deve ser preenchido.");
    form.txtDescricao.focus();
    return(false);
  }
  else if (form.txtData.value == "") 
  {
    alert("O campo 'Data da retificação' deve ser preenchido.");
    form.txtData.focus();
    return(false);
  }
  else
    return(true);
}
</script>

<body onload="initCampos();">

<form name="frmRetificaAgenda" action="" method="post" onsubmit="return validaCampos(this);">
<table border="0" cellSpacing=1 width="100%">
  <tr><td colspan="3">&nbsp;</td></tr>

  <tr>
    <td bgColor=#000000 valign=center>
      <B><FONT class=submenu>&nbsp;Retificação de agendamentos</FONT></B>
    </td>
  </tr>

  <tr><td>&nbsp;</td></tr>

  <tr>
    <td>
      <table border="0" width="540" align="left" cellSpacing=1>
        <tr>
          <td valign="top" align="right" colspan="2"><font class="item"><b>Nº do Agendamento:</b></td> 
          <td valign="center" align="left"><input class="cxtexto" name="txtAgenda" type="text" maxlength="10" size="11"></td>
        </tr>

        <tr>
          <td valign="top" align="right" colspan="2"><font class="item"><b>Nome do usuário:</b></td> 
	      <td valign="top" align="left">
            <select name="cmbUserID" >
            <% 
              dim s, rs
              set rs = Server.CreateObject("ADODB.RecordSet")
              set rs.Activeconnection = conSite
              rs.Source = "select USERID, NOME from UserCRT order by NOME"
              rs.Open
              while not rs.EOF
                Response.Write "<option value='" + cstr(rs("USERID")) & "'" 
                Response.Write ">" & rs("NOME") & "</option>" 
                rs.MoveNext()
              wend
              rs.Close
              set rs = nothing
            %></select>
          </td>
        </tr>
        <tr>
          <td valign="top" align="right" colspan="2"><font class="item"><b>Tipo:</b></td> 
          <td valign="top" align="left">
            <select name="cmbRetifica" >
              <option value="I" selected>Identificação da Amostra</option>
              <option value="R">Retificação</option>
            </select>
          </td>
        </tr>

        <tr>
          <td valign="top" align="right" colspan="2"><font class="item"><b>Data da retificação (dd/mm/aaaa):</b></td> 
          <td valign="center" align="left"><input class="cxtexto" name="txtData" type="text" maxlength="10" size="11"></td>
        </tr>

        <tr>
          <td valign="top" align="right" colspan="2"><font class="item"><b>Texto:</b></td> 
	      <td valign="top" align="left"><textarea class="cxtexto" name="txtDescricao" cols="70" rows="5"></textarea></td>
        </tr>

        <tr><td colspan="3">&nbsp;</td></tr>

        <tr>
          <td valign="top" align="center" colspan="3"><input class="cxtexto" name="btnOk" type="submit" value="   Ok   ">&nbsp;&nbsp;
            <input class="cxtexto" name="btnLimpar" type="reset" value=" Limpar ">&nbsp;&nbsp;
            <input class="cxtexto" name="dataretifica" type="button" value="Cancelar" onclick="javascript:history.back();">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr><td>&nbsp;</td></tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
    <td><font class="item"><b>Ocorrências de retificação:</b></td>
  </tr>

  <tr>
    <td></td>
  </tr>

</table>
</form>

</body>
</html>

<%
Conecta false

if Err.number <> 0 then
	Response.Redirect "erro.asp?perro=" & Server.URLEncode(Err.number) & "&pdescricao=" & Server.URLEncode(Err.description) 
end if
%>