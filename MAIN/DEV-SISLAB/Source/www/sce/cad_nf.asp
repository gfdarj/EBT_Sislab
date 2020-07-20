<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/funcoes.asp" -->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Tela.SCE = True
Tela.SetNomeTela = "Cadastro > Nota Fiscal" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    'Call Tela.ImprimeMenuSce()

    Dim valor, nf_id
    Dim nf_numeronota : nf_numeronota = ""
    Dim nf_qtdevolumes : nf_qtdevolumes = ""
    Dim nf_valortotal : nf_valortotal = ""
    Dim nf_dataemissao : nf_dataemissao = ""
    Dim nf_nconhecimento : nf_nconhecimento = ""
    Dim nf_tipo : nf_tipo = ""
    Dim trans_id : trans_id = ""
    Dim enf_id : enf_id = ""
    Dim nf_descriminacao : nf_descriminacao = ""
    Dim aceite : aceite = ""
    Dim integridade : integridade = ""
    Dim carta : carta = ""
    Dim volume : volume = ""
    Dim devolucao : devolucao = False
    Dim nf_cfop : nf_cfop = ""
    Dim no_id : no_id = ""
    Dim nf_id_pai : nf_id_pai = ""
    Dim nf_validade : nf_validade = ""
    Dim nf_data : nf_data = ""
    Dim nf_recebimento : nf_recebimento = ""
    Dim titulo : titulo = ""
    Dim Combo

    Set Combo = New TCombo

    nf_id = Cstr(request("nf_id"))

    if nf_id = "" then titulo = "Cadastrar Nota Fiscal" else titulo = "Alterar Nota Fiscal"

    if nf_id <> "" then
	    ssql = "select * from sce_nota_fiscal where nf_id = " & nf_id
	    set r = Env.oconn.execute(ssql)
	    if not (r.eof and r.bof) then
		    nf_numeronota = r("nf_numeronota")
		    if isNull(nf_numeronota) then nf_numeronota = ""
		    nf_qtdevolumes = r("nf_qtdevolumes")
		    if isNull(nf_qtdevolumes) then nf_qtdevolumes = "" else nf_qtdevolumes = cstr(nf_qtdevolumes)
		    nf_valortotal = r("nf_valortotal")
		    if isNull(nf_valortotal) then nf_valortotal = "" else nf_valortotal = trim(replace(cstr(FormatCurrency(nf_valortotal)), "R$", ""))
		    nf_dataemissao = r("nf_dataemissao")
		    if isNull(nf_dataemissao) then nf_dataemissao = ""
		    nf_nconhecimento = r("nf_nconhecimento")
		    if isNull(nf_nconhecimento) then nf_nconhecimento = ""
		    nf_tipo = r("nf_tipo")
		    if isNull(nf_tipo) then nf_tipo = "" else nf_tipo = cstr(nf_tipo)
		    trans_id = r("trans_id")
		    if isNull(trans_id) then trans_id = "" else trans_id = cstr(trans_id)
		    enf_id = r("enf_id")
		    if isNull(enf_id) then enf_id = "" else enf_id = cstr(enf_id)
		    nf_descriminacao = r("nf_descriminacao")
		    if isNull(nf_descriminacao) then nf_descriminacao = ""
		    aceite = r("NF_ACEITE")
		    if isNull(aceite) then aceite = "" else aceite = cstr(aceite)
		    integridade = r("NF_INTEGRIDADE")
		    if isNull(integridade) then integridade = "" else integridade = cstr(integridade)
		    carta = r("NF_CARTA")
		    if isNull(carta) then carta = ""
		    volume = r("NF_VOLUME")
		    if isNull(volume) then volume = "" else volume = cstr(volume)
		    devolucao = r("NF_DEVOLUCAOCOMPLETA")
		    if isNull(devolucao) then devolucao = False else devolucao = cbool(devolucao)
		    nf_cfop = r("nf_cfop")
		    if isNull(nf_cfop) then nf_cfop = ""
		    no_id = r("no_id")
		    if isNull(no_id) then no_id = ""
		    nf_id_pai = r("nf_id_pai")
		    if isNull(nf_id_pai) then nf_id_pai = ""
		    nf_validade = r("nf_validade")
		    if isNull(nf_validade) then nf_validade = ""
		    nf_data = r("nf_data")
		    if isNull(nf_data) then nf_data = ""
		    nf_recebimento = r("nf_recebimento")
		    if isNull(nf_recebimento) then nf_recebimento = ""

	    end if
	    r.close
	    set r = nothing
    end if
