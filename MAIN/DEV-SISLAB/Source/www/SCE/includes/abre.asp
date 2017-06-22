<%
Set Conn = Server.CreateObject ("ADODB.Connection")

'-- local
'---conn.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1; Initial Catalog=SISLAB1; Data Source=DIPD-N80000"

'-- desenv
'conn.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1; Initial Catalog=SISLAB1; Data Source=ntspo905"

'-- producao
conn.Open "Provider=sqloledb;User ID=sislab1;Password=sislab1001; Initial Catalog=SISLAB; Data Source=ntspo006"

conn.cursorlocation = 3

%>