<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()

ssql = "select * from sce_nota_fiscal order by nf_numeronota"
set recnf = Env.oconn.execute(ssql)
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
<form method=post action="cad_nf.asp" name="formulario">
<table width="100%">
	<tr>
		<td class=texto>
		<%if request("msg")<>"" then 
			if cint(request("msg")) =1 then response.write "<br><strong>Nota Fiscal alterada com sucesso!</strong><br><br>"
			if cint(request("msg")) =2 then response.write "<br><strong>Nota Fiscal excluída com sucesso!</strong><br><br>"
		end if%>
		</td>
	</tr>
<SCRIPT LANGUAGE="jscript">				
	var idfornecedor = new Array();
	var idnota = new Array();				
	var numero = new Array();
			<%
				ssql = "select distinct enf_id, nf_id, nf_numeronota from sce_nota_fiscal order by nf_numeronota"
				set rec = Env.oconn.execute(ssql)
				if not rec.eof then	
				i=0
				do while not rec.eof
					response.write ("idfornecedor[" & i & "]=" & rec("enf_id") & ";" & chr(13))
					response.write ("idnota[" & i & "]=" & rec("nf_id") & ";" & chr(13))
					response.write ("numero[" & i & "]='" & rec("nf_numeronota") & "';" & chr(13))
					i=i+1					
				rec.movenext
				loop
				end if%>

function func(){
	objfabr=document.formulario.enf_id;
	objmod=document.formulario.nf_id;
	
	while (objmod.options.length!=0)
	{
		objmod.options.remove(0);	
	}
	var temp = document.createElement("OPTION");
	objmod.options.add(temp);
	
	for (i=0; i<idfornecedor.length; i++){
		if (idfornecedor[i]==objfabr.options[objfabr.selectedIndex].value){
			var oOption = document.createElement("OPTION");
			
			objmod.options.add(oOption);
			oOption.innerText = "nº NF:"+ numero[i]; //+" - id_forn: "+ idfornecedor[i]+" - id Nota:"+ idnota[i];
			oOption.value = idnota[i];
		}
	}
}
function f(){
	document.formulario.action = "busca_nf.asp";
	document.formulario.submit();
}
</script>
	<tr>
		<td valign="top"  valign="middle" class="texto1">
		    Busque por número da nota:&nbsp;<input type=text name=numeronota class="texto1" size="10">&nbsp;
		    <input type=submit value="buscar" class="texto1" onclick="f();"><br><br>Busque por Empresa:<br>

<%              RW Combo.Fornecedor("enf_id", "", false, "", true)%>
			    <script language="JavaScript">
				    document.all.enf_id.size = 20;
				    document.all.enf_id.onchange = func;
			</script>
		</td>
    </tr>
	<tr>
		<td valign="top"  valign="middle" class="texto1">
		<%if not recnf.eof then%>
			<select name="nf_id" size="5" class="texto1" style="width:600">
			</select>
		<%else
			response.write "Não Existem Notas Fiscais Cadastradas No Momento."
		end if%>
		</td>
    </tr>
	<script>
		function f1(){
			if (document.formulario.nf_id.value == ""){
				alert('Você deve escolher a nota fiscal');
				a = '';
				document.vp = false;
			}else{
				document.vp = true;
			}
		}
	</script>
	<tr><td>&nbsp;</td></tr>
	<tr>
	    <td valign="middle">
	        <input type=submit value=" Editar " class="texto1" onclick="f1(); return document.vp;">
	    </td>
	</tr>
</table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
