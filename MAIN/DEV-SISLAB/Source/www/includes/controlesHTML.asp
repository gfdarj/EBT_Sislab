<script type="text/javascript">
    function replaceSubstring(inputString, fromString, toString) {
       // Goes through the inputString and replaces every occurrence of fromString with toString
       var temp = inputString;
       if (fromString == "") {
          return inputString;
       }
       if (toString.indexOf(fromString) == -1) { // If the string being replaced is not a part of the replacement string (normal situation)
          while (temp.indexOf(fromString) != -1) {
             var toTheLeft = temp.substring(0, temp.indexOf(fromString));
             var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
             temp = toTheLeft + toString + toTheRight;
          }
       } else { // String being replaced is part of replacement string (like "+" being replaced with "++") - prevent an infinite loop
          var midStrings = new Array("~", "`", "_", "^", "#");
          var midStringLen = 1;
          var midString = "";
          // Find a string that doesn't exist in the inputString to be used
          // as an "inbetween" string
          while (midString == "") {
             for (var i=0; i < midStrings.length; i++) {
                var tempMidString = "";
                for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
                if (fromString.indexOf(tempMidString) == -1) {
                   midString = tempMidString;
                   i = midStrings.length + 1;
                }
             }
          } // Keep on going until we build an "inbetween" string that doesn't exist
          // Now go through and do two replaces - first, replace the "fromString" with the "inbetween" string
          while (temp.indexOf(fromString) != -1) {
             var toTheLeft = temp.substring(0, temp.indexOf(fromString));
             var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
             temp = toTheLeft + midString + toTheRight;
          }
          // Next, replace the "inbetween" string with the "toString"
          while (temp.indexOf(midString) != -1) {
             var toTheLeft = temp.substring(0, temp.indexOf(midString));
             var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
             temp = toTheLeft + toString + toTheRight;
          }
       } // Ends the check to see if the string being replaced is part of the replacement string or not
       return temp; // Send the updated string back to the user
    } // Ends the "replaceSubstring" function
</script>

<%
Function ControleParticipantesInternos(nome, index, titulo1, titulo2, ag_numero)
	if titulo1 = "" then titulo1 = "Dados dos Participantes " & Application("SISLAB_NOME_EMPRESA")
	if titulo2 = "" then titulo2 = "Participantes " & Application("SISLAB_NOME_EMPRESA")
%>
    <script type="text/javascript">
        function adiciona_retira_participantes<%=nome%>(tipo)
        {
	        var frm = document.forms[0];
	        var nome = frm.txtNome<%=nome%>;
	        var motivo = frm.txtMotivo<%=nome%>;
	        var lista = frm.lst<%=nome%>;

	        if (tipo == 0)
	        {
		        if (lista.selectedIndex != -1) {
			        lista.options[lista.selectedIndex] = null;
		        }
	        }
	        else{
		        if (nome.value == ""){
			        alert("O campo 'E-mail' deve ser preenchido.");
			        nome.focus();		
		        }
		        else if (motivo.value == ""){
			        alert("O campo 'Motivo da Participação' deve ser preenchido.");
			        motivo.focus();		
		        }
		        else{
			        submitFormEscondido();
		        }
	        }
        }
        function submitFormEscondido()
        {
	        var frm = document.forms[0]
	        var nome = frm.txtNome<%=nome%>;
	        frm.action = "eventosInternos.asp?hdnevento=<%=7%>&nome="+nome.value+"&nomeControle=<%=nome%>&ag_numero=<%=ag_numero%>";
	        frm.method = "post";
	        frm.target = "escondido";
	        frm.submit();
        }
    </script>

    <input type="hidden" name="txtNomeCompleto<%=nome%>">

    <div id="tab<%=Nome%>" style="width: 100%; display: block;">
        <div class="linha-fundo" style="width:100%;"><strong><%=titulo1%></strong></div>
        <br />
        <div>
            E-mail:&nbsp;<input  name="txtNome<%=nome%>" size="40" tabindex="<%=index%>" maxlength="80">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Motivo da participação:&nbsp;<input  name="txtMotivo<%=nome%>" size="40" tabindex="<%=index + 1%>" maxlength="200">
        </div>
        <br />
        <div>
            <input  type="button" name="btninsere" value="Adicionar" onClick="adiciona_retira_participantes<%=nome%>(1)" tabindex="<%=index + 2%>" title="Adiciona um participante <%=Application("SISLAB_NOME_EMPRESA")%> na lista">
		    &nbsp;
		    <input  type="button" name="btnretira" value="Remover" onClick="adiciona_retira_participantes<%=nome%>(0)" tabindex="<%=index + 3%>" title="Remove um participante <%=Application("SISLAB_NOME_EMPRESA")%> na lista">
        </div>
        <br />
        <div>
		<%=titulo2%>
        <br />
	        <select name="lst<%=nome%>"  size="4"
			    style="LINE-HEIGHT: 30px; PADDING-TOP: 3px; WIDTH: 640px; overflow: auto;"
			    multiple tabindex="<%=index + 4%>">
            </select>
        </div>
        <br />
    </div>

    <script type="text/javascript">
        document.getElementById("tab<%=nome%>").style.display = 'none';
    </script>
