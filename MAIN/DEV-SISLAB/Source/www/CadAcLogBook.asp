<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
dim objConn, objRS, s
dim acao , oc, responsavel

acao = request("acao")
idacao = request("idacao")
oc = request("ocorrencia")

responsavel = ""

if (oc = "" or oc = "0" or idacao = "" or idacao = "0") and acao <> "cadastrar" then%>
	<script type="text/javascript">alert("Ocorrência inválida"); window.close();</script>
<%
end if

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, false, "100%", "Ações do LogBook", "window.close()", "")

tipoacao = ""
desc = ""
executante = ""
prazo = null
conclusao = null
obs = ""
eficacia = ""

if idacao <> "" then
	s = "SELECT * FROM LB_ACOESTOMADAS INNER JOIN LB_TIPOACAOTOMADA ON TAT_ID = ACT_TIPOACAO WHERE ACT_LB = " & oc & " AND ACT_ID = " & idacao
	call Env.RecordSet(true, objRS, s)
	tipoacao = CStr(objRS("ACT_TIPOACAO"))
	if IsNull(tipoacao) then tipoacao = ""
	desc = objRS("ACT_DESCRICAO")
	if isnull(Desc) then desc = ""
	executante = objRS("ACT_EXECUTANTE")
	if isnull(executante) then executante = ""
	prazo = objRS("ACT_PRAZO")
	conclusao = objRS("ACT_DATACONCLUSAO")
	obs = objRS("ACT_OBS")
	if isnull(obs) then obs = ""
	eficacia = objRS("ACT_EFICACIA")
	if IsNull(eficacia) then eficacia = "" else eficacia = Trim(CStr(eficacia))
	responsavel = objRS("ACT_RESPONSAVEL")
	if IsNull(responsavel) then responsavel = ""
	call Env.Recordset(false, objRS, null)
end if
%>
<div class="margem-10">
    <form name="frm" method="post" action="CadAcLogBookA.asp" enctype="multipart/form-data">
        <input type="hidden" name="idacao" value="<%=idacao%>">
        <input type="hidden" name="ocorrencia" value="<%=oc%>">
        <input type="hidden" name="id_ArquivoExclusao" value="">
        <input type="hidden" name="id_ArquivoExclusaoNome" value="">
        <input type="hidden" name="resposta" value="N">

        <table width="100%" class="table-condensed">
        <tr>
	        <td>Tipo da Ação:&nbsp;</td>
	        <td><%call comboBDSQL( "cmbAcao", objConn,"Select TAT_ID AS VALOR, TAT_DESCRICAO AS DESCRICAO FROM LB_TIPOACAOTOMADA", tipoacao, "N")%></td>
        </tr>
        <tr>
	        <td>Descrição:&nbsp;</td>
	        <td><input type="text" name="descricao" size=85 maxlength="600" value="<%=desc%>"></td>
        </tr>
        <tr>
	        <td>Responsável:&nbsp;</td>
	        <td><%call comboUSERCRT("responsavel", objConn,"N")%></td>
        <%	if responsavel <> "" then%>
	        <script type="text/javascript">
		        document.all.responsavel.value = '<%=responsavel%>';
	        </script>
        <%	end if%>
        </tr>
        <tr>
	        <td>Executor:&nbsp;</td>
	        <td><input type="text" name="executor" size=35 value="<%=executante%>"></td>
        </tr>
        <tr>
	        <td>Prazo Previsto<br>Conclusão:</td>
	        <td><%call comboData("prazo")%></td>
        <%if not IsNull(prazo) then%>
	        <script type="text/javascript">
		        document.all.diaprazo.value = '<%=Zeros(Day(prazo),2)%>';
		        document.all.mesprazo.value = '<%=Zeros(Month(prazo),2)%>';
		        document.all.anoprazo.value = '<%=Year(prazo)%>';
	        </script>
        <%end if%>
        </tr>
        <tr>
	        <td>Acompanhamento:</td>
	        <td><textarea name="obs" cols="85" rows="6"><%=obs%></textarea></td>
        </tr>

        <%if acao = "finalizar" or (not IsNull(conclusao) and acao = "visualizar") then%>
        <tr>
	        <td>Data Conclusão:&nbsp;</td>
	        <td><%call comboData("conc")%></td>
        <%	if not IsNull(conclusao) then%>
	        <script type="text/javascript">
		        document.all.diaconc.value = '<%=Zeros(Day(conclusao),2)%>';
		        document.all.mesconc.value = '<%=Zeros(Month(conclusao),2)%>';
		        document.all.anoconc.value = '<%=Year(conclusao)%>';
	        </script>
        <%	end if%>
        </tr>
        <tr>
	        <td>Eficácia:&nbsp;</td>
	        <td>
		        <select name="opteficacia">
			        <option value="" <%if eficacia = "" then response.write "selected"%>>--</option>
			        <option value="1" <%if eficacia = "1" then response.write "selected"%>>Sim</option>
			        <option value="0" <%if eficacia = "0" then response.write "selected"%>>Não</option>
		        </select>
	        </td>
        </tr>
        <%end if%>
        <tr>
	        <td>Anexar Arquivo:</td>
	        <td><input type="file" size="60" name="arquivo"></td>
        </tr>
        <tr>
	        <td valign="top">Arquivos Anexos:</td>
	        <td>
