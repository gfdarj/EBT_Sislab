<%
'--------------------------------------------------------------------------------------------
'-- Arquivos de constantes globais do sistema
'--
'-- COPPETEC
'-- Gilberto F. Almeida (13/08/2003)
'--------------------------------------------------------------------------------------------

'-- Status de equipamentos e acessórios
Const STATUS_CADASTRADO = 0
Const STATUS_EM_USO = 2
Const STATUS_EM_ESTOQUE = 1
Const STATUS_EXPEDIDO = 3
Const STATUS_EXPEDIDO_SUBST = 4		'Expedido com substituição

'-- Tipos de Movimentação
Const MOV_ENTRADA = 1
Const MOV_LOGISTICA_ENTRADA = 2
Const MOV_LOGISTICA_SAIDA = 4
Const MOV_EXPEDICAO = 3
Const MOV_EXPEDICAO_SUBST = 5

'-- Categoria do item
Const CAT_EQUIPAMENTO = "E"
Const CAT_CONSUMIVEL = "C"

'-- Tipo de controle para instrumentais
Const CONTROLE_CALIBRACAO = "C"
Const CONTROLE_MANUTENCAO = "M"
Const CONTROLE_QUALIFICACAO = "Q"
Const CONTROLE_MANUTENCAO_PREVENTIVA = "P"

Const PERFIL_ADM = 1	'-- Perfil de administrador do sistema
Const PERFIL_LOG = 2	'-- Perfil de usuário da logistica
Const PERFIL_RAT = 3	'-- Perfil de usuário SISLAB - RAT ou RT

Const EQSETUP_AMOSTRA = "A"			'-- Equipamento é tido como Amostra
Const EQSETUP_EQUIPAMENTO = "E"		'-- Equipamento

Const NF_ENTRADA = 1	'-- Nota fiscal de entrada
Const NF_SAIDA = 2		'-- Nota fiscal de saída
%>