<%
End Function

Function ControleQuantidade(nome,titulo,nomeCampo1,sql,index)%>
<script type="text/javascript">
function adiciona_retira_<%=nome%>(tipo)
{
	var frm = document.forms[0]
	var fac = frm.cmb<%=nome%>;
	var qtd = frm.txtqtd<%=nome%>;
	var lista = frm.lst<%=nome%>;
	var str1 = frm.str<%=nome%>;

	if ( tipo == 0){
		if (lista.selectedIndex != -1){
			str1.value = replaceSubstring(str1.value, lista.options[lista.selectedIndex].text + '<%=SEPARADOR_REGISTRO2%>', "");
			lista.options[lista.selectedIndex]=null;
		}
	}
	else{
		if (fac.value == ""){
			alert("O combo de <%=nomeCampo1%> deve ser preenchido.");
			fac.focus();		
		}
		else if (qtd.value == ""){
			alert("O campo 'Quantidade' deve ser preenchido.");
			qtd.focus();		
		}
		else{
			adiciona<%=nome%>()
		}
	}
}

function adiciona<%=nome%>(){
var frm = document.forms[0]

var fac = frm.cmb<%=nome%>;
var qtd = frm.txtqtd<%=nome%>;
var lista = frm.lst<%=nome%>;
var str1 = frm.str<%=nome%>;

lista.options[lista.options.length]=new Option(fac.value + " - " + qtd.value);
str1.value = str1.value + fac.value + "<%=SEPARADOR_CAMPO%>" + qtd.value + '<%=SEPARADOR_REGISTRO%>';
fac.value = "";
qtd.value = "";
fac.focus();
}
</script>

<input type="hidden" name="str<%=Nome%>"/>
<table id="tab<%=Nome%>" border="0" style="width: 100%;">
<tr>
	<td bgcolor="#d9d9d9">
		<font face="tahoma" color="#222222" style="font-size: 10pt; font-weight: bold;">
		<%=titulo%>:</font></td>
</tr>
<tr>
    <td>
		<table width="100%" border="0">
        <tr> 
			<td width="12%">
				<font class="item">&nbsp;<%=nomeCampo1%>:</font></td>
			<td width="33%"> 
			<select  name="cmb<%=nome%>" tabindex="<%=index+1%>">
				<%call comboBD(objConn,sql)%>
			</SELECT>
            <td rowspan="3" width="9%"> 
                <table width="30%" border="0">
                <tr>
		            <td>
						<input class="cxtexto" type="button" name="btninsere" value=">" onClick="adiciona_retira_<%=nome%>(1)" tabindex="<%=index+3%>"></td>
                </tr>
                <tr>
					<td>
	                    <input class="cxtexto" type="button" name="btnretira" value="<" onClick="adiciona_retira_<%=nome%>(0)" tabindex="<%=index+4%>"></td>
                </tr>
		</tr>
        </table>
	</td>

    <td  rowspan="3" width="46%"> 
		<font class="item"><%=titulo%>:</font>
        <select name="lst<%=nome%>" size=4           
	       style="FONT-FAMILY: serif; FONT-SIZE: 10pt; LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 250px" 
           multiple tabindex="<%=index+5%>">
        </select>
	</td>
</tr>
<tr> 
	<td width="12%">
		<font class="item">&nbsp;Quantidade</font></td>
	<td width="33%"> 
		<input class="cxtexto" name="txtqtd<%=nome%>" size="1" onKeyPress="onlynum(this)" tabindex="<%=index+2%>" maxlength="200"></td>
