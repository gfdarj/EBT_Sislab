# Sislab - Sistema de Laboratório
- Centro de Referência Tecnológica (Claro/Embratel)

- Sistema do laboratório do Centro de Referência Tecnológica (CRT).


        Front-end: Baseado em ASP Clássico
        Base de dados: SQL Server versão 2008.

<br>
<br>

# Instalar o SQL SERVER no Docker

* Criar o volume

        docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=SuaSenhaForte@123" -p 1433:1433 --name sql_server -d mcr.microsoft.com/mssql/server:2022-latest


* Restaurar um DB para o SQL SERVER no Docker

        (no CMD)

        docker cp "C:\Caminho\Para\SeuBanco.bak" meuparceiro_sql:/var/opt/mssql/data/

        (no SQL)

        RESTORE FILELISTONLY 
        FROM DISK = '/var/opt/mssql/data/SeuBanco.bak';


        RESTORE DATABASE sislab 
        FROM DISK = '/var/opt/mssql/data/sislab.bak'
        WITH 
                MOVE 'SISLAB_MIGRA_Data' TO '/var/opt/mssql/data/sislab.mdf',
                MOVE 'SISLAB_MIGRA_Log' TO '/var/opt/mssql/data/sislab_log.ldf';

        (no CMD)

        docker exec -it sql_server rm /var/opt/mssql/data/sislab.bak


<br><hr>
Migrado do TFS em 18/09/2022
