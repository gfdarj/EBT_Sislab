<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim EH_CRT, EH_RAT
Dim sSql, iPagina, RS
Dim registroporpagina

EH_CRT = Env.UsuarioCRT()
EH_RAT = Env.EhRat()

If Not EH_RAT Then
	RR "index.asp"
	RE
End If

registroporpagina = IIf(VVVNZ(RQ("registroporpagina")), 10, RQ("registroporpagina"))

If VVVN(RQ("ssql")) then	'-- foi submetido por este mesmo form
	sSql = RQ("ssql2")
	iPagina = RQ("pagina")
Else	'-- veio do form Rel_Ativ_A.asp
	ssql = RQ("ssql")
	iPagina = 1
End If

'RW "<br><br>1 !!!" & sSql
'RW "<br><br>2 !!!" & RQ("ssql2")
'RW "<br><br>3 !!!" & RQ("pagina")
'RW "<br><br>4 !!!" & RQ("ssql")
'RE

Call Env.RecordSet(True, RS, sSQL)

total_registros = RS.RecordCount

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Relatório para Inventário de Equipamentos"
Tela.SetLinkVoltar = "location.href='rel_inv_equip.asp'"
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório para Inventário de Equipamentos", "location.href='rel_inv_equip.asp'", "")
%>
<script type="text/javascript" src="includes/manipulaObj.js"></script>
<script type="text/javascript">
    function proximaPagina()
    {
	    var frm = document.forms[0];
	    frm.pagina.value = <%=iPagina+1%>;
	    frm.submit();
    }
    function VaiPagina(pagina)
    {
	    var frm = document.forms[0];
	    frm.pagina.value = pagina;
	    frm.submit();
    }

    function paginaAnterior()
    {
	    var frm = document.forms[0];
	    frm.pagina.value = <%=iPagina-1%>;
	    frm.submit();
    }
</script>

<div class="margem-10">
    <form action="rel_inv_equip_B.asp" method="post">
        <input type="hidden" name="total_registros" value="<%=total_registros%>">
        <input type=hidden name="pagina">
        <input type="hidden" name="ssql2" value="<%=ssql%>">
        <input type="hidden" name="registroporpagina" value="<%=registroporpagina%>">
        <br>
<%
If Not(RS.EOF) Then

	if VVVNZ(RQ("Pagina")) then contpagina = 1 else contpagina = CInt(RQ("Pagina"))
	RS.AbsolutePage = contpagina
	RS.PageSize = registroporpagina
%>
        <table class="table-condensed largura-total">
        <tr>
	        <td width="150px">
		<%if contpagina > 1 then%>
    			<a href="javascript:paginaAnterior()" class="menu"><span>&laquo;</span> Voltar</a>
		<%end if%>
	        </td>
	        <td class="texto-centralizado">
		        Página atual: <%=contpagina%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Total de Registros: <%=total_registros%>
	        </td>
	        <td class="texto-direito" width="150px">
		<%if Not RS.Eof then%>
			<a href="javascript:proximaPagina()" class="menu">Avançar <span>&raquo;</span></a>
		<%end if%>
	        </td>
        </tr>
        </table>

        <table class="table-bordered table-condensed table-striped table-hover largura-total">
        <tr>
	        <th >Cód Barras</th>
	        <th >Localização</th>
	        <th >Num. Série</th>
	        <th class="texto-centralizado">Propriedade</th>
	        <th class="texto-centralizado">Status</th>
	        <th >Modelo</th>
	        <th >Descrição</th>
	        <th >Fabricante</th>
	        <th class="texto-centralizado">Nota Fiscal</th>
	        <th >Emissão</th>
	        <th >N.OP</th>
	        <th class="texto-centralizado">Último Movimento</th>
	        <th class="texto-centralizado">Qtd. Mov.</th>
        </tr>
<%
	while (intrec < RS.PageSize and not RS.EOF)
		intrec = intrec + 1
%>
        <tr style="vertical-align: middle;">
	        <td><%=IIf(VVVNZ(RS("CODIGOBARRAS")), "&nbsp;", RS("CODIGOBARRAS"))%></td>
	        <td><%=IIf(VVVNZ(RS("LOCALIZACAO")), "&nbsp;", RS("LOCALIZACAO"))%></td>
	        <td><%=IIf(VVVNZ(RS("NUMEROSERIE")), "&nbsp;", RS("NUMEROSERIE"))%></td>
	        <td><%=IIf(VVVNZ(RS("PROPRIEDADE")), "&nbsp;", RS("PROPRIEDADE"))%></td>
	        <td class="texto-centralizado" ><%=IIf(VVVNZ(RS("STATUS")), "&nbsp;", RS("STATUS"))%></td>
	        <td><%=IIf(VVVNZ(RS("MODELO")), "&nbsp;", RS("MODELO"))%></td>
	        <td><%=IIf(VVVNZ(RS("DESCRICAO")), "&nbsp;", RS("DESCRICAO"))%></td>
	        <td><%=IIf(VVVNZ(RS("FABRICANTE")), "&nbsp;", RS("FABRICANTE"))%></td>
	        <td class="texto-direito"><%=IIf(VVVNZ(RS("NOTAFISCAL")), "&nbsp;", RS("NOTAFISCAL"))%></td>
	        <td><%=IIf(VVVNZ(RS("DATAEMISSAO")), "&nbsp;", RS("DATAEMISSAO"))%></td>
	        <td><%=IIf(VVVNZ(RS("NATUREZAOP")), "&nbsp;", RS("NATUREZAOP"))%></td>
	        <td><%=IIf(VVVNZ(RS("MOVIMENTACAO")), "&nbsp;", RS("MOVIMENTACAO"))%></td>
	        <td class="texto-direito"><%=IIf(VVVNZ(RS("QTDMOVIMENTOS")), "&nbsp;", RS("QTDMOVIMENTOS"))%></td>
        </tr>
<%		RS.MoveNext
	wend
%>
        </table>

        <script type="text/javascript">
	        var frm = document.forms[0]
	        frm.pagina.value = <%=contpagina%>
        </script>

        <table class="table-condensed largura-total">
        <tr>
	        <td width="150px">
		        <%if contpagina > 1 then%>
			        <a href="javascript:paginaAnterior()"><span>&laquo;</span> Voltar</a>
		        <%end if%>
	        </td>
	        <td class="texto-centralizado">
		        Página atual: <%=contpagina%></B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Total de Registros: <%=total_registros%>
	        </td>
	        <td width="150px" class="texto-direito">
		        <%if Not RS.Eof then%>
			        <a href="javascript:proximaPagina()">Avançar <span class="cinza1">&raquo;</span></a>
		        <%end if%>
	        </td>
        </tr>
<%
else
%>
        <tr><td colspan="8" class="texto-centralizado">Nenhum equipamento encontrado.</td></tr>
<%
end if
%>
        </table>
    </form>
</div>
<%
Call Tela.MostraRodape()
%>