</tr>
</table>
</table>
<%end function

Function ControleComboMultiplo(nome,titulo,nomeCampo1,sql,index)%>
<script type="text/javascript">
    function adiciona_retira_<%=nome%>(tipo)
    {
	    var frm = document.forms[0]
	    var fac = frm.cmb<%=nome%>;
	    var lista = frm.lst<%=nome%>;
	    var str1 = frm.str<%=nome%>;

	    if ( tipo == 0){
		    if (lista.selectedIndex != -1){
			    str1.value = replaceSubstring(str1.value, lista.options[lista.selectedIndex].text + '<%=SEPARADOR_REGISTRO%>', "");
			    lista.options[lista.selectedIndex]=null;
		    }
	    }
	    else{
		    if (fac.value == ""){
			    alert("O combo de <%=nomeCampo1%> deve ser preenchido.");
			    fac.focus();		
		    }
		    else{
			    adiciona<%=nome%>()
		    }
	    }
    }

    function adiciona<%=nome%>()
    {
        var frm = document.forms[0]

        var fac = frm.cmb<%=nome%>;
        var lista = frm.lst<%=nome%>;
        var str1 = frm.str<%=nome%>;

        lista.options[lista.options.length] = new Option(fac.value);
        str1.value = str1.value + fac.value + '<%=SEPARADOR_REGISTRO%>';
        fac.value = "";
        fac.focus();
    }
</script>

<input type="hidden" name="str<%=Nome%>" />

<div style="width: 100%;" class="linha-fundo"><strong><%=titulo%></strong></div>

<table id="tab<%=Nome%>" border="0" class="table-condensed" style="width: 100%;">
<tr>
    <td>
		<table width="100%" border="0" class="table-condensed">
        <tr> 
			<td width="12%">
				<%=nomeCampo1%>:</td>
			<td width="33%"> 
			<select name="cmb<%=nome%>" tabindex="<%=index+1%>">
				<%'call comboBD(objConn,sql)%>
				<%call comboBDpadrao(objConn,sql,"null")%>
			</SELECT>
            <td rowspan="3" width="9%"> 
                <table width="30%" border="0" class="table-bordered">
                <tr>
		            <td>
						<input  type="button" name="btninsere" value=">" onClick="adiciona_retira_<%=nome%>(1)" tabindex="<%=index+3%>">
					</td>
                </tr>
                <tr>
					<td>
	                    <input  type="button" name="btnretira" value="<" onClick="adiciona_retira_<%=nome%>(0)" tabindex="<%=index+4%>">
					</td>
                </tr>
				</table>
			</td>
		</tr>
        </table>
	</td>
    <td  rowspan="3" width="46%"> 
		<%=titulo%>:
        <select name="lst<%=nome%>" size="4"  style="WIDTH: 250px" multiple tabindex="<%=index+5%>">
        </select>
	</td>
</tr>
</table>
<%
End Function

Function ControleComboMultiplo2(nome, titulo, nomeCampo1, sql, index, TIPOCAMPO)%>
<script type="text/javascript">
	function adiciona_retira_<%=nome%>(tipo)
	{
		var frm = document.forms[0]
		var fac = frm.cmb<%=nome%>;
		var lista = frm.lst<%=nome%>;
		var str1 = frm.str<%=nome%>;

		if ( tipo == 0){
			if (lista.selectedIndex != -1){
				<%IF TIPOCAMPO = "TEXTO" THEN%>
					//lista.options[lista.options.length] = new Option(fac.value.substr(0,fac.value.length / 2));
					strASerRetirada = lista.options[lista.selectedIndex].text + ' - ' + lista.options[lista.selectedIndex].text + '<%=SEPARADOR_REGISTRO%>'
					str1.value = replaceSubstring(str1.value, strASerRetirada, "");
				<%ELSE%>
					//lista.options[lista.options.length] = new Option(fac.value);
					str1.value = replaceSubstring(str1.value, lista.options[lista.selectedIndex].text + '<%=SEPARADOR_REGISTRO%>', "");
				<%END IF%>
				lista.options[lista.selectedIndex]=null;
			}
		}
		else{
			if (fac.value == ""){
				alert("O combo de <%=nomeCampo1%> deve ser preenchido.");
				fac.focus();		
			}
			else{
				adiciona<%=nome%>()
			}
		}
	}

	function adiciona<%=nome%>()
	{
		var frm = document.forms[0]

		var fac = frm.cmb<%=nome%>;
		var lista = frm.lst<%=nome%>;
		var str1 = frm.str<%=nome%>;
		var rExp = fac.value + '<%=SEPARADOR_REGISTRO%>';

		resp = str1.value.lastIndexOf(rExp)
		if (resp == -1){
			<%IF TIPOCAMPO = "TEXTO" THEN%>
				lista.options[lista.options.length] = new Option(fac.value.substr(0,(fac.value.length / 2)-1));
			<%ELSE%>
				lista.options[lista.options.length] = new Option(fac.value);
			<%END IF%>
			str1.value = str1.value + fac.value + '<%=SEPARADOR_REGISTRO%>';
			fac.value = "";
			fac.focus();
		}else{
			alert('Item já consta na lista.');
		}
	}
