<!-- #INCLUDE FILE="includes/abre.asp" -->
<!-- #INCLUDE FILE="includes/global_SCE.asp" -->
<!--#include file="interface_s_rt.inc"-->
<script>
	<!--#include file="includes/vform.js"-->
</script>
<center>

<form name="formulario" method="post" action="reserva3.asp" onsubmit="vdform('formulario','asa','AS','R','saida','Sair Como','R','solicitante','Solicitante','R','cde','CDE','R','def','Defeito','R','diar','Dia do Recolhimento','RNumber','mesr','Mes do Recolhimento','RNumber','anor','Ano do Recolhimento','RNumber','diarep','Dia da Reserva','RNumber','mesrep','Mes da Reserva','RNumber','anorep','Ano da Reserva','RNumber'); return document.ValorPassou;">
<input type=hidden name=eq_id value="<%=request("eq_id")%>">

  <table width="780">
	<tr>
		<td  class="titulo"><i>Reserva de Itens</i>&nbsp;>><a href="javascritp:history.back()">voltar</a><br><br><br><br></td>
	</tr>
    <tr> 
		<td class="titulo">Reserva  de Itens</td>
	</tr>
	<tr>
		<td valign="top" CLASS="texto"><br>
			Natureza de Operação:<br>
				<select name="noid" class="form" >
<%					ssql = "select * from sce_natureza_operacao "
					ssql = ssql & "where no_tipo = " & STATUS_EM_USO & " "
					ssql = ssql & "order by no_descricao"
					set rec = conn.execute(ssql)
					if not rec.eof then	
						while not rec.eof%>
					<option value="<%=rec("no_id")%>"><%=rec("no_descricao")%></option>
<%							rec.movenext
						wend
					end if%>
	 			</select>
			<br>
		</td>
		<td valign="top" CLASS="texto"><br>
			AS:<br>
			<input type=text name=asa class=form><br><br>
		</td>
	</tr>	
	<tr>
		<td valign="top" CLASS="texto"><br>
			Status:<br>
			<select name="status" class="form" >
				<option value="1">Efetuada </option>
				<option value="2">Cancelada</option>
 			</select><br>
						</td>

		<td valign="top" CLASS="texto"><br>
			Sair como:<br>
			<select name="saida" class="form" onchange="func();">
				<option value="1">Amostra </option>
				<option value="2">Equipamento</option>
 			</select><br>
						</td>
	</tr>
	<tr>
		<td valign="top" CLASS="texto"><br>
			Solicitante:<br>
			<input type=text name=solicitante class=form><br>
						</td>

		<td valign="top" CLASS="texto"><br>
			CDE:<br>
			<input type=text name=cde class=form><br>
						</td>
					
	
		</tr>
	<tr>
		<td valign="top" CLASS="texto"><br>
			Defeito:<br>
			<input type=text name=def class=form><br>
						</td>
					
		<td valign="top" CLASS="texto"><br>
			Prazo(em dias):<br>
			<input type=text name=diarep class=form><br>
						</td>
					
	</tr>
	<tr>
		<td valign="top" CLASS="texto"><br>
			Data de Retirada:<br>
			<input type=text name=diar class=form maxlength="2" size=3>&nbsp;/&nbsp;<input type=text name=mesr class=form maxlength="2" size=3>&nbsp;/&nbsp;<input type=text name=anor class=form maxlength="4" size=5><br>
						</td>
					
	</tr>
	<tr>
		<td valign="top" CLASS="texto"><br>
			
			<input type=submit value=" Reservar " class=form><br>
						</td>
					
	</tr>
	
 </table>
</form>

<!--#include file="interface_i.inc"-->