%>
<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
	<!--#include file="includes/montacnpj.inc"-->
</script>

<div class="margem-10">
<form method="post" action="cad_nf2.asp" name="formulario" onSubmit="javascript:return validaNota(this);">

<input type="hidden" name="nf_id" value="<%=nf_id%>">

<table class="largura-total">
    <tr><td><b><%=titulo%></b></td></tr>
<%
if request("msg")<>"" then%>
	<tr>
		<td><b>
<%	if request("msg") = "1" then
		response.write "Nota Fiscal atualizada com sucesso !"
	elseif request("msg") = "2" then
		response.write "Nota Fiscal apagada com sucesso !"
	end if
%>		</b>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr><%
end if
%>
    <tr> 
      <td>
            <table class="largura-total">
    		  <tr>
				<td>
					<table class="largura-total">
					    <tr>
						    <td>
                                Número da Nota:&nbsp;
    						    <input type="text"  name="nf_numeronota" size="10" maxlength="30" value="<%=nf_numeronota%>">
						    </td>
						    <td>
                                <input type="Checkbox" name="devolucao" value="1" <%if devolucao then response.write "checked"%>>&nbsp;Devolucao Completa</td>
						    <td>
                                Qtde. Volumes:&nbsp;
						        <input type="text"  name="nf_qtdevolumes" size="10" maxlength="30"value="<%=nf_qtdevolumes%>">
						    </td>
						    <td>
                                Valor Total&nbsp;R$:
						        <input type="text"  name="nf_valortotal" size="15" maxlength="30" value="<%=nf_valortotal%>">
						    </td>
					    </tr>
				        </table>
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>
						<table class="largura-total">
							<TR>
								<TD>Data da Emissão:&nbsp;
								<%RW Combo.Data("emissao")%>
								<script type="text/javascript">
									document.all.diaemissao.value = "<%if nf_dataemissao <> "" then response.write Zeros(Day(CDate(nf_dataemissao)),2)%>";
									document.all.mesemissao.value = "<%if nf_dataemissao <> "" then response.write Zeros(Month(CDate(nf_dataemissao)), 2)%>";
									document.all.anoemissao.value = "<%if nf_dataemissao <> "" then response.write Year(CDate(nf_dataemissao))%>";
								</script>
								</td>

								<TD>Número do Conhecimento:&nbsp;
								<input type="text"  name="nf_nconhecimento" size="10" maxlength="30" value="<%=nf_nconhecimento%>"></td>
								<TD>
									Tipo:&nbsp;
									<select name="nf_tipo"  onChange="javascript:tipoNota(this);">
									<option value="1" <%if nf_tipo = "1" then response.write "selected"%>>Entrada</option>
									<option value="2" <%if nf_tipo = "2" then response.write "selected"%>>Saída</option>
									</select>
									<script type="text/javascript">
										function tipoNota(eu) {
											if(eu.value == "1") {
												document.all.tr_aceitacao.style.display = "block";
												document.all.tr_aceitacao_separador.style.display = "block";

												document.all.sp_fornecedor.innerText = 'Fornecedor';
												document.all.tr_fornecedor.style.display = "none";
												document.all.tr_destino.style.display = "block";
											}
											else {
												document.all.tr_aceitacao.style.display = "none";
												document.all.tr_aceitacao_separador.style.display = "none";

												document.all.tr_fornecedor.style.display = "block";
												document.all.tr_destino.style.display = "none";
												document.all.sp_fornecedor.innerText = 'Destino';
											}
										}
									</script>
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>

				<tr>
					<td>
						Data de Recebimento:&nbsp;
						<%RW Combo.Data("recebimento")%>
						<script type="text/javascript">
							document.all.diarecebimento.value = "<%if nf_recebimento <> "" then response.write Zeros(Day(CDate(nf_recebimento)),2)%>";
							document.all.mesrecebimento.value = "<%if nf_recebimento <> "" then response.write Zeros(Month(CDate(nf_recebimento)), 2)%>";
							document.all.anorecebimento.value = "<%if nf_recebimento <> "" then response.write Year(CDate(nf_recebimento))%>";
						</script>
						<!--
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Data de Entrada Real:&nbsp;
						-->
						<%'Call ComboData("real")%>
						<!-- ALTERADO POR NAO SER MAIS NECESSARIO ESTE CAMPO.
						VISANDO MINIMIZAR AS ALTERACOES FOI COLOCADO A DATA DE ATUALIZACAO -->
						<input type="hidden" name="diareal" value="" style="display:none;">
						<input type="hidden" name="mesreal" value="" style="display:none;">
						<input type="hidden" name="anoreal" value="" style="display:none;">
						<script type="text/javascript">
							document.all.diareal.value = "<%response.write Zeros(Day(Date()),2)%>";
							document.all.mesreal.value = "<%response.write Zeros(Month(Date()), 2)%>";
							document.all.anoreal.value = "<%response.write Year(Date())%>";
						</script>
					</td>
				</tr>

				<tr>
					<TD><br>Transportadora:&nbsp;