</script>

<input type="hidden" name="str<%=Nome%>"/>

<table id="tab<%=Nome%>" border="0">
<tr>
	<th>
		<%=titulo%>
	</th>
</tr>
<tr>
	<td>
		<table style="width: 100%;">
		<tr>
			<td width="12%">
				<%=nomeCampo1%><br />
			    <select  name="cmb<%=nome%>" tabindex="<%=index+1%>" size="6" ondblclick="javascript:adiciona_retira_<%=nome%>(1)" style="LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 580px" >
				    <%call comboBD(objConn,sql)%>
			    </select>
            </td>
		</tr>
		<tr>
			<td style="text-align: center;">
				<input  type="button" name="btnretira" value="Retirar" onClick="adiciona_retira_<%=nome%>(0)" tabindex="<%=index+3%>">&nbsp;
				<input  type="button" name="btninsere" value="Adicionar" onClick="adiciona_retira_<%=nome%>(1)" tabindex="<%=index+4%>">
			</td>
		</tr>
		<tr>
			<td>
				<%=titulo%><br />
				<select name="lst<%=nome%>"  size=6
				    style="LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 580px" ondblclick="javascript:adiciona_retira_<%=nome%>(0)"
				    tabindex="<%=index+5%>">
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%
End Function


'-- tive que colocar este pq o paulo fez uma zona complicando uma coisa
'-- que deveria ser fácil - nas outras combos ele poe o VALUE combinado com 
'-- o ID + DESCRICAO (Gilberto)
Function ControleComboMultiplo3(nome, titulo, nomeCampo1, sql, index) %>
<script type="text/javascript">
    function adiciona_retira_<%=nome%>(tipo)
    {
        var frm = document.forms[0];
	    var fac = frm.cmb<%=nome%>;
	    var lista = frm.lst<%=nome%>;
	    var str1 = frm.str<%=nome%>;

        if (tipo == 0)
        {
            if (lista.selectedIndex != -1)
            {
                str1.value = str1.value.replace(lista.options[lista.selectedIndex].value + "<%=SEPARADOR_REGISTRO%>", "");
                lista.remove(lista.selectedIndex);
		    }
	    }
	    else{
		    if (fac.value == ""){
			    alert("O combo de <%=nomeCampo1%> deve ser preenchido.");
			    fac.focus();		
		    }
		    else{
                adiciona<%=nome %>();
		    }
	    }
    }

    function adiciona<%=nome%> ()
    {
	    var frm = document.forms[0];
	    var last, cont, exists = false;
	    var fac = frm.cmb<%=nome%>;
	    var lista = frm.lst<%=nome%>;
	    var str1 = frm.str<%=nome%>;
	
	    last = lista.options.length;

	    // nao insere registros repetidos
	    for(cont=0; cont < last; cont++) {
		    if(lista.options[cont].value == fac.value) {
			    exists = true;
			    cont = last; //paro a procura
		    }
	    }
	    if(!exists) {
		    lista.options[last] = new Option(fac.options[fac.selectedIndex].text);
		    lista.options[last].value = fac.value;

		    str1.value = str1.value + fac.value + '<%=SEPARADOR_REGISTRO%>';
		    fac.value = "";
	    }
	    else {
		    alert('Este item já existe na lista');
	    }
	    fac.focus();
    }
</script>

<input type="hidden" name="str<%=Nome%>" value=""/>

<div class="linha-fundo"><strong><%=titulo%></strong></div>

