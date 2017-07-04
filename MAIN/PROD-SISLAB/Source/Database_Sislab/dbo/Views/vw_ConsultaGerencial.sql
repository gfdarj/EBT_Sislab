

CREATE     VIEW [dbo].[vw_ConsultaGerencial]
AS
	SELECT
		a.AG_NUMERO AS Num_AG_M, 
		(
			SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = a.AG_NUMERO
		) AS 'Nº_OS_Geradas_M',
		a.AG_DATASOLICITACAO as 'Data_da_Solicitação_pelo_Cliente_M',
		a.AG_DATAINICIO as 'Data_de_Início_Solicitada_pelo_Cliente_M', 
		a.AG_DATATERMINO as 'Data_de_Término_Solicitada_pelo_Cliente_M',
		a.TEC_NOME as 'Tecnologia_M',
		a.TA_ID,
		a.TA_DESCRICAO AS 'Tipo_Teste_M',
		a.AG_SIGILO,
		a.TS_DESCRICAO as 'Tipo_de_Sigilo_M',
		a.AG_RAT as 'RAT_M',
		a.AG_NECESSITA_OS,
		a.ID_SITUACAO,
		a.S_DESCRICAO AS Situação_M,
		a.AG_RESPONSAVEL AS 'Responsável_Técnico_M',
		(
			SELECT MIN(heosR.HE_DATAINICIO) FROM Historico_Eventos heosR 
			WHERE 	heosR.ID_SITUACAO = 6 /* Em Execucao */
				AND heosR.AG_NUMERO = a.AG_NUMERO
				AND heosR.HE_DATAINICIO IS NOT NULL
		) AS 'Data_de_Início_Real_M',
		(
			SELECT MAX(heosR.HE_DATATERMINO) FROM Historico_Eventos heosR 
			WHERE	heosR.AG_NUMERO = a.AG_NUMERO /* tem que haver pelo menos uma entrada em execucao */
				AND heosR.ID_SITUACAO = 6 /* Em Execucao */
				AND heosR.HE_DATATERMINO IS NOT NULL
		) AS 'Data_Término_Real_M',
		a.AG_USERNAME as 'Solicitante_M',
		a.AG_CLIENTEEXTERNO as 'Cliente_Externo_M',
		a.AG_ORGAO as 'Órgão_M',
		CASE a.AG_NECESSITA_OS
			WHEN 1 THEN 
				CASE 
				WHEN	/* N. Testes certificados = N. Testes) */
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 3 /*CERTIFICADO*/) > 0
					AND
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 3 /*CERTIFICADO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = a.AG_NUMERO)
				THEN 'TESTE ACREDITADO'
				WHEN	/* N. Testes certificados = N. Testes) */
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) > 0
					AND
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = a.AG_NUMERO)
				THEN 'TESTE PADRONIZADO'
				ELSE
					CASE
					WHEN	(
						select count(arq_codarqtipo)
						from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq 
						WHERE (arq_codarqtipo = 7 OR arq_codarqtipo = 18) 
						and d.AG_NUMERO = a.AG_NUMERO) >= 1
					THEN 'LAUDO ELABORADO' 
					ELSE 'LAUDO NÃO ELABORADO' 
					END
				END
			ELSE 'N/A'
		END AS 'Laudo_M',
		CASE a.AG_NECESSITA_OS
			WHEN 1 THEN 
				CASE 
				WHEN	/* N. Testes certificados = N. Testes) */
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 3 /*CERTIFICADO*/) > 0
					AND
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 3 /*CERTIFICADO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = a.AG_NUMERO)
				THEN 'TESTE ACREDITADO'
				WHEN	/* N. Testes certificados = N. Testes) */
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) > 0
					AND
					(SELECT COUNT(*) FROM Ordem_de_Servico os INNER JOIN Testes t1 ON t1.T_ID = os.T_ID WHERE os.AG_NUMERO = a.AG_NUMERO AND t1.TIT_ID = 2 /*EM CERTIFICACAO*/) = (SELECT COUNT(*) FROM Ordem_de_Servico os WHERE os.AG_NUMERO = a.AG_NUMERO)
				THEN 'TESTE PADRONIZADO'
				ELSE
					CASE 
					WHEN	(
						select count(arq_codarqtipo) 
						from DIAGRAMAS d inner join arquivos arq1 on arq1.arq_codarq = d.arq_codarq 
						WHERE (arq1.arq_codarqtipo = 20 OR arq1.arq_codarqtipo = 18) 
						and d.AG_NUMERO = a.AG_NUMERO) >= 1 
					THEN 'ROTEIRO ELABORADO' 
					ELSE 'ROTEIRO NÃO ELABORADO'
					END
				END
			ELSE 'N/A'
		END AS 'Roteiro_M',
		CASE 
		WHEN a.ID_SITUACAO = (SELECT id_situacao  FROM Situacoes WHERE S_OS = 0 AND s_descricao = 'Finalizado') THEN
			CASE
			WHEN (SELECT COUNT(*) FROM PesquisaSatisfacao WHERE PSQ_NAG = a.AG_NUMERO) > 0 THEN
				'Sim'
			ELSE
				'Não'
			END
		ELSE 
			'Não'
		END AS 'Pesquisa_de_Satisfação_M'
	FROM vw_Agendamento a

