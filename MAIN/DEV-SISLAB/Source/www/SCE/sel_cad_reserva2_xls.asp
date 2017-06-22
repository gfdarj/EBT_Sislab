<!--#include file="includes/abre.asp"-->
<!--#include file="includes/controlesXLS.asp"-->
<%
Dim where, recIN, recEQ, linha, ssql

where = trim(request("sql"))	'-- recebe o filtro SQL usado na tela anterior (clausula WHERE)

if where = "" then%>
<script language="JavaScript">alert("Não foi possível gerar planilha Excel."); window.close();</script><%
else
	'-- concateno o campo do codigo de barras com uma funcao do EXCEL pois o proprio "acha"
	'-- que o codigo de barras é um valor numérico e apresenta o mesmo em notacao cientifica
	ssql =	"select '=texto(""' + EQ_CODIGOBARRAS + '""; ""0000000000000000"")' as [Código de Barras_M], (MOD_CODNOME + ' / ' + MOD_DESCRICAO) as [Descrição_M], " & _
			"FAB_NOME as [Fabricante_M] from vw_SCE_Reserva_Equipamentos " & where & " AND EQ_INSTRUMENTAL = 0 order by EQ_CODIGOBARRAS"
	set recEQ = conn.execute(ssql)

	ssql =	"select '=texto(""' + EQ_CODIGOBARRAS + '""; ""0000000000000000"")' as [Código de Barras_M], (MOD_CODNOME + ' / ' + MOD_DESCRICAO) as [Descrição_M], " & _
			"FAB_NOME as [Fabricante_M] from vw_SCE_Reserva_Equipamentos " & where & " AND EQ_INSTRUMENTAL = 1 order by EQ_CODIGOBARRAS"
	set recIN = conn.execute(ssql)

'	response.write rec.fields(1).name
'	response.end

'	if not rec.eof then
		Dim str_eq, str_in, str

		if not (recIN.eof and recIN.bof) then _
			Call montaListagemExcel( recIN, "Reserva de Equipamentos - Instrumental(is)", Null, Null, str_in )

		if not (recEQ.eof and recEQ.bof) then _
			Call montaListagemExcel( recEQ, "Reserva de Equipamentos - Equipamento(s)", Null, Null, str_eq )

		str = "<HTML><HEAD><META HTTP-EQUIV=""Content-Type"" CONTENT=""application/vnd.ms-excel""><title>teste</title></HEAD><BODY>" & str_in & "<BR>" & str_eq & "</BODY></HTML>"
		Response.ContentType = "application/excel"
		Response.Clear
		'Se tirarmos o attachment da linha baixo, ele não vai pedir 2 vezes pra abrir, mas vai abrir na própria janela...
		Response.AddHeader "Content-Disposition", "filename=" & chr(34) & "Relatorio.xls" & chr(34)
		Response.Write (str)
		'Response.end

'	else%>
<!-- <script language="JavaScript">alert("Nenhuma reserva encontrada para este agendamento.");  window.close();</script> -->
<%'	end if
end if

Conn.close
set Conn = nothing
%>
