<%
'--
'-- Arquivo de constantes e variaveis globais do sistema
'--
Const TITULO_SITE = "SISLAB - Site do Centro de Refer&ecirc;ncia Tecnol&oacute;gica"

Const MENU_ON = true		'-- mostra o menu
Const MENU_OFF = false		'-- esconde menu

Const RODAPE_ON = true		'-- mostra a imagem de rodape
Const RODAPE_OFF = false	'-- esconde a imagem

'Email para o qual sera enviadas mensagems com falta de RT ou RAT
Const EMAILALTERNATIVO = "ilab@embratel.com.br"
Const SUFIXOEMAIL = "@embratel.com.br"
Const EMAILDEENVIODOSISLAB = "ilab@embratel.com.br"
CONST NOMEDEENVIODOSISLAB = "SISLAB"
CONST SEPARADOR = " #$%@ "
CONST SEPARADOR_REGISTRO = "#$%@"
CONST SEPARADOR_REGISTRO2 = "¡¬¡"
CONST SEPARADOR_CAMPO = "«»"
'para formatação de datas
session.lcid = 1046 'Brasil


'-- Situações de Agendamento e Orde de Servico - Tabela SITUACOES
Const AS_Cadastrado = 1
Const AS_Pendente = 2
Const AS_Agendado = 3
Const AS_Indeferido = 4
Const AS_Cancelado = 5
Const AS_Em_Execucao = 6
Const AS_Interrompido = 7
Const AS_Finalizado = 8
Const OS_Agendado = 9
Const OS_Pendente = 10
Const OS_Em_Execucao = 11
Const OS_Interrompido = 12
Const OS_Indeferido = 13
Const OS_Cancelado = 14
Const OS_Finalizado = 15

'-- Constates do LOGBOOK - Tabela LB_TIPOACAOTOMADA
Const LB_Acao_Imediata = 1
Const LB_Acao_Corretiva = 2
Const LB_Acao_Preventiva = 3

'-- Constantes do tipo de Teste
Const Teste_Eventual = 1
Const Teste_Em_Certificacao = 2
Const Teste_Certificado = 3
Const Teste_Nao_Validado = 4

'-- Constantes usadas pelo cadastro de notícias
Const PLANTAO_Destaque = "D"
Const PLANTAO_Noticia = "N"

'-- Constantes usadas para abertura de arquivos
Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8
%>
