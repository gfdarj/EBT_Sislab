<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!------- LIB ------->
<!--#include file="../Lib/Classe_SCE.asp"-->
<%
'-- Usado pelo cadastro de reservas (cad_Reserva.asp)--
'--
'-- Pesquisa por um codigo de barras válido, retornando no form o ID do mesmo
'--
Dim reservado
Dim EmUso
Dim Sce

Set Sce = New TSce

EmUso = "Não"

If Request("cod_barras") = "" Or Request("linhaTabela") = "" Then Response.End

s = "select e.EQ_ID, (m.MOD_CODNOME + ' <==> ' + m.MOD_DESCRICAO) as DESCRICAO, mov.ASA "
s = s & "from SCE_Equipamentos e inner join SCE_Modelos m on e.MOD_ID = m.MOD_ID "
s = s & "left join vw_SCE_Movimentacao_Atual mov on e.EQ_ID = mov.EQ_ID "
s = s & "where EQ_CODIGOBARRAS = '" & request("cod_barras") & "'"
Set objRS = Env.oConn.Execute(s)

If Not (objRS.Eof And objRS.Bof) Then '-- ITEM VALIDO --

	If Not IsNull(objRS("ASA")) Then 
		If CStr(objRS("ASA")) = Request("ag_numero") Then
			EmUso = "Sim"
		End If
	End If

	reservado = Sce.VerificaReservaItem(true, request("ag_numero"), objRS("EQ_ID"), false)%>
<script language="JavaScript">
	var f = window.parent;
	f.document.all["item_<%=request("linhaTabela")%>"].eq_id = <%=objRS("EQ_ID")%>; // equip ID
	f.document.all["linha_<%=request("linhaTabela")%>_col_2"].innerText = '<%=objRS("DESCRICAO")%>';
	f.document.all["linha_<%=request("linhaTabela")%>_col_8"].innerText = '<%=EmUso%>';
</script>
<%	Call Sce.MarcaItemReservado((reservado <> ""), request("linhaTabela"))

else  '-- ITEM NAO EXISTE --%>
<script language="JavaScript">
	var f = window.parent;
	f.document.all["item_<%=request("linhaTabela")%>"].eq_id = ""; // equip ID
	f.document.all["linha_<%=request("linhaTabela")%>_col_2"].innerHTML = '<span style="color:red; font-weight:bold;"><i>Item não encontrado</i></span>';
	f.document.all["linha_<%=request("linhaTabela")%>_col_8"].innerText = '<%=EmUso%>';
</script>
<%	Call Sce.MarcaItemReservado(false, request("linhaTabela"))
end if

objRS.Close
Set objRS = Nothing

Set Sce = Nothing
Set Env = Nothing
%>
