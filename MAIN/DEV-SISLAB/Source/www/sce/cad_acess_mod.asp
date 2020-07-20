<!------- LIB ------->
<!--#include file="../Classes/Classe_SCE.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Consulta > Item" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Sce
    Dim dtIni, dtFim

    Set Sce = New TSce

    dtIni = Request("anoinicio") & "-" & Request("mesinicio") & "-" & Request("diainicio")
    dtFim = Request("anotermino") & "-" & Request("mestermino") & "-" & Request("diatermino")

    'Call Tela.ImprimeMenuSce()

    Server.ScriptTimeout = 10000

    Dim status, doc_id, rec, nserie
    Dim chr_Buf

'    if request("enf_id") <> "" or request("codbarras") <> "" or request("modelo") <> "" or _
'	    request("notafiscal") <> "" or request("numeroserie") <> "" or request("codbarras") <> "" or _
'	    request("fabricante") <> "" or request("documento") <> "" or request("desc_modelo") <> "" or _
'	    request("conforme") <> "" or request("instrumental") <> "" or request("status") <> "" or _
'	    request("cde_equip") <> "" or request("localizacao") <> "" or request("propriedade") <> "" or _
'	    request("idtipo") <> "" or request("plataforma") <> "" then

	    If Request("busca") <> "" Then
		    ssql =	"SELECT distinct a.status, a.eq_id, a.eq_codigobarras AS [EQ_CODIGOBARRAS_M], mod_descricao AS [MOD_DESCRICAO_M], " & _
				    "   a.eq_numeroserie AS [EQ_NUMEROSERIE_M], a.mod_id, e.mod_codnome AS [MOD_CODNOME_M], " & _
				    "   ma.ASA AS AG_NUMERO, ma.MOV_SOLICITANTE, amb.AMB_NOME, crt.SIGLA_CRT, amb.AMB_NOME AS [AMB_NOME_M], crt.SIGLA_CRT AS [SIGLA_CRT_M], " & _
				    "   CASE WHEN (SELECT count(*) FROM SCE_Acessorios where EQ_ID = a.EQ_ID) > 0 THEN 'Sim' ELSE 'Não' END AS [EQ_TEMACESSORIO_M], fab_nome AS [FAB_NOME_M], " & _
				    "   CASE WHEN A.STATUS = 2 THEN 'Em Uso' " & _
				    "   WHEN A.STATUS = 1 THEN 'Estoque' " & _
				    "   WHEN A.STATUS = 3 THEN 'Expedido' " & _
				    "   WHEN A.STATUS = 0 THEN 'Cadastrado' END AS STATUS_M " & _
				    "FROM " & VbCrLf & _
                    "	SCE_Equipamentos a " & _
                    "	LEFT JOIN sce_modelos e ON a.mod_id = e.mod_id " & _
                    "	LEFT JOIN SCE_Fabricantes f ON e.fab_id = f.fab_id " & _
                    "	LEFT JOIN vw_SCE_Movimentacao_Atual AS ma ON ma.EQ_ID = a.EQ_ID " & _
                    "	LEFT JOIN Ambientes amb ON amb.AMB_ID = a.AMB_ID " & _
                    "	LEFT JOIN CentroReferencia crt ON amb.ID_CRT = crt.ID_CRT " & _
				    "WHERE (1 = 1) "

		    If request("documento") <> "" and isnumeric(request("documento")) Then
			    ssql = ssql & _
				    " AND EXISTS (SELECT mov.DOC_ID FROM SCE_Movimentacao mov " & _
				    "WHERE mov.doc_id = " & request("documento") & " AND mov.EQ_ID = a.EQ_ID) "
		    End If

		    If request("plataforma") <> "" Then
			    ssql = ssql & _
				    " AND EXISTS (SELECT plat.EQ_ID FROM PLATAFORMA_EQUIPAMENTOS plat " & _
				    "WHERE plat.S_ID = " & request("plataforma") & " AND plat.EQ_ID = a.EQ_ID) "
		    End If

		    if request("notafiscal") <> "" or request("enf_id") <> "" Then
			    ssql = ssql & _
				    " AND EXISTS (SELECT nf.NF_ID FROM SCE_Movimentacao mov, " & _
				    "SCE_nota_fiscal nf " & _
				    "WHERE mov.nf_id = nf.nf_id AND mov.EQ_ID = a.EQ_ID "
    	
			    if request("notafiscal") <> "" Then
				    ssql = ssql &" and nf.nf_numeronota like '" & trim(request("notafiscal")) & "' "
			    End If
    	
			    if request("enf_id") <> "" Then 
				    ssql = ssql &" and nf.enf_id = " & request("enf_id") & " "
			    End If
    	
			    ssql = ssql & ") "
		    end if

		    if request("codbarras") <> "" then
			    ssql = ssql &"and a.eq_codigobarras like '%"& trim(replace(request("codbarras"), "'", "")) &"%' "
		    end if
		    if request("modelo") <> "" then
			    ssql = ssql &"and e.mod_codnome like '%"& trim(replace(request("modelo"), "'", "")) &"%' "
		    end if
		    if request("desc_modelo") <> "" then
			    ssql = ssql &"and e.mod_descricao like '%"& trim(replace(request("desc_modelo"), "'", "")) &"%' "
		    end if
		    if request("numeroserie") <> "" then
			    ssql = ssql &"and a.eq_numeroserie like '%" & trim(replace(request("numeroserie"), "'", "")) &"%' "
		    end if
		    if request("fabricante") <> "" then
			    ssql = ssql &"and e.fab_id = "& request("fabricante") & " "
		    end if
		    if request("conforme") <> "" then
			    ssql = ssql &"and a.EQ_CONFORME = "& request("conforme") & " "
		    end if
		    if request("status") <> "" then
			    ssql = ssql &"and a.STATUS = "& request("status") & " "
		    end if
		    if request("idtipo") <> "" then
			    ssql = ssql &"and e.TIPO_ID = "& request("idtipo") & " "
		    end if
		    if request("instrumental") <> "" then
			    ssql = ssql &"and a.EQ_INSTRUMENTAL = "& request("instrumental") & " "
		    end if
		    if request("localizacao") <> "" then
			    ssql = ssql &"and UPPER(amb.AMB_NOME) like '%" & UCase(request("localizacao")) & "%' "
		    end if
		    if request("cde_equip") <> "" then  '-- registro de controle do equipamento
			    ssql = ssql &"and EXISTS (SELECT eqc.EQC_REGISTRO FROM SCE_Equipamentos_Controle eqc WHERE eqc.EQ_ID = a.EQ_ID AND UPPER(eqc.EQC_REGISTRO) LIKE '" & UCase(request("cde_equip")) & "') "
		    end if
		    if request("propriedade") <> "" then
			    ssql = ssql &"and a.EQ_PROPRIEDADE IN ('" & request("propriedade") & "') "
		    end if
            If dtIni <> "" Then
                ssql = ssql & "AND a.EQ_DT_CADASTRO >= CAST('" & dtIni & " 00:00' AS DATETIME) "
            End If
            If dtFim <> "" Then
                ssql = ssql & "AND a.EQ_DT_CADASTRO <= CAST('" & dtFim & " 23:59' AS DATETIME) "
            End If

		    ssql = ssql &" order by e.mod_codnome asc, a.EQ_CODIGOBARRAS ASC;"

    		'response.write ssql & "<BR>" & request("fabricante")
		    response.write "<!-- SQL:" & VbCrLf & ssql & VbCrLf & "-->" & VbCrLf & VbCrLf
    		'response.end

		    set rec = Env.oconn.execute(ssql)
	    end if

	    Response.Buffer = True

	    Dim url_xls
	    url_xls = "<div align='right'><a href=""../excel.asp?TITULO=Consulta de Item&SQL=" & Server.UrlEncode(ssql) & """ target='_blank' alt='Exporta esta listagem para o Excel'><font color='#008000'><b>XLS</b></font></a></div>"

	    chr_Buf = _
		    "<div class='margem-10'><div align='center'>" & VbCRLf & _
		    "<table width='100%' cellpadding='0' cellspacing='0'>" & VbCRLf & _
		    "<tr valign='top'>" & VbCRLf & _
		    "	<td class='destaque' align='center'>Escolha um Item</td>" & VbCRLf & _
		    "	<td align='right' class='destaque'>" & url_xls & "</td>" & VbCRLf & _
		    "</tr>" & VbCRLf & _
		    "</table>" & VbCRLf & _
		    "<br>" & VbCRLf & _
		    "<table class='largura-total'>" & VbCRLf & _
		    "<tr valign='top'>" & VbCRLf & _
		    "	<td class='titulo' align='center'>" & VbCRLf & _
		    "		<table class='largura-total table-condensed table-bordered table-striped table-hover'>" & VbCRLf & _
		    "			<tr>" & VbCRLf & _
		    "				<th align='center'>Item</th>" & VbCRLf & _
		    "				<th align='center'>Núm. de Série</th>" & VbCRLf & _
		    "				<th align='center'>Modelo / Fab.</th>" & VbCRLf & _
		    "				<th align='center'>Descrição</th>" & VbCRLf & _
		    "				<th align='center'>Situação Item</th>" & VbCRLf & _
		    "				<th align='center'>Acess.</th>" & VbCRLf & _
		    "			</tr>" & VbCRLf

	    response.write chr_Buf
	    Response.Flush

	    if not rec.eof then
		    while not rec.eof

			    nserie = InsereBR(rec("eq_numeroserie_M"), 20)

			    chr_Buf = _
			    "			<tr valign='top'>" & VbCrLf & _
			    "				<td align='center'><a href='cad_acess_item.asp?mod_id=" & rec("mod_id") & "&eq_id=" & rec("eq_id") & "'>" & rec("eq_codigobarras_M") & "</a>&nbsp;</td>" & VbCrLf & _
			    "				<td align='center'>" & nserie & "&nbsp;</td>" & VbCrLf

			    if rec("mod_id") <> 0 then
				    chr_Buf = chr_Buf & _
					    "			<td align='center'>" & rec("mod_codnome_M") & "<BR>" & rec("fab_nome_M") & "&nbsp;</td>" & VbCrLf & _
					    "			<td align='center'>" & rec("mod_descricao_M") & "&nbsp;</td>" & VbCrLf & _
					    "			<td align='center'>" & Sce.ImprimeStatusItem(rec) & "&nbsp;</td>" & VbCrLf
			    else
				    chr_Buf = chr_Buf & _
					    "			<td align='center'>&nbsp;</td>" & VbCrLf & _
					    "			<td align='center'>&nbsp;</td>" & VbCrLf
			    end if

			    chr_Buf = chr_Buf & _
				    "				<td align='center'>" & rec("EQ_TEMACESSORIO_M") & "</td>" & VbCrLf & _
				    "		</tr>"

			    Response.Write chr_Buf
			    Response.Flush
		 	    rec.movenext
		    wend
	    else
		    Response.Write "<td align='center' colspan='8'>Não existem equipamentos cadastrados com esses parâmetros.</td>"
	    end if

	    chr_Buf = _
		    "		</table>" & VbCrLf & _
		    "	</td>" & VbCrLf & _
		    "</tr>" & VbCrLf & _
		    "<tr valign='top' align='left'>" & VbCrLf & _
		    "	<td class='texto1' align='left'><br></td>" & VbCrLf & _
		    "</tr>" & VbCrLf & _
		    "</table>" & VbCrLf & _
		    "</div></div><br><br>" & VbCrLf

	    Response.Write chr_Buf
	    Response.Flush

	    Call ImprimeRodape(RODAPE_OFF)
'    Else
'	    response.redirect("sel_cad_acessorio.asp?msg=4")
'    End If

Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()

Set Sce = Nothing
Set Env = Nothing
%>
