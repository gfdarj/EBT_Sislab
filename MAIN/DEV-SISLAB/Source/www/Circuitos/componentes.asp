<!--#include file="includes/montatela.inc"-->
<!--#include file="includes/funcoesAux.inc"-->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<html>
<head>
	<title>Site do Centro de Referência Tecnológica</title>
	<meta http-equiv="Pragma" content="no-cache">
	<link rel="stylesheet" href="includes/style.css">
</head>
<script language="JavaScript" src="includes/qtd_caract.js"></script>
<script language="javascript">

function retiraInt()
{
	var lista = document.componente.lstint
	retira(document.componente.lstint)
}

function adicionaInt()
{
	var combo = document.componente.int
	var qtd = document.componente.qtd_int
	var lista = document.componente.lstint // cmb valores
	var chave = combo[combo.selectedIndex].value
//	var chave = combo[combo.selectedIndex].value+","+qtd.value 
	var item = combo[combo.selectedIndex].text+" ("+qtd.value+")"
	if (combo.value == "")
	{
		alert("O campo 'Interface' deve ser preenchido.");
		combo.focus();		
	}
	else if (qtd.value == "")
	{
		alert("O campo 'Quantidade' deve ser preenchido.");
		combo.focus();		
	}
	else if (verificaLista1(chave, lista))
	{
		alert("Esta Interface já se encontra na lista.");
		combo.focus();		
	}
	else
	{
		adiciona(chave, item, lista)
		combo.value = ""
		qtd.value = ""
	}
}

function adiciona(chave, item, lista)
// funcao que acrescenta um item em uma lista
{
	lista.options[lista.options.length] = new Option(item, chave);
}

function retira(lista)
// funcao que retira um item que esteja selecionado em uma lista
{
	if (lista.selectedIndex != -1)
		lista.options[lista.selectedIndex]=null;
}

function selecionaItens(lista)
//Seleciona todos os itens de uma lista
{
	var i
	for(i=0; i<lista.length; i++)  
  		lista.options[i].selected = true
}

function verificaLista(valor, lista)
//Verifica se um valor já se encontra na lista
{
	var i;
	for(i=0; i<lista.length; i++)
		if (lista[i].value.indexOf(valor) != -1)
			return(true);
	return(false);
}

function verificaLista1(valor, lista)
//Verifica se um valor já se encontra na lista
{
	var i;
	for(i=0; i<lista.length; i++)
		if (lista[i].value==valor)
			return(true);
	return(false);
}


</script>

<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0><% 

'Chamo a Barra da controladoria comum a todas as paginas

Call MostraHeader 

'adicionar aqui verificacoes de seguranca / acesso
dim objRS, strSQL, objConn
dim lges(), lges_id(), nlges
dim cpt_id, cpt_nome, tpc_id, tpc_nome, lee_id, lee_nome, lge_nome, lge_id, cpt_cod
dim vsw_atu, vsw_std, obs

if( isnumeric( cstr( request.querystring( "cpt_id" ) ) ) ) then
	cpt_id = request( "cpt_id" )
	strSQL = "select fac_componentes.cpt_nome, fac_componentes.tpc_id, fac_componentes.lee_id, vsw_std, vsw_atu, obs ,fac_tipo_componente.tpc_nome, fac_locais_especificos_equip.lee_nome, fac_locais_genericos_equip.lge_nome, fac_locais_genericos_equip.lge_id, fac_componentes.cpt_cod_sgp_sce " _
			& "from fac_componentes inner join fac_tipo_componente on fac_componentes.tpc_id = fac_tipo_componente.tpc_id " _
				& "inner join ( fac_locais_especificos_equip inner join fac_locais_genericos_equip on fac_locais_especificos_equip.lge_id = fac_locais_genericos_equip.lge_id ) on fac_componentes.lee_id = fac_locais_especificos_equip.lee_id " _
			& "where fac_componentes.cpt_id = " & cpt_id
'	response.write( strSQL )
'	response.end
	call Env.RecordSet( true, objRS, strSQL)
	if( objRS.BOF and objRS.EOF ) then
		call ErroBD( "Identificador de componente inválido" )
	end if
	vsw_atu = objRS( "vsw_atu" )
	vsw_std = objRS( "vsw_std" )
	obs = objRS( "obs" )
	cpt_nome = objRS( "cpt_nome" )
	tpc_id = objRS( "tpc_id" )
	tpc_nome = objRS( "tpc_nome" )
	lee_id = objRS( "lee_id" )
	lee_nome = objRS( "lee_nome" )
	lge_nome = objRS( "lge_nome" )
	lge_id = objRS( "lge_id" )
	cpt_cod = objRS( "cpt_cod_sgp_sce" )
	call Env.RecordSet( false, objRS, null)
