select * from Agendamento

select * from prioridade

select * from TECNOLOGIA

select * from Area_Tecnologica


-- DROP TABLE dbo.Prioridade_Tecnologia

CREATE TABLE dbo.Prioridade_Tecnologia
(
	ID_PRIORIDADE INT NOT NULL,
	CD_PRIORIDADE VARCHAR(05),
	NM_PRIORIDADE VARCHAR(50)
)
GO
ALTER TABLE dbo.Prioridade_Tecnologia ADD CONSTRAINT PK_Prioridade_Tecnologia PRIMARY KEY (ID_PRIORIDADE)
GO

INSERT INTO Prioridade_Tecnologia VALUES (1, '01', 'DTA01')
INSERT INTO Prioridade_Tecnologia VALUES (2, '02', 'DTA02')
INSERT INTO Prioridade_Tecnologia VALUES (3, '03', 'DTA03')
INSERT INTO Prioridade_Tecnologia VALUES (4, '04', 'DTA04')
INSERT INTO Prioridade_Tecnologia VALUES (5, '05', 'DTA05')
INSERT INTO Prioridade_Tecnologia VALUES (6, '99', 'DTA')

INSERT INTO Prioridade_Tecnologia VALUES (7, '01', 'TFM01')
INSERT INTO Prioridade_Tecnologia VALUES (8, '02', 'TFM02')
INSERT INTO Prioridade_Tecnologia VALUES (9, '03', 'TFM03')
INSERT INTO Prioridade_Tecnologia VALUES (10, '04', 'TFM04')
INSERT INTO Prioridade_Tecnologia VALUES (11, '05', 'TFM05')
INSERT INTO Prioridade_Tecnologia VALUES (12, '99', 'TFM')

INSERT INTO Prioridade_Tecnologia VALUES (13, '01', 'TNL01')
INSERT INTO Prioridade_Tecnologia VALUES (14, '02', 'TNL02')
INSERT INTO Prioridade_Tecnologia VALUES (15, '03', 'TNL03')
INSERT INTO Prioridade_Tecnologia VALUES (16, '04', 'TNL04')
INSERT INTO Prioridade_Tecnologia VALUES (17, '05', 'TNL05')
INSERT INTO Prioridade_Tecnologia VALUES (18, '99', 'TNL')

INSERT INTO Prioridade_Tecnologia VALUES (19, '01', 'TNO01')
INSERT INTO Prioridade_Tecnologia VALUES (20, '02', 'TNO02')
INSERT INTO Prioridade_Tecnologia VALUES (21, '03', 'TNO03')
INSERT INTO Prioridade_Tecnologia VALUES (22, '04', 'TNO04')
INSERT INTO Prioridade_Tecnologia VALUES (23, '05', 'TNO05')
INSERT INTO Prioridade_Tecnologia VALUES (24, '99', 'TNO')


select * from Prioridade_Tecnologia

/*
1 - DTA01
2 - DTA02
3 - DTA03
4 - DTA04
5 - DTA05
6 - DTA
7 - TFM01
8 - TFM02
9 - TFM03
10 - TFM04
11 - TFM05
12 - TFM
13 - TNL01
14 - TNL02
15 - TNL03
16 - TNL04
17 - TNL05
18 - TNL
19 - TNO01
20 - TNO02
21 - TNO03
22 - TNO04
23 - TNO05
24 - TNO
*/

