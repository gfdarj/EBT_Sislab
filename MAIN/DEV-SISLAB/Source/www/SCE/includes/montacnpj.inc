<%Function montaCnpj(cnpj)

strCnpj = left(cnpj, 2) & "." & mid(cnpj, 3,3)  & "." & mid(cnpj, 6, 3)  & "/" & mid(cnpj, 9, 4)   & "-" & right(cnpj, 2)

response.write strCnpj

end Function 
%>