else
	cpt_nome = ""
	tpc_id = ""
	tpc_nome = ""
	lee_id = ""
	lee_nome = ""
	lge_nome = ""
	cpt_cod = ""
end if

%>
<script language="JavaScript">
var lge_ativo = "-1";
function muda_lee( sel )
{
	if( lge_ativo != "-1" )
	{
		document.all[ "d_le" + lge_ativo ].style.display = "none";
		document.all[ "le" + lge_ativo ].disabled = true;
	}
	lge_ativo = new String( sel.options[ sel.selectedIndex ].value );
	if( lge_ativo != "-1" )
	{
		document.all[ "d_le" + lge_ativo ].style.display = "block";
		document.all[ "le" + lge_ativo ].disabled = false;
	}
	ver_submit();
}

function verifica()
{
	var d = document.componente;
	var l = document.all;
	var msg = "";

	l.l_nome.className = "";

	if( document.componente.cpt_nome.value.length <= 0 )
	{
		d = d.cpt_nome;
		l = l.l_nome;
		msg = "O componente precisa possuir um nome";
	}
	else if( document.componente.lge_id.value == "-1" || document.componente.lee_id.disabled )
	{
		d = d.lge_id;
		l = l.l_local;
		msg = "O local do componente não é válido";
	}

	if( msg != "" )
	{
		alert( msg + ". Por favor, resolva este erro e tente novamente." );
		d.focus();
		l.className = "erro";
	}
	else


{



/*  Lista de Interfaces,qtd por equipamento */

	var int = "", qtd = "", i;

	for( i=0; i<document.componente.lstint.length; i++)
	{
		int += document.componente.lstint[i].value + ",";
		qtd += ExtraiQtdeSemPar(document.componente.lstint[i].text) + ",";
	}

	document.componente.lista_int.value = int.substring(0, int.length-1);
	document.componente.lista_qtd.value = qtd.substring(0, qtd.length-1);


}


	{ document.componente.submit(); }
}

function ver_submit()
{
	var d = document.componente;
	d.btn_OK.disabled = ( d.cpt_nome.value == "" || d.tpc_id.value == "" || d.lge_id.value == "-1" );
}
</script>
<form name="componente" action="proc_compo.asp" method="post">

<input type="Hidden" name="lista_int" value="">
<input type="Hidden" name="lista_qtd" value="">

<input type="Hidden" name="cpt_id" value="<%= request.querystring( "cpt_id" ) %>" />
<table class="tipo1" align="center">
<tr><td></td><td></td></tr>
<tr>
	<td colspan="2" bgcolor="#000030" align="right"><font face="tahoma" style="font-size=10pt" color="#FFFFFF">&nbsp;<B><a href="index.asp" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br></font></td>
</tr>
<tr>
	<th colspan="2" class="titulo">Cadastro de Componente</th>
</tr>
<tr id="l_nome">
	<th>Nome</th>
	<td><input type="Text" name="cpt_nome" onchange="javascript:ver_submit();" size="60" maxlength="200" value="<%= cpt_nome %>" /></td>
</tr>
<tr id="l_tipo">
	<th>Tipo de Componente</th>
	<td>
		<select name="tpc_id">
			<option value="">Escolha um tipo...</option><%
strSQL = "select tpc_id, tpc_nome from fac_tipo_componente order by tpc_nome"
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao existe nenhum tipo cadastrado" )
end if
while( not( objRS.EOF ) ) %>
			<option value="<%= objRS( "tpc_id" ) %>"><%= objRS( "tpc_nome" ) %></option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQL)%>
		</select>
	</td>
</tr>
<tr id="l_local">
	<th>Local</th>
	<td>
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td>
		<select name="lge_id" onchange="javascript:muda_lee( this );">
			<option value="-1">Escolha um local...</option><%
strSQL = "select fac_locais_genericos_equip.lge_id, lge_nome from fac_locais_especificos_equip inner join fac_locais_genericos_equip on fac_locais_especificos_equip.lge_id = fac_locais_genericos_equip.lge_id group by lge_nome, fac_locais_genericos_equip.lge_id, lge_tipo order by lge_tipo desc, lge_nome"
call Env.RecordSet( true, objRS, strSQL)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao existe nenhum local generico/especifico cadastrado" )
end if
nlges = -1
while( not( objRS.EOF ) ) %>
			<option value="<%= objRS( "lge_id" ) %>"><%= objRS( "lge_nome" ) %></option><%
	nlges = nlges + 1
	redim preserve lges( nlges ), lges_id( nlges )
	lges( nlges ) = objRS( "lge_nome" )
	lges_id( nlges ) = objRS( "lge_id" )
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQL)
%>
		</select>
		</td>
		<td><%
