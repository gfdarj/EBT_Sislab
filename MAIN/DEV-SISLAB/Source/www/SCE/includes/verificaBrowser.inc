<%
Dim browser, i
browser = Request.ServerVariables("HTTP_USER_AGENT")
If InSTR(browser, "MSIE") Then
 	If Cint(Mid(browser, InSTR(browser, "MSIE") + 5, 1)) <= 4 Then
		browser = "IE4-"
	else
 		browser = "IE5+"
 	End If
Elseif InSTR(browser, "Mozilla") AND NOT(InSTR(browser, "compatible;")) Then
	If Cint(Mid(browser, InSTR(browser, "/") + 1, 1)) <= 4 Then
  	browser = "NN4-"
  Else
  	browser = "NN5+"
  End If
End If
%>