<%			if trans_id = "" then valor = "" else valor = cstr(trans_id)
			RW Combo.Fornecedor("trans_id", valor, "N", "TRANSPORTADORA", false)%>
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>

				<tr id="tr_fornecedor" style="display:none;"><TD><b>Fornecedor: <%=Application("SISLAB_NOME_EMPRESA")%> CRT</b><BR><BR></td></tr>

				<tr>
					<TD><span id='sp_fornecedor'>Fornecedor</span>:&nbsp;
<%			if enf_id = "" then valor = "" else valor = cstr(enf_id)
			RW Combo.Fornecedor("enf_id", valor, "N", "FORNECEDOR", false)%>
					</td>
				</tr>

				<tr id="tr_destino" style="display:block;"><TD><BR><b>Destino: <%=Application("SISLAB_NOME_EMPRESA")%> CRT</b></td></tr>

				<tr>
					<td>
						<table class="largura-total">
							<tr>
								<td>
                                    Natureza de Operação:&nbsp;
<%			if no_id = "" then valor = "" else valor = cstr(no_id)
			RW Combo.PadraoSql("no_id", "select no_id as VALOR, no_descricao as DESCRICAO from sce_natureza_operacao order by no_descricao", valor, "N")%>
								<script type="text/javascript">
									document.all.no_id.onchange = temValidade;
									function temValidade() {
										document.forms[0].action = "cad_nf_temvalidade.asp";
										document.forms[0].target = "escondido";
										document.forms[0].method = "post";
										document.forms[0].submit();
									}
								</script>
								</td>
								<script type="text/javascript">
									function f4(){
										if (document.formulario.nf_cfop.value != ''){
											document.formulario.nf_cfop.value = document.formulario.nf_cfop.value+'.';
										}
									}
								</script>
								<td>
                                    CFOP:&nbsp;
								    <input type="text" name="nf_cfop" size="10" maxlength="30"value="<%=nf_cfop%>">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr id="tr_validade_separador" style="display: none;"><td>&nbsp;</td></tr>
				<tr id="tr_validade" style="display: none;">
					<TD>
						Validade em Dias:&nbsp;
						<input type="text" name="nf_validade" size="10" maxlength="30"  value="<%=nf_validade%>">
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>
				<tr>
					<td>Vincula&ccedil;&atilde;o:&nbsp;