dim i
i = 0
do until i > nlges
	strSQL = "select lee_id, lee_nome from fac_locais_especificos_equip where lge_id = " & lges_id( i ) & " order by lee_nome"
	call Env.RecordSet( true, objRS, strSQL)
	if( not( objRS.BOF and objRS.EOF ) ) then %>
		<div id="d_le<%= lges_id( i ) %>" style="display: none;">
		<select name="lee_id" id="le<%= lges_id( i ) %>" disabled><%
		while( not( objRS.EOF ) ) %>
			<option value="<%= objRS( "lee_id" ) %>"><%= objRS( "lee_nome" ) %></option><%
			objRS.MoveNext
		wend
	end if
	call Env.RecordSet( false, objRS, strSQL)
%>
		</select>
		</div><%
	i = i + 1
loop %>
		</td>
		</tr>
		</table>
	</td>
</tr>

<tr valign=top>
	<th>Interfaces:</th>
<td>

<table>
<tr>
	<td>
	<font class="Fonttit3Cad"><b>
Tipo:<br>

<select name="int">
<option value=""></option>
<%
strSQL = "select tipo_interface, tipo_interface_id from fac_tipo_interface order by  tipo_interface_id"
call Env.RecordSet( true, objRS, strSQl)
if( objRS.BOF and objRS.EOF ) then
	call ErroBD( "Nao foi possivel buscar a lista de componentes" )
end if
while( not( objRS.EOF ) ) %>
				<option value="<%= objRS( "tipo_interface_id" ) %>"><%= objRS( "tipo_interface" ) %></option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQl)
%>
			</select>
<br>
Qtd:<br>
<input type="Text" name="qtd_int" size="4" maxlength="4" value="" />
</font>
</td>
<td>
</td>

		<td>
	<div align=center>
			<input type="button" value=">" onclick="adicionaInt()"><br>
			<input type="button" value="<" onclick="retiraInt()">
	</div>
		</td>
		<td> 
		 	<div align=left>
	<font class="Fonttit3Cad"><b>&nbsp;&nbsp;&nbsp;Interfaces - Qtd (Existentes)
			<br>&nbsp;&nbsp;
		  <select name="lstint" class="combo" style="width:250px" size=3 Multiple>
<%

if( isnumeric( cstr( request.querystring( "cpt_id" ) ) ) ) then

strSQL = "select qtd_int, tipo_interface, fac_componentes_interface.tipo_interface_id from fac_componentes_interface, fac_tipo_interface  where fac_tipo_interface.tipo_interface_id = fac_componentes_interface.tipo_interface_id and cpt_ID="&cpt_id& "; "
call Env.RecordSet( true, objRS, strSQL)
if Not( objRS.BOF and objRS.EOF ) then

while( not( objRS.EOF ) ) %>
			<option value="<%= objRS( "tipo_interface_id" ) %>"><%= objRS( "tipo_interface" ) %> (<%= objRS( "qtd_int" ) %>)</option><%
	objRS.MoveNext
wend
call Env.RecordSet( false, objRS, strSQL)

end if
end if
%>
		</select>
		  </select>
		  </b></font>
			</div>
		</td>

</tr>
</table>


</td>
</tr>

<tr>
	<th>Vers&atilde;o de SW:</th>
	<td><font class="Fonttit3Cad"><b>atual: <input type="Text" name="vsw_atu" size="20" maxlength="255" value="<%= vsw_atu %>" />&nbsp;&nbsp;&nbsp;
padrão: <input type="Text" name="vsw_std" size="20" maxlength="255" value="<%= vsw_std %>" /></b></font></td>
</tr>

<tr valign="top">
	<th>Observa&ccedil;&atilde;o</th>
	<td><textarea name="obs" rows="4" cols="50" maxlength="255"><%= obs %></textarea></td>
</tr>

<tr>
	<th>C&oacute;digo SGP/SCE</th>
	<td><input type="Text" name="cpt_cod_sgp_sce" size="60" maxlength="50" value="<%= cpt_cod %>" /></td>
</tr>

<tr>
	<td colspan="2" align="center"><button name="btn_OK" onclick="javascript:verifica();" disabled>&nbsp;&nbsp;OK&nbsp;&nbsp;</button></td>
</tr>
</table><%
if( tpc_id <> "" ) then %>
<script language="JavaScript">
document.componente.tpc_id.value = <%= tpc_id %>;
document.componente.lge_id.value = <%= lge_id %>;
muda_lee( document.componente.lge_id );
for( var i = 0; document.componente.lee_id[ i ].disabled == true; i++ );
document.componente.lee_id[ i ].value = <%= lee_id %>;
ver_submit();
</script><%
end if %>
</form>
<%
call MostraFooter
%>
