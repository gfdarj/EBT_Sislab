<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Relatório > Termo de Responsabilidade" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Call Tela.ImprimeMenuSce()

    Dim data, rec, recEq, s, listaAS, ano_doc

    Session.LCID = 1046
    data = FormatDateTime(Date(), vbLongDate)

    s =	"SELECT d.DOC_RESPONSAVEL, d.DOC_NOME, d.DOC_IDE, d.DOC_EMPRESA, d.DOC_FONE, d.DOC_DATADOCUMENTO, d.DOC_OBSERVACAO, " & _
	    "d.DOC_MAIL, e.ENF_ENDERECO, e.ENF_CIDADE, e.ENF_UF, e.ENF_CEP, e.ENF_NOME " & _
	    "FROM SCE_Documentacao d LEFT JOIN SCE_Empresa_Nota_Fiscal e " & _
	    "ON d.ENF_ID = e.ENF_ID " & _
	    "WHERE d.DOC_ID = " & request("doc_id")
    set rec = Env.oconn.execute(s)

    ano_doc = ""
    if not IsNull(rec("DOC_DATADOCUMENTO")) then
	    ano_doc = "/" & left(rec("DOC_DATADOCUMENTO"), 4)
    end if
%>
<table width="645px"  cellpadding="4" cellspacing="0" border="0">
<tr>
	<td>
		<table width="100%" cellpadding="0" cellspacing="0" >
		<tr>
			<td width="180px"><img src="../img/logoebt.bmp" border="0"></td>
			<td align="right">
				<table class="titulo" cellpadding="4" cellspacing="0">
				<tr><td align="right" style="font-size: 15pt;"><b>Nº&nbsp;<%=request("doc_id") & ano_doc%></b></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td align="right"><b>Rio de Janeiro, <%=data%></b></td></tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td align="center" class="titulo"><%=request("titulo")%></td></tr>

<tr><td>&nbsp;</td></tr>

<tr><td align="justify" style="font-size: 10pt;"><%=RepeteStr("&nbsp;", 7) & request("descricao")%></td></tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td align="center"> <%' aqui entram os equipamentos
    s =	"SELECT e.EQ_CODIGOBARRAS, e.MOD_CODNOME, e.MOD_DESCRICAO, e.EQ_NUMEROSERIE, m.ASA " & _
	    "FROM vw_SCE_Equipamentos_Fabricantes e INNER JOIN SCE_Movimentacao m " & _
	    "ON e.EQ_ID = m.EQ_ID INNER JOIN SCE_Natureza_Operacao n ON m.NO_ID = n.NO_ID " & _
	    "WHERE m.DOC_ID = " & request("doc_id") & " AND n.NO_TIPO = " & MOV_ENTRADA & _
	    "ORDER BY e.EQ_CODIGOBARRAS"
    set recEq = Env.oconn.execute(s)

    if recEq.eof and recEq.bof then
	    response.write "<b><i>Nenhum equipamento encontrado para este documento</i></b>"
    else
	    listaAS = ""
%>		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr>
			<th>DESCRI&Ccedil;&Atilde;O</th>
			<th>MODELO/PART NUMBER</th>
			<th>Nº DE S&Eacute;RIE</th>
		</tr>
<%	    while not recEq.eof%>
		<tr>
			<td><%=recEq("MOD_DESCRICAO")%>&nbsp;</td>
			<td><%=recEq("MOD_CODNOME")%>&nbsp;</td>
			<td><%=recEq("EQ_NUMEROSERIE")%>&nbsp;</td>
		</tr>
<%		    '-- procura pela AS para nao haver repeticao
		    if not IsNull(recEq("ASA")) then
			    if (InStr(1, listaAS, Trim(recEq("ASA")), 1) = 0) or (IsNull(InStr(1, listaAS, Trim(recEq("ASA")), 1))) then _
				    listaAS = listaAS & recEq("ASA") & ", "
		    end if
		    recEq.movenext
	    wend
	    if Trim(listaAS) <> "" then listaAS = left(listaAS, len(listaAS)-2) else listaAS = "--"
%>		</table><%
    end if
    recEq.close
    Set recEq = Nothing
%>	</td>
</tr>
<%
    If Not IsNull(rec("DOC_OBSERVACAO")) Then
	    If Trim(rec("DOC_OBSERVACAO")) <> "" Then
%>
<tr><td>&nbsp;</td></tr>

<tr><td colspan="2" class="titulo">Observação:</td></tr>
<tr><td colspan="2"><%=rec("DOC_OBSERVACAO")%></td></tr>
<%
	    End If
    End If
%>
<tr><td>&nbsp;</td></tr>

<tr><td colspan="2" class="titulo">Vinculado à AS: <%=listaAS%></td></tr>

<tr><td>&nbsp;</td></tr>

<tr><td colspan="2" class="titulo" bgcolor="#c0c0c0">DADOS DO CLIENTE - RESPONSÁVEL</td></tr>

<tr>
	<td><% '-- pego os dados da empresa e do responsavel
    if rec.eof and rec.bof then
	    response.write "<b><i>Nenhum responsável encontrado para este documento</i></b>"
    else
	    endereco = ""
%>		<table width="100%" cellpadding="2" cellspacing="0"  border="1">
		<tr><th align="left" width="120px">Nome:</th><td><%=rec("DOC_NOME")%>&nbsp;</td></tr>
		<tr><th align="left" width="120px">Identificação:</th><td><%=rec("DOC_IDE")%>&nbsp;</td></tr>
		<tr>
			<th align="left" width="120px">Empresa:</th>
			<td><%if IsNull(rec("ENF_NOME")) then response.write rec("DOC_EMPRESA") else response.write rec("ENF_NOME")%>&nbsp;</td>
		</tr>
		<tr>
			<th align="left" width="120px">Endereço:</th>
			<td><%
	    if not IsNull(rec("ENF_ENDERECO")) then
		    if endereco <> "" then endereco = endereco & " - "
		    endereco = endereco & rec("ENF_ENDERECO")
	    end if
	    if not IsNull(rec("ENF_CIDADE")) then
		    if endereco <> "" then endereco = endereco & " - "
		    endereco = endereco & rec("ENF_CIDADE")
	    end if
	    if not IsNull(rec("ENF_UF")) then
		    if endereco <> "" then endereco = endereco & " - "
		    endereco = endereco & rec("ENF_UF")
	    end if
	    if not IsNull(rec("ENF_CEP")) then
		    if endereco <> "" then endereco = endereco & " - "
		    endereco = endereco & rec("ENF_CEP")
	    end if
	    response.write endereco
%>				&nbsp;
			</td>
		</tr>
		<tr><th align="left" width="120px">Telefone p/ contato:</th><td><%=rec("DOC_FONE")%>&nbsp;</td></tr>
		<tr><th align="left" width="120px">Email:</th><td><%=rec("DOC_MAIL")%>&nbsp;</td></tr>
		<tr><th align="left" width="120px">Resp. Técnico:</th><td><%=rec("DOC_RESPONSAVEL")%>&nbsp;</td></tr>
		</tr>
		</table><%
    End If
%>	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr><td class="titulo">De acôrdo: _________________________________________________</td></tr>

<tr><td>&nbsp;</td></tr>

<tr><td class="titulo" bgcolor="#c0c0c0">CIENTE</td></tr>

<tr>
	<td>
		<table width="100%" cellpadding="2" cellspacing="0" class="titulo">
		<tr><td width="145px">Agente de Logística:</td><td width="*">_________________________________________________</td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td width="145px">Responsável Técnico:</td><td width="*">_________________________________________________</td></tr>
		</table>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>
</table>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