<table id="tab<%=Nome%>" width="100%" border="0" class="table-condensed">
<tr>
    <td>
		<table width="100%">
        <tr> 
			<td width="12%">
				&nbsp;<%=nomeCampo1%>:</td>
			<td width="33%"> 
			    <select  name="cmb<%=nome%>" tabindex="<%=index+1%>">
				    <%call comboBDpadrao(objConn,sql,"null")%>
			    </SELECT>
            </td>
            <td rowspan="3" width="9%"> 
                <table>
                <tr>
		            <td>
						<input  type="button" name="btninsere" value=">" onClick="adiciona_retira_<%=nome%>(1)" tabindex="<%=index+3%>">
					</td>
                </tr>
                <tr>
					<td>
	                    <input  type="button" name="btnretira" value="<" onClick="adiciona_retira_<%=nome%>(0)" tabindex="<%=index+4%>">
					</td>
                </tr>
				</table>
			</td>
		</tr>
        </table>
	</td>
    <td rowspan="3" width="46%" style="vertical-align: top;">
		<%=titulo%>:
        <select name="lst<%=nome%>" size="4" 
	       style="LINE-HEIGHT: 50px; PADDING-TOP: 3px; WIDTH: 250px" 
           multiple tabindex="<%=index+5%>">
        </select>
	</td>
</tr>
</table>
<%
End Function


Function SubstituiComboCScript(LabelCampo,NomeControle,NomeControleASubstituir,ValorSelecionado,TextoSelecao,CampoValor,CampoDescricao,rsGenerico,script)%>
<html>
<script type="text/javascript" src="includes/manipulaObj.js"></script>
<head>
	<title><%=Application("SISLAB_NOME_EMPRESA")%></title>
<%Response.Write "<script language=""JavaScript"">"%>
var str = "<font class='Fonttit3Cad'><b><%=LabelCampo%></B></FONT><BR>"
str += "<select name='<%=NomeControle%>' class='combo' ";
	str+=  'onChange="<%=script%>;">';
		str+= '<option selected value=""><%=TextoSelecao%></option>';
<%
	dim subistitui :subistitui = true
	If NOT(rsGenerico is Nothing) Then
		If(rsGenerico.EOF AND rsGenerico.BOF) Then
			subistitui = false
			' nenhum registro foi encontrado
		Else
			While( NOT( rsGenerico.EOF ) )
				if ValorSelecionado<>cstr(rsGenerico(CampoValor)) then%>
					str += "<option value='<%= rsGenerico(CampoValor)%>'><font class='Fonttit3Cad'><%= rsGenerico(CampoDescricao)%></font></option>";
				<%else%>
					str += "<option value='<%= rsGenerico(CampoValor)%>' selected><font class='Fonttit3Cad'><%=rsGenerico(CampoDescricao)%></font></option>";
				<%end if
	 			rsGenerico.MoveNext
			Wend
		End If
	End If
%>
str+="</select>";
<%if subistitui then%>
	parent.document.all.<%=NomeControleASubstituir%>.innerHTML = str;
<%else%>
	parent.document.all.<%=NomeControleASubstituir%>.innerHTML = "<input type='Hidden' name='<%=NomeControle%>' value='-1'/>";
<%end if%>
</script>
</head>
<body>
</body>
</html>
<%
	SubstituiComboCScript = subistitui
end function

function SubstituiCombo(LabelCampo,NomeControle,NomeControleASubstituir,ValorSelecionado,TextoSelecao,CampoValor,CampoDescricao,rsGenerico)%>
<html>
<script type="text/javascript" src="includes/manipulaObj.js"></script>
<%Response.Write "<script language=""JavaScript"">"%>
var str
str = "<font class='Fonttit3Cad'><b><%=LabelCampo%></B></FONT><BR>"
str += "<select name='<%=NomeControle%>' class='combo'>"
		str+= '<option selected value=""><%=TextoSelecao%></option>'
<%
		If (isObject(rsGenerico) AND NOT(rsGenerico is Nothing) ) Then
			If(rsGenerico.EOF AND rsGenerico.BOF) Then
				' nenhum registro foi encontrado
			Else
				While( NOT( rsGenerico.EOF ) )
					if ValorSelecionado<>RTrim(cstr(rsGenerico(CampoValor))) then%>
					str += "<option value='<%=RTrim(rsGenerico(CampoValor))%>'><%=rsGenerico(CampoDescricao)%></option>"
					<%else%>
					str += "<option value='<%=RTrim(rsGenerico(CampoValor))%>' selected><%=rsGenerico(CampoDescricao)%></option>"
					<%end if
	 				rsGenerico.MoveNext
				Wend
			End If
		End If
