<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
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
Tela.SetNomeTela = "Cadastro > Modelo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    'Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
    function ValidaCampos()
    {
	    var frm = document.formulario;
	    if (frm.mod_codnome.value.length == 0)
	    {
		    alert("Defina o Modelo!");
		    frm.mod_codnome.focus();
		    return false;
	    }
	
	    else if (frm.fab_id.value.length == 0)
	    {
		    alert("Defina o fabricante do Modelo!");
		    frm.fab_id.focus();
		    return false;
	    }
	    return true;
    }
</script>

<div class="margem-10">
    <form method=post action="cad_modelos2.asp" name="formulario"  onsubmit="return ValidaCampos();">
        <table width="100%">
	        <tr>
		        <td>
<%		msg =  request("msg")
		if msg = 1 then
		response.write "<b>Modelo inserido com sucesso!</b><br><br>"
		elseif msg = 2 then
		response.write "<b>Este Part Number já existe</b><br><br>"
		end if%>
		        </td>
	        </tr>
	        <tr>
		        <td>
  			        <table class="largura-total" style="">
                        <tr>
                            <td>
                                Modelo:&nbsp;<input type="text"  name="mod_codnome" size=35 maxlength="50">
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fabricante:&nbsp;
                                <%RW Combo.PadraoSql("fab_id", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
                            </td>
                        </tr>
                    </table>
	  	        </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
	        <tr>
		        <td>
  			        <table class="largura-total">
	  			        <tr> 
	      		           <td>
                                 SaP:&nbsp;
					            <input type="text"  name="mod_net" style="width:100" maxlength="100">
					       </td>
				          <td>
                              Área de Utilização:
				          <%ssql = "select * from sce_areautilizacao order by au_descricao"
				          set rec = Env.oconn.execute(ssql)
				          if not rec.eof then%>
					        <select name="au_id" >
                                <option value="">--</option>
					        <%i = 0
					        while not rec.eof%>
						        <option value="<%=rec("au_id")%>"><%=rec("au_descricao")%></option>
						        <%rec.movenext
					        wend%>
					        </select>
				           <%else%>
				   	        <strong>Para cadastrar, clique <a href="cad_areasutilizacao.asp">aqui.</a></strong>
				           <%n = 1
				           end if%>
				           </td>
	    		        </tr>
			        </table>
	  	        </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
	        <tr> 
		        <td>
  			        <table>
	  			        <tr> 
    			        <!--  <td>
				  	        Código do SGP:&nbsp;
					        <input type="text"  name="cod_sgp" size="20" maxlength="100"><br><br>
				        </td>-->
				        <td>Família Tipo:&nbsp;
					        <%ssql = "select * from sce_tipos order by tipo_descricao"
					        set rec = Env.oconn.execute(ssql)
					        if not rec.eof then%>
						        <select name="tipo_id" >
						        <option value=""></option>
						        <%while not rec.eof%>					
							        <option value="<%=rec("tipo_id")%>"><%=rec("tipo_descricao")%></option>
							        <%rec.movenext
						        wend%>
						        </select>
					        <%else%>
						        <strong> Para cadastrar, clique <a href="cad_tipos.asp">aqui.</a></strong>
					        <%n = 1
					        end if%>
					        </td>	
				         </tr>
			        </table>
		        </td>
	        </tr>
            <tr><td>&nbsp;</td></tr>
            <tr> 
                <td>
                    Descrição do Modelo<br>
                    <textarea style="width:550" cols="80" rows="5" name="mod_descricao" ></textarea>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
	        <tr> 
      	        <td>Observações<br>
		        <textarea  name="mod_obs" style="width:550" cols="80" rows="5"></textarea></td>
	        </tr>
            <tr><td>&nbsp;</td></tr>
	        <tr> 
      	        <td>
                    Part Number:<br>
    		        <input type="text"  name="p_number" size="60" maxlength="50">
      	        </td>
	        </tr>
	        <tr>
		        <td><input type="checkbox" name="sgp" value="1" checked>&nbsp;atualizar pelo SGP</td>
	        </tr>
            <tr><td>&nbsp;</td></tr>
            <tr> 
                <td><%if n <> 1 then%><input type="submit" class="btn btn-primary" name="Submit" value=" Cadastrar " ><%end if%></td>
            </tr>
          </table>
    </form>
</div>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
