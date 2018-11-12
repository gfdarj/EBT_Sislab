<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim chr_SQL, objConn, objRS, i, max
Dim tot_geral : tot_geral = 0
max = 0

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Verifica Numeração dos Agendamentos", "location.href='sislab.asp'", "")

chr_SQL = "" & VbCrLf & _
          "IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[##agendamento]') AND OBJECTPROPERTY(id,N'IsTable') = 1) " & VbCrLf & _
          "	  DROP TABLE ##agendamento " & VbCrLf & _
          "GO" & VbCrLf & _  
          "IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[#agendamento1]') AND OBJECTPROPERTY(id,N'IsTable') = 1) " & VbCrLf & _
          "   DROP TABLE #agendamento1" & VbCrLf & _
          "GO" & VbCrLf & _  
          "SET NOCOUNT ON " & VbCrLf & _
          "CREATE TABLE #agendamento1 ( AG_NUMERO INT PRIMARY KEY )" & VbCrLf & _
          "DECLARE @max INT, @conta INT" & VbCrLf & _
	      "SET @conta = 1" & VbCrLf & _
	      "SELECT @max = MAX(AG_NUMERO) FROM Agendamento" & VbCrLf & _
	      "WHILE @conta <= @max" & VbCrLf & _
	      "BEGIN" & VbCrLf & _
	      "    INSERT INTO #agendamento1 VALUES (@conta)" & VbCrLf & _
	      "    SET @conta = @conta + 1" & VbCrLf & _
	      "END" & VbCrLf & _
	      "SELECT a1.AG_NUMERO, a2.AG_OBJETIVO FROM #agendamento1 a1 LEFT JOIN Agendamento a2 ON a1.AG_NUMERO = a2.AG_NUMERO" & VbCrLf & _
	      "DROP TABLE #agendamento1" & VbCrLf & _
          "GO" & VbCrLf & _  
          "" & VbCrLf

Server.ScriptTimeout = 1000
Response.Buffer = True
Response.Flush

Call Env.RecordSet(true, objRS, chr_SQL)
%>
<div class="margem-10">
    <br>
<%
If Not (objRS.Eof and objRS.Bof) Then
%>
    <table class="table-bordered table-condensed table-striped table-hover">
    <tr>
	    <th style="width: 70px">Nº AS</th>
	    <th>Objetivo</th>
    </tr>
<%
    While Not objRS.Eof
%>
    <tr class="<%If (Not achou) Then Response.Write "bg-warning"%>">
	    <td style="text-align: center;"><%=i%></td>
	    <td style="text-align: justify;">
<%          If VVVNZ(objRS("AG_OBJETIVO")) Then
                Response.Write "** Não encontrado **"
            Else
                Response.Write objRS("AG_OBJETIVO")
                tot_geral = total_geral + 1
            End If %>&nbsp;
	    </td>
    </tr>
<%
        max = max + 1
	    objRS.MoveFirst
        If conta Mod 100 Then Response.Flush
    WEnd

    Call Env.RecordSet(false, objRS, null)
%>
    </table>
    <br />
    <p style="text-align: right;">
	    <strong>Números vagos: <%=max - tot_geral%>&nbsp;&nbsp;&nbsp;&nbsp;Total de Agendamentos: <%=tot_geral%></strong>
    </p>
<%
Else%>
    <p style="text-align: center;">Nenhum Agendamento encontrado!</p>
<%
end if%>
    <br />
</div>
<%
Call Tela.MostraRodape()
%>
