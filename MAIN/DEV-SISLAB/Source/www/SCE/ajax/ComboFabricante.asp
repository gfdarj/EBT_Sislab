<!--#include file="../../global.asa" -->
<!--#include file="../../includes/Sislab_Lib.asp"-->
<%
Dim RS
Dim chr_Param
Dim chr_Buffer

chr_Buffer = ""

'chr_Param = Server.HTMLEncode(RQ("cmb"))
'chr_Param = Server.URLEncode(RQ("cmb"))

Set RS = Env.oConn.Execute(_
	"select top 3 f.fab_id as VALOR, f.fab_nome as DESCRICAO from sce_fabricantes f order by f.fab_nome" _
)
'chr_Buffer = "<select id='fab_id' name='fab_id' class='form'>"
If Not RS.Eof Then
	While Not RS.Eof
		chr_Buffer = chr_Buffer & "<option value='" & RS("VALOR") & "'>" & RS("DESCRICAO") & "</option>"
		RS.MoveNext
	WEnd
Else
	chr_Buffer = "<option value=''>1--</option>"
End If
'chr_Buffer = chr_Buffer & "</select>"
'RW Len(Trim(chr_Buffer))
'RW "<BR><BR>" & Trim(chr_Buffer)
RW Trim(chr_Buffer)
%>