%>
str+="</select>"

parent.document.all.<%=NomeControleASubstituir%>.innerHTML = str;
</script>
</head>
<body>
</body>
</html><%
end function

sub comboBD(objConn,sql)
	dim rs
	call Env.RecordSet(true, rs, SQL)
	while not rs.EOF
		Response.Write "<option value='" & Server.HtmlEncode(rs("valor")) & "'" 
		Response.Write ">" & rs("descricao") & "</option>" 
		rs.MoveNext()
	wend
	call Env.RecordSet( false, rs, null)
end sub

sub comboBDpadrao(objConn,sql,padrao)
	dim rs
	call Env.RecordSet( true, rs, SQL)
	if padrao = "null" then%>
				<option value="">--</option>
		<%
	end if
	while not rs.EOF
		Response.Write "<option value='" & Server.HtmlEncode(rs("valor")) & "'" 
			if padrao = rs("valor") then response.write " selected "
		Response.Write ">" & rs("descricao") & "</option>" 
		rs.MoveNext()
	wend
	call Env.RecordSet( false, rs, null)
end sub


Sub ComboBD2( nome, objRecordSet, padrao, todos)%>
			<select  name="<%=nome%>">
			<% if todos then%>
							<option value="">-- Todos --</option>
			<%end if%>

<%	While(NOT(objRecordSet.EOF))%>
				<option <%If(CSTR(objRecordSet("VALOR")) = padrao)Then%>selected <%End If%>value="<%=objRecordSet("VALOR")%>"><%=objRecordSet("descricao")%>
<%		objRecordSet.MoveNext
	Wend%>
			</select>
<%End Sub


Sub ComboBDSQL(nome, objConn, SQL, padrao, todos)
	dim objRecordSet
	dim valor, descricao

	call Env.RecordSet( true, objRecordSet, SQL )%>
			<select  name="<%=nome%>">
			<% if todos="N" then%>
							<option value="">--</option>
			<%end if%>
			<% if todos = true then%>
							<option value="" <%If(padrao="")Then%>selected<%End If%>>-- Todos --</option>
			<%end if%>
<%
	If IsNull(padrao) Then padrao = ""

	While(NOT(objRecordSet.EOF))
		Valor = objRecordSet("VALOR")
		If IsNull(Valor) Then Valor = ""
		Descricao = objRecordSet("descricao")
		If IsNull(descricao) Then descricao = ""
%>
				<option <%If(CSTR(Valor) = CSTR(padrao)) Then%>selected <%End If%>value="<%=valor%>"><%=descricao%></option>
<%		objRecordSet.MoveNext
	Wend%>	</select>
<%
	call Env.RecordSet( false, objRecordSet, null)
End Sub


Sub comboBDSQL_2(nome, objConn, SQL, padrao, todos)
	dim objRecordSet
	dim valor, descricao

	Set objRecordSet = objConn.Execute(SQL)%>
			<select  name="<%=nome%>">
			<% if todos="N" then%>
							<option value="">--</option>
			<%end if%>
			<% if todos = true then%>
							<option value="" <%If(padrao="")Then%>selected<%End If%>>-- Todos --</option>
			<%end if%>
<%
	If IsNull(padrao) Then padrao = ""

	While(NOT(objRecordSet.EOF))
		Valor = objRecordSet("VALOR")
		If IsNull(Valor) Then Valor = ""
		Descricao = objRecordSet("descricao")
		If IsNull(descricao) Then descricao = ""
%>
				<option <%If(CSTR(Valor) = CSTR(padrao)) Then%>selected <%End If%>value="<%=valor%>"><%=descricao%></option>
<%		objRecordSet.MoveNext
	Wend%>	</select>
<%
End Sub