<%						if nf_id_pai = "" then valor = "" else valor = cstr(nf_id_pai)
						RW Combo.PadraoSql("nf_id_pai", "select a.nf_id as VALOR, b.enf_nome + ' (NF ' + CAST(a.nf_numeronota as VARCHAR) + ')' as DESCRICAO from sce_nota_fiscal a, sce_empresa_nota_fiscal b where a.enf_id = b.enf_id order by b.enf_nome, a.nf_numeronota", valor, "N")%>
					</td>
				</tr>

				<tr><td>&nbsp;</td></tr>

				<tr id="tr_aceitacao" style="display: block;">
					<td>
						<table>
							<tr>
								<td colspan=3>
								<b>Aceitação</b><br>
								Integridade:&nbsp;
								<input type="radio" name="integridade" value="1" <%if integridade = "1" then response.write "checked"%>>&nbsp;Conforme
								<input type="radio" name="integridade" value="0" <%if integridade = "0" then response.write "checked"%>>&nbsp;Não Conforme
								<br>
								Números de Volume:&nbsp;
								<input type="radio" name="volume" value="1" <%if volume = "1" then response.write "checked"%>>&nbsp;Conforme
								<input type="radio" name="volume" value="0" <%if volume = "0" then response.write "checked"%>>&nbsp;Não Conforme
								<br>
								Carta de Correção:&nbsp;
								<input type="radio" name="carta" value="P" <%if carta = "P" then response.write "checked"%>>&nbsp;Pendente
								<input type="radio" name="carta" value="R" <%if carta = "R" then response.write "checked"%>>&nbsp;Recebida
								<br>
								Inspeção Técnica:&nbsp;
								<input type="radio" name="aceite" value="1" <%if aceite = "1" then response.write "checked"%> value="1">&nbsp;Conforme
								<input type="radio" name="aceite" value="0" <%if aceite = "0" then response.write "checked"%> value="1">&nbsp;Não Conforme
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr id="tr_aceitacao_separador" style="display: block;"><td>&nbsp;</td></tr>
				<tr>
					<td>Observação:<br>
						<textarea name="descriminacao" cols=80 rows=5 class=form><%=nf_descriminacao%></textarea>
					</td>
				</tr>
			</table>
      </td>
    </tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<input type="submit" class="btn btn-primary" <%if nf_id = "" then%> value="Cadastrar" <%else%> value="Alterar" <%end if%>>
<%
if nf_id <> "" then%>
			&nbsp;&nbsp;
			<input  type="button" class="btn btn-primary" value="Nova Nota" onClick="javascript:location.href='cad_nf.asp';">
			&nbsp;&nbsp;
			<input  type="button" class="btn btn-primary" value=" Excluir " onClick="javascript:excluirNota();"><%
end if
%>
		</td>
	</tr>
</table>
</form>
<iframe src="" name="escondido" style="display: none;"></iframe>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
<script type="text/javascript">
function excluirNota() {
	document.formulario.action="exc_nf.asp";
	document.formulario.target = "";
	document.formulario.method = "post";
	document.formulario.submit();
}
function checaValidade(valor) {
	if( isNaN(valor) ) // || (valor.substring(0,1) == " ") || (valor == ""))
	{
		return false;
	}
	else
	{
		return true;
	}
}
function validaNota(frm) {
	frm.action = "cad_nf2.asp";
	frm.target = "";
	frm.method = "post";

	if( frm.nf_numeronota.value == "" ) {
		alert("Número da nota não informado");
		frm.nf_numeronota.focus();
	}
	else if( frm.nf_qtdevolumes.value == "" ) {
		alert("Quantidade de volumes não informada");
		frm.nf_qtdevolumes.focus();
	}
	else if( frm.nf_valortotal.value == "" ) {
		alert("Valor da nota fiscal não informado");
		frm.nf_valortotal.focus();
	}
	else if( (frm.diaemissao.value == "") || (frm.mesemissao.value == "") || (frm.anoemissao.value == "") ) {
		alert("Data de emissão inválida");
		frm.diaemissao.focus();
	}
	else if( frm.no_id.value == "" ) {
		alert("Natureza da operação não informada");
		frm.no_id.focus();
	}
	else if( !checaValidade(frm.nf_validade.value ) ) {
		alert("Validade da nota incorreta")
		frm.nf_validade.select();
		frm.nf_validade.focus();
	}
	else if( frm.enf_id.value == "" ) {
		alert("Fornecedor não informado");
		frm.enf_id.focus();
	}
	else if( frm.no_id.value == "" ) {
		alert("Natureza da operação não informada");
		frm.no_id.focus();
	}
	else if( frm.nf_cfop.value == "" ) {
		alert("CFOP não informado");
		frm.nf_cfop.focus();
	}
	else if( (frm.diarecebimento.value == "") || (frm.mesrecebimento.value == "") || (frm.anorecebimento.value == "") ) {
		alert("Data de recebimento inválida");
		frm.diarecebimento.focus();
	}
	else if( (frm.diareal.value == "") || (frm.mesreal.value == "") || (frm.anoreal.value == "") ) {
		alert("Data de entrada real inválida");
		frm.diareal.focus();
	}
	else {
		return true; }
	return false;
}

<%if nf_tipo <> "" then%>
	tipoNota(document.all.nf_tipo);
<%end if%>

<%if nf_id <> "" then%>
	temValidade();
<%end if%>
</script>