<%
'-- Verifica se existem arquivos anexos a esta ação
Dim chr_Buf : chr_Buf = "<i>Nenhum arquivo anexo</i>"

s = "SELECT ACA_ID, ACA_LINK FROM LB_ACOESTOMADAS_ARQUIVOS WHERE LB_ID = " & oc & " AND ACT_ID = " 
If idacao = "" Then s = s & "0" Else s = s & idacao

call Env.RecordSet(true, objRS, s)
If Not (objRS.Eof And objRS.Bof) Then

	chr_Buf =  "	<table class='table-bordered' width='100%'>"
	While Not objRS.Eof
		chr_Buf = chr_Buf & "	<tr>"
		chr_Buf = chr_Buf & "		<td width='*'>"
		chr_Buf = chr_Buf & "		    <a href='arquivosLB/" & objRS("ACA_LINK") & "' target='_blank'>" & objRS("ACA_LINK") & "</a>"
		chr_Buf = chr_Buf & "		</td>"
		chr_Buf = chr_Buf & "		<td width='80px' align='center'>"

		If (oc <> "") And (Not Env.UsuarioCRT) Then
			chr_Buf = chr_Buf & "		x"
		Else
			chr_Buf = chr_Buf & "		<a href='#' onclick='javascript:Excluir(" & objRS("ACA_ID") & ", """ & Replace(objRS("ACA_LINK"), "\", "\\") & """);'>Excluir</a>"
		End If

		chr_Buf = chr_Buf & "		</td>"
		chr_Buf = chr_Buf & "	</tr>"

		objRS.MoveNext
	WEnd
	chr_Buf = chr_Buf & "	</table>"
	chr_Buf = chr_Buf & "	</td>"
	chr_Buf = chr_Buf & "</tr>"
End If

Response.Write chr_Buf

Call Env.RecordSet(false, objRS, null)
%>
	        </td>
        </tr>
        <tr>
	        <td colspan="2" align="center">
<%
	If (oc <> "") And (Not Env.UsuarioCRT) Then	%>
        		<input type="button" class="btn btn-primary" onclick="javascript:window.close();" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fechar&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
<%	Else%>
		        <input type="button" class="btn btn-primary" onclick="envia();" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
                &nbsp;&nbsp;&nbsp;&nbsp;
        		<input type="button" class="btn btn-primary" onclick="javascript:window.close();" value="&nbsp;&nbsp;Fechar&nbsp;&nbsp;" />
<%	End If%>
	        </td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        </table>
    </form>
</div>

<script type="text/javascript" src="includes/anexo.js"></script>
<script type="text/javascript">
    var frm = document.forms[0];

    function Excluir(ac, acnome)
    {
	    frm.id_ArquivoExclusao.value = ac;
	    frm.id_ArquivoExclusaoNome.value = acnome;
	    frm.submit();
    }

    function envia()
    {
	    if (frm.cmbAcao.value == "") {
		    alert("Informe a ação tomada.");
	        frm.cmbAcao.focus();
		    return false;
	    }
	    if (frm.descricao.value==""){
		    alert("Informe a descrição da Ação.");
	        frm.descricao.focus();
		    return false;
	    }
	    if (frm.responsavel.value==""){
		    alert("Informe o responsável <%=Application("SISLAB_NOME_EMPRESA")%> da Ação.");
	        frm.responsavel.focus();
		    return false;
	    }
	    if (frm.executor.value==""){
		    alert("Informe o executor da Ação.");
	        frm.descricao.focus();
		    return false;
	    }

	    <%if not IsNull(prazo) then%>
        prazo = frm.diaprazo.value + '/' + frm.mesprazo.value + '/' + frm.anoprazo.value;
	    if (!ValidaDataMesAno(prazo,'Prazo'))
		    return false;
	    <%end if%>

        <%if acao = "finalizar" then%>
        conc = frm.diaconc.value + '/' + frm.mesconc.value + '/' + frm.anoconc.value;
	    if (!ValidaDataMesAno(conc,'Finalização'))
		    return false;
        <%end if%>

	    if (!validaNomeArquivo(extractFileName(frm.arquivo.value))) {
		    alert('O nome do arquivo está inválido. Retire acentuação e espaços antes de prosseguir.');
		    frm.arquivo.focus();
		    return false;
	    }

	    var resposta = confirm("Deseja que este cadastro comunique via e-mail o responsável por esta ação ?");
	    if (resposta) {
		    frm.resposta.value = "S";
	    }

	    frm.submit();
    }

<%if acao = "visualizar" then%>
	frm.cmbAcao.disabled = true;
	frm.obs.readonly = true;
	frm.descricao.disabled = true;
	frm.executor.disabled = true;
	frm.diaprazo.disabled = true;
	frm.mesprazo.disabled = true;
	frm.anoprazo.disabled = true;
	frm.responsavel.disabled = true;
	frm.obs.disabled = true;
	frm.arquivo.disabled = true;
	<%if (not isNull(conclusao)) Or (Not Env.UsuarioCRT) then %>
	frm.diaconc.disabled = true;
	frm.mesconc.disabled = true;
	frm.anoconc.disabled = true;
	frm.opteficacia.disabled = true;
	<%end if%>
<%end if%>
</script>
<%
Call Tela.MostraRodape()
%>