'retorna uma combo com todos os RTs visiveis
Sub comboRATeRT(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where (rt = 1 or rat=1) and exibir =1  and not matricula is null order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboRatERtTodos(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where (rt = 1 or rat=1) order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboRt(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rt = 1 and exibir =1  and not matricula is null order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboRtTodos(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rt = 1 order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboRat(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rat = 1 and exibir =1  and not matricula is null order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboRatTodos(nome,objConn,todos)
	dim sSQL
	sSQL = "select UPPER(userid) as valor,nome as descricao from userCRT where rat = 1 order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

'retorna uma combo com todos os usuários visiveis
Sub comboUserCRT(nome,objConn,todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT where exibir =1 and not matricula is null order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboUserCRTVivoEMortos(nome,objConn,todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT order by nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboUSERCRTVIVOEMORTOSSomenteID(nome,objConn, padrao, todos)
	dim sSQL
	sSQL = "select upper(userid) as valor, upper(userid) as descricao from userCRT order by userid"
	call comboBDSQL( nome, objConn,sSQL, padrao, todos)
End Sub

Sub comboServicosPlataformas(nome,objConn,todos,servico_ou_plataforma)
	dim sSQL

	if servico_ou_plataforma = "S" then
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas where s_servico = 1 order by s_descricao"
	elseif servico_ou_plataforma = "P" then
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas where s_servico = 0 order by s_descricao"
	else
		sSQL = "select s_id as valor,s_descricao as descricao from Servicos_Plataformas order by s_descricao"
	end if

	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboUSERCRTcDefault(nome,objConn,def,todos)
	dim sSQL
	sSQL = "select upper(userid) as valor,nome as descricao from userCRT where exibir =1 and not matricula is null order by nome"
	call comboBDSQL( nome, objConn,sSQL, def, todos)
End Sub


Sub comboDePara(nome,objConn,todos)
	dim sSQL
	sSQL = "select 'Orgao' as valor,'Orgão do Solicitante' as descricao union "
	sSQL = sSQL & "(select 'OrgaoInterno' as valor, 'Órgão Interno' as descricao) union "
	sSQL = sSQL & "(select 'ClienteExterno' as valor,'Cliente Externo' as descricao) union "
	sSQL = sSQL & "(select 'TipoAtividade' as valor,'Tipo de Atividade' as descricao) union "
	sSQL = sSQL & "(select 'Tecnologia' as valor,'Tecnologia' as descricao)  UNION"
	sSQL = sSQL & "(select 'Equipamento' as valor,'Equipamento' as descricao)  UNION"
	sSQL = sSQL & "(select 'Testes' as valor,'Testes' as descricao) UNION "
	sSQL = sSQL & "(select 'TipoTeste' as valor, 'TipoTeste' as descricao) UNION "
	sSQL = sSQL & "(select 'Servicos' as valor, 'Serviços' as descricao) UNION "
	sSQL = sSQL & "(select 'Plataformas' as valor, 'Plataformas' as descricao) UNION "
	sSQL = sSQL & "(select 'LB_TipoOcorrencia' as valor,'Tipo de Ocorrência LogBook' as descricao) UNION "
	sSQL = sSQL & "(select 'TipoArquivo' as valor,'Tipo de Arquivo' as descricao) "
	sSQL = sSQL & "ORDER BY descricao"
	'response.write ssql
	'response.end
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboTecnologia(nome,objConn,todos)
	dim sSQL
	sSQL = "select tec_id as valor,tec_nome as descricao from tecnologia ORDER BY TEC_NOME"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboTipoAtividade(nome,objConn,todos)
	dim sSQL
	sSQL = "select ta_id as valor,ta_descricao as descricao from tipo_atividade ORDER BY ta_descricao"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboAreaTecnologica(nome,objConn,todos)
	dim sSQL
	sSQL = "select at_id as valor,at_nome as descricao from area_tecnologica ORDER BY at_nome"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboTipoTeste(nome,objConn,padrao,todos)
	dim sSQL
	sSQL = "select tit_id as valor, tit_descricao as descricao from Tipo_Teste ORDER BY tit_descricao"
	call comboBDSQL(nome, objConn, sSQL, padrao, todos)
End Sub

Sub comboOrgaoHierarquia(nome,objConn,todos)
	dim sSQL
	sSQL = "select orga_id as valor, (case when orga_hierarquia is not null then '(' + cast(orga_hierarquia as varchar) + ') ' else '' end) + orga_sigla + ' - ' + orga_descricao as descricao from orgao order by orga_hierarquia, orga_sigla"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

Sub comboOrgao(nome,objConn,todos)
	dim sSQL
	sSQL = "select orga_id as valor,orga_sigla + ' - ' + orga_descricao as descricao from orgao order by orga_sigla"
	call comboBDSQL( nome, objConn,sSQL, "", todos)
End Sub

sub comboData(nome)
	Dim i, auxi, cbano %>
	<select name="dia<%=nome%>" >
		<option value="">Dia</option>
		<%for i=1 to 31
			if i < 10 then
				auxi = "0" & i
			else
				auxi = i
			end if %>
			<option value="<%=auxi%>"><%=auxi%></option><%
		next %>
	</select>

	<select name="mes<%=nome%>" >
		<%= opt_meses( 10 ) %>
	</select>

	<select name="ano<%=nome%>" >
		<option value="">Ano</option>
			<%for i=-1 to 10
				cbano = year( now ) - i %>
				<option value=<%=cbano%>><%=cbano%></option><%
			next%>
	</select>
<%
end sub

sub comboHorario(nome)%>
	<select name="hora<%=nome%>" >
		<option value="">Hora</option><%
			for i = 0 to 23
				if i<10 then
					auxi = "0" & i
				else
					auxi = i
				end if %>
				<option value=<%=auxi%>><%=auxi%></option><%
			next%>
	</select>&nbsp;:&nbsp;

	<select name="minuto<%=nome%>" >
		<option value="">Minuto</option><%
			for i = 0 to 59
				cbhora = i
				if i<10 then 
					auxi = "0" & i
				else
					auxi = i
				end if %>
				<option value=<%=auxi%>><%=auxi%></option><%
			next%>
	</select>
<%
end sub

function comboCriticidade(nome)%>
	<select name="<%=nome%>" >
		<option value="" selected>--</option>
		<option value="1">1 - Baixa</option>
		<option value="2">2 - M&eacute;dia</option>
		<option value="3">3 - Alta</option>
	</select>
<%
end function

function comboEstadoOCorrencia(nome)%>
	<select name="<%=nome%>" >
		<option value="" selected>--</option>
		<option value="NO">Nova Ocorrência</option>
		<option value="EA">Em Análise</option>
		<option value="C">Concluido</option>
	</select>
<%
end function

function itoa( num, tam )
	if isnull(num) then
		itoa = ""
	else
		itoa = cstr( num )
		if( len( itoa ) < tam ) then itoa = String( tam - len( itoa ), "0" ) & itoa
	end if
end function

function opt_meses( ntabs )
	dim i
	dim meses : meses = Array( "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" )

	opt_meses = "<option value="""">M&ecirc;s</option>" & vbCrLf
	for i = 1 to 12
		opt_meses = opt_meses & String( ntabs, vbTab ) & "<option value=""" & itoa( i, 2 ) & """>" & server.HTMLencode( meses( i - 1 ) ) & "</option>" & vbCrLf
	next
end function

Sub comboAgendamentoJS(nomeText, nomeCombo)
%>
	<script type="text/javascript">
	function comboAgendamentoBuscaAS<%=nomeText%>() {
		var frm = document.forms[0];
		var combo = frm.<%=nomeCombo%>;
		indice = -1;
		for(i=0; i<combo.length; i++)
			if (combo[i].value == frm.<%=nomeText%>.value)
			indice = i;

		if (indice != -1)
	  		combo.options[indice].selected = true
		else
			combo.options[0].selected = true
	}
	</script>
	<input  type="text" name="<%=nomeText%>" size="4" onKeyUp="comboAgendamentoBuscaAS<%=nomeText%>();">&nbsp;
<%
End Sub

'-- monta combo de Agendamento
Sub comboAgendamento(nomeText, nomeCombo, objConn, padrao, todos)
	call comboAgendamentoJS(nomeText, nomeCombo)
	call comboBDSQL( nomeCombo, objConn, "select AG_NUMERO as VALOR, " & _
		"Cast(AG_NUMERO as VARCHAR(10)) + CASE WHEN AG_TITULO IS NULL THEN '' ELSE ' - ' + SUBSTRING(AG_TITULO, 1, 50) END as DESCRICAO " & _
		"from Agendamento order by AG_NUMERO desc", padrao, todos)
End Sub

Sub comboSimNao(nome, objConn, todos)
	dim sSQL
	sSQL = "select 'S' as valor, 'Sim' as descricao UNION SELECT 'N', 'Não' ORDER BY valor desc"
	call comboBDSQL( nome, objConn, sSQL, "", todos)
End Sub
%>
