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
Tela.SetNomeTela = "SCE > Relatório > Movimentação de Item" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then

    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script language=javascript>
	<!--#include file="includes/vform.js"-->
</script>

<form name="formulario" method="post" action="rel_mov2.asp" onsubmit="vdform('formulario','documento','Documento','Number'); return document.ValorPassou;">

<table width="100%" class="texto1">
	<tr><td valign="middle" class="destaque">Selecione o Item</td></tr>
	<tr><td>&nbsp;</td></tr>
	 <tr>
		<td colspan="2">
      		<table border="0" class="texto1">
			<tr>
				<td valign="top" CLASS="texto1">
				Tipo de Movimentação:&nbsp;
<%			Dim notipo : notipo = request("notipo")
			if notipo = "" then notipo = 0 else notipo = CInt(request("notipo"))%>
				<select name="notipo" class="texto1" onchange="func2();">
					<option value=""> -- Tipo de Movimento --</option>
					<option value="<%=MOV_ENTRADA%>" <%if notipo = MOV_ENTRADA then response.write " selected"%>>Entrada</option>
					<option value="<%=MOV_LOGISTICA_ENTRADA%>" <%if notipo = MOV_LOGISTICA_ENTRADA then response.write " selected"%>>Logística Entrada</option>
					<option value="<%=MOV_LOGISTICA_SAIDA%>" <%if notipo = MOV_LOGISTICA_SAIDA then response.write " selected"%>>Logística Saída</option>
					<option value="<%=MOV_EXPEDICAO%>" <%if notipo = MOV_EXPEDICAO then response.write " selected"%>>Expedição</option>
					<option value="<%=MOV_EXPEDICAO_SUBST%>" <%if notipo = MOV_EXPEDICAO_SUBST then response.write " selected"%>>Substituição</option>
	 			</select>
				</td>
	<SCRIPT>
	function func2(){
		document.formulario.action='rel_mov.asp';
		document.formulario.submit();
	}			
</script>
		</td>
	</tr>
	<tr><td class="texto1">&nbsp;</td></tr>
	<tr>
		<td valign="top" CLASS="texto1" colspan="2">
			Natureza de Operação:&nbsp;		
				<select name="noid" class="texto1">
				<option value="">-- Natureza da Operação --</option>
<%					ssql = "select * from sce_natureza_operacao "
					if request("notipo") <> "" then ssql = ssql & "where no_tipo = " & request("notipo") & " "
					ssql = ssql & "order by no_descricao"
					set rec = Env.oconn.execute(ssql)
					if not rec.eof then
						while not rec.eof%>
				<option value="<%=rec("no_id")%>"><%=rec("no_descricao")%></option>
<%							rec.movenext
						wend
					end if%>
	 			</select>
		</td>
	</tr>	
	<tr>
		<td class="texto1" colspan="2"><br></td>
	</tr>
	  			<tr>
	    			<td class="texto1">
Código Barras:&nbsp;<input type="text" class="texto1" name="codbarras" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>
						<td class="texto1">
Localizacao:&nbsp;<input type="text" class="texto1" name="localizacao" style="width:200px" maxlength="50">&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td class="texto1" colspan="2"><br></td>
				</tr>

				<tr>
	    			<td class="texto1">
					Fabricante:&nbsp;
					<select name="fabricante" class="texto1">
					<option value="">-- Todos --</option>
<%                  RW Combo.OptionBD("select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "")
				'ssql = "select * from sce_fabricantes order by fab_nome"
				'set rec = conn.execute(ssql)
				'if not rec.eof then
				'	while not rec.eof%>
<!--						<option value="<%'=rec("fab_id")%>"><%'=rec("fab_nome")%></option>-->
						<%'rec.movenext
					'wend
				'end if%>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					<td class="texto1">
Modelo:&nbsp;<input type="text" name="modelo" class="texto1" style="width:200px"></td>
				</tr>
				<tr>
					<td class="texto1" colspan="2"><br></td>
				</tr>

				<tr>
						<td class="texto1" colspan="2">
						Fornecedor				
							<select name=enf_id class="texto1">
							<option value="">-- Todos --</option>
<%				ssql = "select enf_id as VALOR, (case when enf_nome is null then '' else LEFT(enf_nome, 45) end) + "
				ssql = ssql & "(case when enf_cidade is null or enf_cidade = '' then '' else ' / ' + enf_cidade end) + "
				ssql = ssql & "(case when enf_cnpj is null or enf_cnpj = '' then '' else ' (' + enf_cnpj + ')' end) as DESCRICAO "
				ssql = ssql & "from sce_empresa_nota_fiscal order by enf_nome, enf_cidade"
				RW Combo.OptionBD(ssql, "", "")

'				ssql = "select * from sce_empresa_nota_fiscal order by enf_nome"
'					set recenf = conn.execute(ssql)
'					if not recenf.eof then%>
							<%'while not recenf.eof%>
<!--								<option value="<%'=recenf("enf_id")%>"><%'=recenf("enf_nome")%></option>-->
								<%'recenf.movenext
'							wend%>
							</select>
						</td>
				</tr>

				<tr><td>&nbsp;</td></tr>
				<tr>
					<td class="texto1" colspan="2">
					Nota Fiscal:&nbsp;<input type="text" class="texto1" name="notafiscal" size="20" maxlength="50">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Documento:&nbsp;<input type="text" class="texto1" name="documento" size="7" maxlength="10">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					CDE:&nbsp;<input type="text" class="texto1" name="cde" size="10">
					</td>
				</tr>

				<tr>
					<td class="texto1" colspan="2"><br></td>
				</tr>
				<%'end if%>

	  			<tr>
					<td class="texto1">
					Número de Série:&nbsp;<input type="text" class="texto1" name="numeroserie" style="width:200px" maxlength="50"></td>
					<td class="texto1">
					Data da Movimentação:&nbsp;<input type="text" class="texto1" name="dia" size=2 maxlength="2">&nbsp;/&nbsp;<input type="text" class="texto1" name="mes" size=2 maxlength="2">&nbsp;/&nbsp;<input type="text" class="texto1" name="ano" size=4 maxlength="4"></td>
				</tr>

	  			<tr><td class="texto1" colspan="2"><br></td></tr>

				<tr>
					<td class="texto1" colspan="2">
						Plataforma: <%=Combo.ServicosPlataformas("plataforma", "N", "P")%>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						AS:&nbsp;<input type="text" class="texto1" name="asa" style="width:50px" maxlength="50">
					</td>
				</tr>

	  			<tr><td class="texto1" colspan="2"><br></td></tr>

				<tr>
					<td class="texto1" colspan="2">
						RT:&nbsp;<input type="text" class="texto1" name="solicitante" style="width:200px" maxlength="50">
					</td>
				</tr>

				<tr>
					<td class="texto1" colspan="2" align="right"><input type="submit" name="buscar" value="buscar &gt;&gt;" class="texto1"></td>
				</tr>
			</table>
      	</td>
    </tr>
  </table>
</form>
</center>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
