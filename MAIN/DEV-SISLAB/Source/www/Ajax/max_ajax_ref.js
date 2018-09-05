/**
 * @author Fábio Miranda Costa <fabiomcosta@gmail.com> (não enviar dúvidas por favor) - www.meiocodigo.wordpress.com
 * @version 0.26
 * Pequena biblioteca para uso geral em Ajax.
 * bugs conhecidos: Não conversa muito bem com tabelas.
 * Testado com IE 6 e firefox 2.
 * Qualquer dúvida mande e-mail para meiocodigo@gmail.com ou simplesmente comente.
 */

//verifica a existência do objeto max antes de criá-lo para ser possível acrescentar mais de uma das bibliotecas max
//irei postando aos poucos as bibliotecas
if(typeof window.max === "undefined") var max = new Object();


/**
 * Construtor da classe max.Ajax
 * 
 * @param {String} url - a url do arquivo que receberá a chamada ajax
 * @param {Object} options - um objeto que conterá as possíveis opções, entre elas estão:
 * update (opcional) - um id de um nó DOM que receberá a resposta do servidor.
 * onComplete (opcional) - função que será executada logo após o servidor ter respondido ao pedido.
 * 
 */
max.Ajax = function(url,options){
	this.xmlHttp = this.createXMLHttp();//criação do objeto que tratará da nossa requisição ao servidor
	this.url = url;
	this.update = options.update || null;//se não for definida um id para fazer o update, this.update = null, caso contrário this.update = options.update
	this.onComplete = options.onComplete || function(){};//se tiver sido definida uma função para ser executado ao final da requisição então this.onComplete = options.onComplete senão this.onComplete = null;
};

max.Ajax.prototype = Object({
	/**
	 * Método para enviar pedido get.
	 */
	get:
		function(){
			var thisObj = this;//fazendo referência a este objeto
			this.xmlHttp.onreadystatechange = function(){thisObj.updateFunc();};//esta linha define qual será a função que será executada quando nosso objeto xmlHttp tiver seu estado modificado, noc aso updateFunc()
			this.url += (this.url.indexOf("?") === -1)?"?":"&";
			this.url += "ridwes="+Math.random();//adicionando uma variável randomica ao nosso get para que resolva um problema de cache que acredito que só aconteça no IE, chamei de ridwes por que acredito que ninguem teria uma variavel com esse nome, mas se for o caso...modifique hehe
			this.xmlHttp.open("get",this.url,true);//define que o método usado para a nossa requisição será o 'get', a url do arquivo que receberá a requisição e o true indica que a chamada será assincrona.
			this.xmlHttp.send(null);//finalmente envia nosso pedido
		},
	/**
	 * Método executado toda vez que o xmlHttp mudar de estado.
	 */
	updateFunc:
		function(){
			if (this.xmlHttp.readyState==4 || this.xmlHttp.readyState=="complete"){//verifica se o estado do xmlHttp é de completo, ou seja se a resposta do servidor já está "em mãos"
				if (this.xmlHttp.status == 200){//verifica se o estatus do objeto é de sucesso, caso contrario o ideal seria mostrar um erro, mostrarei isso no futuro
					if (this.update){
						document.getElementById(this.update).innerHTML = this.xmlHttp.responseText;//joga o texto de resposta do servidor dentro do nó DOM especificado na opção update, se ela existir
					}
					this.onComplete(this.xmlHttp.responseText,this.xmlHttp.responseXML);//executa a função ao final da chamada ajax, também chamada de callback
				}
			}
		},
	/**
	 * Copiado na cara de pau, peguei de um artigo no Wrox.
	 * Método usado para a criação do objeto XMLHttp, peça chave para o ajax.
	 * Não explicarei em detalhes.
	 */
	createXMLHttp:
		function(){
			if(typeof XMLHttpRequest != "undefined")//entra em todos os navegadores menos o IE
		        return new XMLHttpRequest();
			else if (window.ActiveXObject) {//no caso do IE
		      var aVersions = [ "MSXML2.XMLHttp.5.0","MSXML2.XMLHttp.4.0","MSXML2.XMLHttp.3.0","MSXML2.XMLHttp","Microsoft.XMLHttp"];
		      //por cima, o que ela faz é verificar qual a versão mais recente do xmlHttp Object suportada pelo navegador e retorna o objeto
			  for (var i = 0; i < aVersions.length; i++) {
		        try{
		            var oXmlHttp = new ActiveXObject(aVersions[i]);
		            return oXmlHttp;
		        }catch (oError){}
		      }
		    }
			throw new Error("Objeto XMLHttp não pode ser criado.");
		}
});

