<!-- #INCLUDE FILE="inicializacao.inc" -->

<%
'On Error Resume Next
%>

<%

Dim AuxDataHora, Auxchk

%>
<%

Session("LogNT")=UCase(trim(mid(Request.ServerVariables("REMOTE_USER"),10,8)))
Session("RemoteIP")=UCase(request.ServerVariables("REMOTE_ADDR"))
AuxDataHora=day(Date)&"/"&month(Date)&"/"&year(Date)&" "&Time

%>

<html>

<head><script language="javascript">

function ValidaCampos()
{

if (document.formulario.senha.value=="")
	{
	alert("Senha não informada.\nInforme sua Senha.");
		return false;

	}
	return true;
}

</script>

<center>
<form METHOD="POST" name="formulario" ACTION="chklogin.asp"  onsubmit="return ValidaCampos();">
<center>
<table width="480" border="0">
<tr><td>
<font style="font-size: 9pt; font-family: sans-serif;"><b>
<% if hour(time) < 12 then%>
Bom dia, 
<%elseif hour(time) > 12 and hour(time) < 18 then%>
Boa tarde,
<%elseif hour(time) > 18 then%>
Boa noite,
<%end if%>
&nbsp;<%=Session("logNT")%>
<br>
Você está logado com o IP <%=Session("RemoteIP")%> em <%=AuxDataHora%><br>
Seu acesso será registrado.</b></font>

</td></tr>
</table>
</center>
<br>
<br>

  <div align="center"><center>
<font face="Tahoma" style="font-size: 10pt; " color="#990000"><b>
Acesso restrito para usuários autorizados
</font></b>
<table width="390" border="3" bgcolor="#9F9F9F"
  bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#373737">
    <tr>
      <td height="27" bordercolor="#000000"><table width="100%" border="1"
      bgcolor="#C0C0C0" bordercolor="#000000" bordercolorlight="#C0C0C0"
      bordercolordark="#000000">
        <tr  class="trCadtit1">
          <td width="59%" bgcolor="#C0C0C0" bordercolor="#000000"><b><font size="1"  Style="font-size: 10pt;" face="tahoma" color="#303030">&nbsp;&nbsp;CONTROLE DE ACESSO</font></b> </td>
          <td width="41%" bgcolor="#808080" bordercolor="#000000"><font Style="font-size: 10pt;" face="tahoma"  color=#FFFF88><strong><div
          align="center"><center><p>Site do CRT</strong></font></td>
        </tr>
      </table>
      </td>
    </tr>
    <tr align="center"  class="trCadtit2">
      <td><table height="64" align="left">
        <tr>
      <td valign="middle" height="55" width="145" align="left" bordercolor="#000000"><font Style="font-size: 8pt;" face="tahoma" color="#FFFFFF">
	<b>&nbsp;&nbsp;&nbsp; SENHA<br>
      </b>&nbsp;&nbsp; <input type="password" size="10" name="senha" maxlength="12" value="" class="cxTexto"></font>
      </td>
          <td align="left" bordercolor="#000000"><font  Style="font-size: 8pt;" face="tahoma" color="#FFFFFF">
	    <b>&nbsp;<input type="radio" Value="S" name="rdselecao" checked>&nbsp;SISLAB</b><br>
		 <b>&nbsp;<input type="radio" value="G" name="rdselecao">&nbsp;Sistema de Segurança de Acesso</b><br>
	    <b>&nbsp;<input type="radio" value="A" name="rdselecao">&nbsp;Administração do Site</b><br>
            </font>
          </td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
  </center></div><div align="center"><center><table width="390" border="3" bgcolor="#9F9F9F"
  bordercolor="#808080" bordercolorlight="#808080" bordercolordark="#373737">
    <tr align="center" class="trCadtit1">
      <td align="middle" border="0" height="44" bordercolor="#000000">
  <table border="0" height="44" width="266">
        <tr>
          <td width="100">
	  </td>
          <td width="158" align="right" valign="middle"><font size="2" face="ARIAL">
          <input type="submit" value="    OK    " align="center" width="15">&nbsp;&nbsp;
          <input type="button" value="Sair" align="center" width="15"          onclick="location.href='index.asp'">&nbsp;&nbsp;
          </font></td>
        </tr>
      </table>	
      </td>
    </tr>
  </table>
<table width="390" border="0">
    <tr>
      <td>
	<P ALIGN="right"><font Face="tahoma" color=#666666 style="font-size: 8pt; font-family: sans-serif;">
	<b>IP REMOTO:</b> <I><%=Session("RemoteIP")%></I></font></p>
      </td>
    </tr>
  </table>
  </center></div>
</form>

<%
	Call MostraFooter

%>