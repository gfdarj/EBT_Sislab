<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim RS
Dim chr_Buf
Dim bln_EhRat
Dim bln_Imprime
Dim bln_Alteracao

bln_EhRat = Env.EhRat
bln_Imprime = (UCase(RQ("imprime")) = "S")
bln_Alteracao = (UCase(RQ("altera")) = "S")

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Cadastro do Horário do Transporte"

If bln_Imprime Then
    Tela.SetLinkVoltar = "window.close()"
	'Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, True, "", "", "window.close()", "")
Else
    Tela.SetLinkVoltar = "location.href='sislab.asp'"
	'Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, True, "", "", "location.href='sislab.asp'", "")
End If

Call Tela.MostraCabecalho()
%>
<script type="text/javascript">
    function imprime()
    {
	    var w = window.open('CadTransporte.asp?imprime=S', 'ImprimeTransporte', 'scrollbars=yes, toolbars=no, directory=no');
	    w.focus();
	    window.print();
    }

<%
If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then
%>
    function Mascara_Hora(eu)
    {
	    var hora01 = '';
	    hora01 = hora01 + eu.value;
	    if (hora01.length == 2)
	    {
		    hora01 = hora01 + ':';
		    eu.value = hora01;
	    }
	    if (hora01.length == 5)
	    {
		    return Verifica_Hora(eu);
	    }
	    else
		    return false;
    }
    function Verifica_Hora(eu){
	    var hrs = (eu.value.substring(0,2));
	    var min = (eu.value.substring(3,5));

	    estado = "";
	    if ((hrs < 00 ) || (hrs > 23) || ( min < 00) ||( min > 59))
	    {
		    estado = "errada";
	    }
	    if (eu.value == "") {
		    estado = "errada";
	    }
	    if (estado == "errada") {
		    eu.focus();
		    return false;
	    }
	    return true;	
    }
	function altera(hora)
	{
		var f = document.all.frm;
		var h1 = eval('document.all.ida' + hora);
		var h2 = eval('document.all.volta' + hora);

		if( (eval('document.all.ida' + hora + '.value') == '') && (eval('document.all.volta' + hora + '.value') == '') )
			alert('Preencha os campos corretamente !');
		else if ( !Mascara_Hora(h1) )
			alert('Hora "Sede > Ilha do Fundão" inválida.');
		else if ( !Mascara_Hora(h2) )
			alert('Hora "Ilha do Fundão > Sede" inválida.');
		else
		{
			f.action = 'CadTransporteA.asp?Horario=' + hora + '&ida=' + eval('document.all.ida' + hora + '.value') + '&volta=' + eval('document.all.volta' + hora + '.value') + '&altera=<%=RQ("altera")%>';
			f.submit();
		}
	}
	function apaga(hora)
	{
		var f = document.all.frm;
		f.action = 'CadTransporteA.asp?excluir=S&Horario=' + hora + '&altera=<%=RQ("altera")%>';
		f.submit();
	}
	function novo()
	{
		var f = document.all.frm;

		if( (f.ida.value == '') && (f.volta.value == '') )
			alert('Preencha os campos corretamente !');
		else if ( !Mascara_Hora(f.ida) )
			alert('Hora "Sede > Ilha do Fundão" inválida.');
		else if ( !Mascara_Hora(f.volta) )
			alert('Hora "Ilha do Fundão > Sede" inválida.');
		else
		{
			f.action = 'CadTransporteA.asp?Horario=0&ida=' + f.ida.value + '&volta=' + f.volta.value + '&altera=<%=RQ("altera")%>';
			f.submit();
		}
	}
<%
End If
%>
</script>

<div class="margem-10">
    <h2 style="text-align: center;">TRANSPORTES DO CRT</h2>

    <form name="frm" action="" method="post" target="escondido">
        <input type="hidden" name="acao" value="">
        <input type="hidden" name="horario" value="">

        <div class="container">

            <div class="row">

                <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5">

        <table class="table-bordered table-condensed" id="tb_horarios" >
        <tr>
	        <th>Sede > Ilha do Fundão (CRT)</th>
	        <th>Ilha do Fundão (CRT) > Sede</th>
<%If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then%>
        	<th>Ação</th>
<%End If%>
        </tr>
<%
Set RS = Env.oConn.Execute("SELECT * FROM Transporte ORDER BY DeHoraIda;")

While Not RS.Eof
	chr_Buf =	"<tr>" & _
				"	<td align='center'>"

	If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then
		chr_Buf =  chr_Buf & _
				"		<input name='ida" & RS(0) & "' type='text' size='6' maxlength='5' value='" & Left(rs(1), 5) & "'>"
	Else
		chr_Buf =  chr_Buf & "<h4>" & Left(rs(1), 5) & "</h4>"
	End If

	chr_Buf =  chr_Buf & _
				"	</td>" & _
				"	<td align='center'>"

	If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then
		chr_Buf =  chr_Buf & _
				"		<input name='volta" & RS(0) & "' type='text' size='6' maxlength='5'  value='" & Left(rs(2), 5) & "'>"
	Else
		chr_Buf =  chr_Buf & "<h4>" & Left(rs(2), 5) & "</h4>"
	End If

	chr_Buf =  chr_Buf & _
				"	</td>"

	If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then
		chr_Buf =  chr_Buf & _
				"	<td align='center'>" & _
				"		<input name='btn_altera" & RS(0) & "' type='button' value='Alterar' onclick='javascript:altera(" & RS(0) & ");'>" & _
				"		&nbsp;" & _
				"		<input name='btn_apaga" & RS(0) & "' type='button' value='Excluir' onclick='javascript:apaga(" & RS(0) & ");'>" & _
				"	</td>"
	End If

	chr_Buf =  chr_Buf & _
				"</tr>"

	RW chr_Buf
	RS.MoveNext
