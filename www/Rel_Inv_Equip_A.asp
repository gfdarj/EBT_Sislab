<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim EH_CRT, EH_RAT
Dim chr_BgColor, chr_EstiloTD
Dim sSQL, sSQL_Dados

EH_CRT = Env.UsuarioCRT()
EH_RAT = Env.EhRat()
chr_BgColor = "#E8E8E8"
chr_EstiloTD = "style='border-bottom: solid " & chr_BgColor & " thin;'"

If Not EH_RAT Then
	RR "index.asp"
	RE
End If

sSQL = _
	"SELECT	ISNULL(E.EQ_LOCALIZACAO, '') AS LOCALIZACAO, E.EQ_CODIGOBARRAS AS CODIGOBARRAS, " & _
	"		ISNULL(E.EQ_NUMEROSERIE, '') AS NUMEROSERIE, " & _
	"		CASE WHEN E.EQ_PROPRIEDADE = 'C' THEN 'EBT - CRT' " & _
	"			WHEN E.EQ_PROPRIEDADE = 'M' THEN 'EBT - Comodato' " & _
	"			WHEN E.EQ_PROPRIEDADE = 'O' THEN 'EBT - Outros' " & _
	"			WHEN E.EQ_PROPRIEDADE = 'T' THEN 'Terceiros' END AS PROPRIEDADE, " & _
	"		CASE WHEN E.STATUS = 2 THEN 'Em Uso' " & _
	"			WHEN E.STATUS = 1 THEN 'Estoque' " & _
	"			WHEN E.STATUS = 3 THEN 'Expedido' " & _
	"			WHEN E.STATUS = 0 THEN 'Cadastrado' END AS STATUS, " & _
	"		ISNULL(MOD.MOD_CODNOME, '') AS MODELO, ISNULL(MOD.MOD_DESCRICAO, '') AS DESCRICAO, " & _
	"		ISNULL(F.FAB_NOME, '') AS FABRICANTE, ISNULL(CAST(NF.NF_NUMERONOTA AS VARCHAR), '') AS NOTAFISCAL, " & _
	"		ISNULL(CONVERT(VARCHAR, NF.NF_DATAEMISSAO, 103), '') AS DATAEMISSAO, " & _
	"		ISNULL(NO.NO_DESCRICAO, '') AS NATUREZAOP, ISNULL(CONVERT(VARCHAR, M.MOV_DATA, 103), '') AS MOVIMENTACAO, " & _
	"		ISNULL(QTD_MOV.TOTAL_MOVIMENTOS, 0) AS QTDMOVIMENTOS " & _
	"FROM " & _
	"	SCE_Equipamentos AS E LEFT JOIN " & _
	"	SCE_Modelos AS MOD ON E.MOD_ID = MOD.MOD_ID LEFT JOIN " & _
	"	SCE_Fabricantes AS F ON MOD.FAB_ID = F.fab_id LEFT JOIN " & _
	"	vw_SCE_Movimentacao_Atual AS M ON M.EQ_ID = E.EQ_ID LEFT JOIN " & _
	"	(	SELECT EQ_ID, COUNT(*) AS TOTAL_MOVIMENTOS " & _
	"		FROM SCE_Movimentacao AS M " & _
	"		GROUP BY EQ_ID	) AS QTD_MOV ON QTD_MOV.EQ_ID = E.EQ_ID LEFT JOIN " & _
	"	SCE_Nota_Fiscal AS NF ON NF.NF_ID = M.NF_ID LEFT JOIN " & _
	"	SCE_Natureza_Operacao AS NO ON NF.no_id = NO.NO_ID " & _
	"WHERE " & _
	"	1 = 1 "

'# configura os parametros do relatório
If Not VVVN(RQ("propriedade")) Then
	sSQL = sSQL & " AND E.EQ_PROPRIEDADE = '" & RQ("propriedade") & "'"
End If
If Not VVVN(RQ("localizacao")) Then
	sSQL = sSQL & " AND E.EQ_LOCALIZACAO LIKE '%" & RQ("localizacao") & "%'"
End If
If Not VVVN(RQ("numeroserie")) Then
	sSQL = sSQL & " AND E.EQ_NUMEROSERIE = '" & RQ("numeroserie") & "'"
End If
If Not VVVN(RQ("codigobarras")) Then
	sSQL = sSQL & " AND E.EQ_CODIGOBARRAS = '" & RQ("codigobarras") & "'"
End If
If Not VVVN(RQ("modelo")) Then
	sSQL = sSQL & " AND MOD.MOD_CODNOME LIKE '%" & RQ("modelo") & "%'"
End If
If Not VVVN(RQ("notafiscal")) Then
	sSQL = sSQL & " AND NF.NF_NUMERONOTA LIKE '%" & RQ("notafiscal") & "%'"
End If
If Not VVVNZ(RQ("status")) Then
	sSQL = sSQL & " AND E.STATUS = '" & RQ("status") & "'"
End If
If Not VVVNZ(RQ("naturezaop")) Then
	sSQL = sSQL & " AND NO.NO_ID = '" & RQ("naturezaop") & "'"
End If
If Not VVVNZ(RQ("qtdmov")) Then
	sSQL = sSQL & " AND QTD_MOV.TOTAL_MOVIMENTOS = " & RQ("qtdmov") & ""
End If
If Not VVVNZ(RQ("idfornecedor")) Then
	sSQL = sSQL & " AND NF.ENF_ID = " & RQ("idfornecedor") & ""
End If

sSQL = sSQL & " ORDER BY " & RQ("ordenacao") & " " & RQ("tipoordenacao")

'response.write sSQL
'response.end
%>
<html>
<form method="post" action="rel_inv_equip_b.asp">
<input type="Hidden" name="ssql" value="<%=sSQL%>">
<input type="Hidden" name="registroporpagina" value="<%=RQ("registroporpagina")%>">
</form>
<script language="javascript">
	var frm = document.forms[0];
	frm.submit();
</script>
</html>