WEnd
%>
    </table>

                </div> <!-- 1a coluna -->

                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
                    <table class="table-condensed table-bordered">
                        <tr>
                            <th style="text-align: center;">Morumbi > Verbo</th>
                            <th style="text-align: center;">Henri Dunant > Verbo</th>
                            <th style="text-align: center;">Verbo > Morumbi</th>
                            <th style="text-align: center;">Henri Dunant > Morumbi</th>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>09:15</h4></td>
                            <td style="text-align: center;"><h4>09:35</h4></td>
                            <td style="text-align: center;"><h4>09:15</h4></td>
                            <td style="text-align: center;"><h4>09:30</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>09:55</h4></td>
                            <td style="text-align: center;"><h4>10:15</h4></td>
                            <td style="text-align: center;"><h4>09:55</h4></td>
                            <td style="text-align: center;"><h4>10:10</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>10:35</h4></td>
                            <td style="text-align: center;"><h4>10:55</h4></td>
                            <td style="text-align: center;"><h4>10:35</h4></td>
                            <td style="text-align: center;"><h4>10:50</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>11:15</h4></td>
                            <td style="text-align: center;"><h4>11:35</h4></td>
                            <td style="text-align: center;"><h4>11:15</h4></td>
                            <td style="text-align: center;"><h4>11:30</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>11:55</h4></td>
                            <td style="text-align: center;"><h4>12:15</h4></td>
                            <td style="text-align: center;"><h4>11:55</h4></td>
                            <td style="text-align: center;"><h4>12:10</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>12:35</h4></td>
                            <td style="text-align: center;"><h4>12:55</h4></td>
                            <td style="text-align: center;"><h4>12:35</h4></td>
                            <td style="text-align: center;"><h4>12:50</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>14:00</h4></td>
                            <td style="text-align: center;"><h4>14:20</h4></td>
                            <td style="text-align: center;"><h4>14:00</h4></td>
                            <td style="text-align: center;"><h4>14:15</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>14:40</h4></td>
                            <td style="text-align: center;"><h4>15:00</h4></td>
                            <td style="text-align: center;"><h4>14:40</h4></td>
                            <td style="text-align: center;"><h4>14:55</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>15:20</h4></td>
                            <td style="text-align: center;"><h4>15:40</h4></td>
                            <td style="text-align: center;"><h4>15:20</h4></td>
                            <td style="text-align: center;"><h4>15:35</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>16:00</h4></td>
                            <td style="text-align: center;"><h4>16:20</h4></td>
                            <td style="text-align: center;"><h4>16:00</h4></td>
                            <td style="text-align: center;"><h4>16:15</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>16:40</h4></td>
                            <td style="text-align: center;"><h4>17:00</h4></td>
                            <td style="text-align: center;"><h4>16:40</h4></td>
                            <td style="text-align: center;"><h4>16:55</h4></td>
                        </tr>
                        <tr>
                            <td style="text-align: center;"><h4>17:20</h4></td>
                            <td style="text-align: center;"><h4>17:40</h4></td>
                            <td style="text-align: center;"><h4>17:20</h4></td>
                            <td style="text-align: center;"><h4>17:35</h4></td>
                        </tr>
                    </table>

                </div> <!-- 3a coluna -->

            </div>
        </div>


<%
If bln_EhRat And bln_Alteracao And (Not bln_Imprime) Then
%>
        <br />

        <table class="table-bordered table-condensed" id="tb_novo" style="margin-left: auto; margin-right: auto;">
        <tr>
	        <th>Sede > Ilha do Fundão (CRT)</th>
	        <th>Ilha do Fundão (CRT) > Sede</th>
	        <th width="120px">Ação</th>
        </tr>
        <tr>
	        <td align='center'>
		        <input name='ida' type='text' size='6' maxlength='5' value=''>
	        </td>
	        <td align='center'>
		        <input name='volta' type='text' size='6' maxlength='5'  value=''>
	        </td>
	        <td align='center'>
		        <input name='btn_novo' type='button' value='Adicionar' onClick="javascript:novo();">
	        </td>
        </tr>
        </table>
<%
End If
%>
    </form>
<%
If Not bln_Imprime Then
%>
    <br />
    <p style="text-align: center;">
    	<input name='btn_imprimir' type='button' class='texto1' value='Imprimir' onClick="javascript:imprime();" style="width:80px;">
<%	If bln_Alteracao Then %>
	    <input name='btn_Voltar' type='button' class='texto1' value=' Voltar ' onClick="location.href='sislab.asp';" style="width:80px;">
<%	End If %>
    </p>
<%
End If
%>
    <BR/>
    <iframe src="" width="600px" style="display: none;" name="escondido">
</div>
<%
Call Tela.MostraRodape()
%>
