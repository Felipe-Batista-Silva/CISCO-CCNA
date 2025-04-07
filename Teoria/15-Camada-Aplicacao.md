# Camada de aplicação e alguns protocolos populares



A camada de aplicação é a que realmente faz a diferença. Esta camada é a parte superior da pilha OSI e é o local onde o aplicativo reside: você pode encontrar aqui protocolos que permitem enviar e receber e-mails, navegar na web, assistir a vídeos e jogar jogos online. Enquanto o resto da pilha OSI trabalha com os mesmos protocolos o tempo todo, nesta camada cada aplicativo tem seu próprio protocolo. Neste artigo, apresentamos uma visão geral de como funciona um protocolo da camada de aplicação e, a seguir, apresentamos os mais usados. *Vamos começar!*

## A camada de aplicação

Nosso mundo está cheio de aplicativos. Com isso, não nos referimos apenas a aplicativos para smartphones, mas a qualquer programa que possa ser executado em um computador, smartphone ou qualquer outro dispositivo inteligente. Esses programas são usados diariamente para fazer tudo o que tem a ver com o computador. Independentemente da finalidade da aplicação, que pode ser - por exemplo - enviar emails ou navegar na web, todos os programas têm o mesmo objetivo: fornecem uma interface clara que pode utilizar para fazer o que necessita. Mas vamos reescrever esta frase de uma forma mais técnica: em vez de fornecer uma interface fácil para enviar e-mails, o [Mozilla Thunderbird](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.mozilla.org/en-US/thunderbird/) oferece uma interface fácil *de usar a pilha OSI para enviar e-mails* . **Interface de** aplicativos **com usuários humanos**, obtenha informações deles e recodifique-as de forma que possam viajar pela rede e ser compreendidas pelo outro aplicativo do outro lado. A imagem a seguir destaca exatamente isso.

![A interação da camada de aplicação](https://www.ictshore.com/wp-content/uploads/2016/12/1019-01-The_application_layer.png)Os aplicativos fazem interface com o usuário na parte superior e com a camada de aplicativo OSI na parte inferior.

Qualquer aplicativo que precise de acesso à rede pode criar seu próprio protocolo de rede, desde que todas as instâncias desse aplicativo usem o mesmo protocolo. Isso resulta em *uma grande variedade de protocolos* trabalhando nesta camada, com enormes diferenças entre si. No entanto, muitos aplicativos são padronizados e funcionam com **protocolos bem conhecidos** . Os recursos desses protocolos são bem documentados e estão disponíveis gratuitamente online para que você possa desenvolver seu próprio aplicativo de suporte a esse protocolo: isso promove a interoperabilidade de aplicativos. Nas seções a seguir deste artigo, veremos quais protocolos são usados para navegar na web, enviar e-mails, conectar-se a um computador remoto e trocar arquivos e como eles funcionam exatamente.



## Protocolos da web

Em suma, os protocolos da web são os que permitem que você navegue na web. Por falar nisso, é necessário compreender verdadeiramente a diferença entre *“a Web”* e *“a Internet”* . Podemos dizer que *a Web é um subconjunto da Internet* : a Internet é o conjunto de todos os dispositivos interconectados em todo o mundo, enquanto a Web é o conjunto de dispositivos dentro da Internet que oferecem sites e conteúdo da web. Esse **conteúdo da web** consiste principalmente em páginas de texto, imagens e vídeo, e a principal característica que o identifica é que pode ser lido pelo usuário *em tempo real* . Não é como baixar um arquivo e depois abri-lo; navegar na web é obter a página que você está procurando *imediatamente* .

### HTTP Básico

Para atingir esse comportamento, usamos um protocolo específico chamado **Hyper-Text Transfer Protocol** , abreviado como **HTTP** . O nome do protocolo é bastante claro, ele permite a transferência de hipertextos, que são conteúdos da web como páginas de texto, imagens ou vídeos. Essa transferência é projetada com um *modelo cliente-servidor* , onde sempre há um dispositivo (o cliente) que faz solicitações ao outro dispositivo (o servidor), sendo que o servidor responde apenas com o que é solicitado. O HTTP usa **TCP** na camada de transporte, com uma porta aleatória usada pelo cliente e uma *porta bem conhecida* usada pelo servidor: a **porta 80** (por padrão).

Como muitos protocolos da camada de aplicativo, o HTTP é **baseado em texto** : isso significa que seu cabeçalho não é composto de campos de comprimento fixo como TCP, UDP ou outros protocolos trabalhando em camadas inferiores, mas em vez disso, é feito de texto simples. Existem apenas dois tipos de mensagens em HTTP: **Solicitações** , criadas pelo cliente; e **Respostas** , criadas pelo servidor. O cliente abre uma conexão TCP com o servidor da web e, em seguida, envia uma solicitação HTTP de texto simples por essa conexão. Em seguida, o servidor processa a solicitação e responde com uma Resposta HTTP usando *a mesma conexão TCP* , que é então fechada pelo servidor assim que todo o conteúdo é entregue ao cliente. Como na imagem abaixo, o cliente geralmente pede páginas da web ou outros arquivos (como imagens).

![Operação HTTP simples GET / 200 OK](https://www.ictshore.com/wp-content/uploads/2016/12/1019-02-HTTP_operation.png)Uma operação HTTP simples compreende uma solicitação e uma resposta.

Tanto as solicitações quanto as respostas HTTP são compostas por duas partes: o **cabeçalho** e o **corpo**. Ao contrário dos protocolos que trabalham em camadas inferiores, os cabeçalhos HTTP não contêm informações de endereçamento, mas, em vez disso, informações de controle que ajudarão o outro dispositivo a ler a solicitação ou a resposta. Apenas a primeira linha do cabeçalho é obrigatória, pois é aquela que contém as instruções que permitem que a solicitação seja concluída com sucesso. Todas as outras linhas contêm parâmetros extras que permitem o ajuste fino da operação HTTP. Esses parâmetros são sempre escritos na forma de Parâmetro: Valor, um por linha, então não há necessidade de seguir uma ordem específica, pois o parâmetro sendo usado é sempre especificado (por exemplo, você pode usar o parâmetro Agente do Usuário antes ou depois do parâmetro Pragma sem nenhum diferença). Os parâmetros diferem ligeiramente entre solicitações e respostas, e pode ser útil saber como o HTTP funciona exatamente,então, vamos verificar dois exemplos de cabeçalhos HTTP.

### Cabeçalho de solicitação HTTP

O código a seguir é um exemplo de solicitação HTTP, especificamente aquela feita pelo Mozilla Firefox quando você [acessa www.ictshore.com](https://www-ictshore-com.translate.goog/free-ccna-course/application-layer/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) .

```
GET / HTTP/1.1
Host: www.ictshore.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:50.0) Gecko/20100101 Firefox/50.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: it-IT,it;q=0.8,en-US;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate
Cookie: 
Connection: keep-alive
Upgrade-Insecure-Requests: 1
Pragma: no-cache
Cache-Control: no-cache
```

Antes de mergulhar em todos os parâmetros adicionais, vamos verificar a primeira linha. Aqui podemos encontrar três itens importantes: o **método** ( `GET`neste caso), o **assunto** da solicitação ( `/`aqui) e a **versão HTTP** ( `HTTP/1.1`aqui). Embora “Versão HTTP” seja bastante autoexplicativa, vale a pena falar algumas palavras sobre o assunto e o método. O assunto é simplesmente o nome da página da web que estamos tentando obter, que, neste caso, é nenhuma, pois estamos tentando acessar a página inicial `www.ictshore.com`. O método, em vez disso, define como estamos tentando interagir com o servidor. Existem três métodos HTTP:

- **GET** - com este método, o cliente pede um conteúdo da web e todos os parâmetros definidos pelo usuário são especificados dentro do assunto dentro do cabeçalho
- **POST** - com este método, o cliente pede conteúdo da web, todos os parâmetros definidos pelo usuário são especificados no corpo da solicitação
- **HEAD** - este é um método especial: o cliente pede um conteúdo da web exatamente como uma solicitação GET, mas diz ao servidor para enviar de volta apenas o cabeçalho na resposta HTTP, sem o corpo - veremos mais adiante nesta seção o que é propósito deste método

Com *parâmetros definidos pelo usuário* , não queremos dizer parâmetros extras do cabeçalho HTTP, mas sim itens específicos do aplicativo. Por exemplo, quando você preenche um formulário de pesquisa e clica no botão de pesquisa, você precisa enviar ao servidor o que você digitou no botão de pesquisa de alguma forma: você faz isso com algum tipo de parâmetro definido pelo usuário. Agora que sabemos o básico das solicitações HTTP, vamos verificar os parâmetros extras no cabeçalho:

- **Host** - o nome do servidor que estamos tentando acessar
- **User-Agent** - informações sobre nosso navegador e sistema operacional, a serem usadas a partir do servidor para nos fornecer a versão da página da web que funciona melhor com nosso sistema
- **Aceitar** - formatos de arquivo aceitos pelo cliente
- **Accept-Language** - idiomas aceitos pelo cliente
- **Accept-Encoding** - codificação aceita pelo cliente (codificação é a forma como o texto é armazenado em binário)
- **Cookie** - Cookies são variáveis enviadas do servidor ao cliente, que os armazena. Eles são enviados ao servidor da web em qualquer nova solicitação até que expirem usando este campo
- **Conexão** - especifica as configurações sobre a conexão HTTP
- **Upgrade-Insecure-Requests** - se definido como 1, tente usar uma conexão segura em uma conexão não segura, sempre que possível
- **Pragma** - Diz ao servidor informações sobre a maneira como o cliente fará o cache (explicado posteriormente nesta seção)
- **Cache-control** - Diz ao servidor informações extras sobre a forma como o cliente fará o cache

Após o último parâmetro extra em um cabeçalho, para dividir o cabeçalho do corpo, simplesmente usamos uma **linha em branco** . Se a solicitação for bem estruturada, o servidor poderá processá-la e enviar uma resposta adequada.

### Cabeçalho de resposta HTTP

O código a seguir mostra a resposta à solicitação descrita anteriormente.

```
HTTP/1.1 200 OK
Server: nginx/1.10.2
Date: Mon, 26 Dec 2016 10:10:21 GMT
Content-Type: text/html; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Pragma: no-cache
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Link: ; rel="https://api.w.org/"
Vary: Accept-Encoding
Content-Encoding: gzip
```

Novamente, a primeira linha é obrigatória. Ele contém duas informações importantes, a **versão HTTP** ( `HTTP/1.1`aqui) e o **status** da solicitação, que é escrita usando um código ( `200`aqui) e, a seguir, em texto simples ( `OK`aqui). Nesse caso, a solicitação foi bem-sucedida, pois o código de status retornado é `200 OK`. É extremamente útil conhecer os princípios por trás dos códigos HTTP, portanto, verifique a tabela a seguir.

| Código | Nome             | Descrição                                                    |
| ------ | ---------------- | ------------------------------------------------------------ |
| `1XX`  | Informativo      | Esta resposta contém informações extras e precede uma resposta HTTP normal. |
| `2XX`  | Bem-sucedido     | O servidor foi capaz de responder corretamente à solicitação. |
| `3XX`  | Redirecionamento | O conteúdo está em outro lugar, informando ao cliente para chegar ao conteúdo no novo local. |
| `4XX`  | Erro do cliente  | O servidor não conseguiu responder ao pedido devido a um erro do cliente (por exemplo, o cliente fez um pedido com um formato incorreto). |
| `5XX`  | erro de servidor | O servidor está ciente de que não pode responder à solicitação |

Códigos de status HTTP

Os códigos de status HTTP mais comuns incluem `200 OK`, `404 Not Found`e `501 Internal Server Error`. Para obter uma lista completa e sempre atualizada desses códigos, consulte [este documento](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.w3.org/Protocols/rfc2616/rfc2616-sec10) do World Wide Web Consortium (w3c). Agora é hora de verificar os parâmetros extras geralmente usados na resposta HTTP.

- **Servidor** - um aplicativo usado pelo servidor para responder à solicitação (servidor da web)
- **Data** - Data em que o conteúdo foi modificado pela última vez
- **Tipo de conteúdo** - qual é o conteúdo no corpo da resposta
- **Transfer-Encoding** - configurações extras sobre a codificação
- **Conexão** - configurações extras sobre a conexão HTTP
- **Pragma** - Diz ao cliente se ele deve armazenar o conteúdo em cache ou não
- **Expira** - Quando o conteúdo enviado ao cliente com esta resposta se tornará inválido
- **Cache-Control** - Fornece informações adicionais ao cliente sobre o armazenamento em cache
- **Link** - informações sobre links
- **Variar** - aceita variação do cliente nos parâmetros lá especificados
- **Codificação** - codificação usada no corpo desta resposta

Agora, os parâmetros `Expires`e `Date`nos permitem entender o **método HEAD** de solicitações HTTP. Esse método foi desenvolvido para melhorar o desempenho do **armazenamento** em **cache**. Quando um navegador visita um site, ele pode armazenar todas as respostas HTTP que recebe localmente para que, quando você verificar o site novamente, veja o conteúdo armazenado localmente sem ter o servidor da web para enviar esse conteúdo novamente. No entanto, o que acontece se o conteúdo mudar? Você continua vendo a cópia local do conteúdo, que agora é antiga. Em vez disso, com o método HEAD, você pede o cabeçalho HTTP para o conteúdo e pode verificar se a data mudou. Se os dados forem alterados, o cliente criará uma nova solicitação (GET ou POST) para obter o conteúdo atualizado. O campo Expires, em vez disso, informa quando este conteúdo - se armazenado em cache - se tornará inválido. Como você pode ver, no sistema moderno é definido para datas no passado para que nada seja armazenado em cache: o objetivo original do armazenamento em cache era economizar largura de banda e acelerar a conexão,mas em links modernos de alta largura de banda e alta velocidade, tendemos a optar por*sempre com conteúdo atualizado* , então o cache raramente é usado.

### Operação HTTP completa

Neste ponto, você pode pensar que fez uma solicitação HTTP para obter uma página da web e recebeu uma resposta contendo a própria página da web, então está feito. *Não tão fácil!* Os sites são **elementos ricos em conteúdo** , eles contêm imagens, vídeos, fontes sofisticadas, scripts Flash e muitos outros itens. Você começa com uma única solicitação e, em seguida, obtém uma página da web baseada em texto que contém referências a outro conteúdo. Basicamente, na página, você vai encontrar instruções como *“Ok, coloque lá: imagem X”* ou *“Por favor, use a fonte Y”* . Seu navegador leu essas instruções e, em seguida, consultou o servidor em busca de arquivos ausentes, usando uma nova solicitação HTTP. Para cada arquivo, existe uma Resposta HTTP independente, conforme a figura.

![Conexão HTTP com várias referências, solicitações e respostas](https://www.ictshore.com/wp-content/uploads/2016/12/1019-03-HTTP_connection.png)Em uma conexão HTTP do mundo real, o conteúdo enviado do servidor contém referência a outro conteúdo da web que o cliente precisa fazer download. Cada solicitação é independente e pode ter um resultado diferente.

Geralmente, uma conexão TCP suporta *uma única troca* de solicitações e respostas, mas para acelerar o processo alguns sistemas podem implementar várias solicitações e respostas na mesma conexão TCP ou podem abrir várias **conexões TCP / HTTP simultâneas** , uma por arquivo, para obter tudo mais rápido.

### HTTP seguro

Segurança é um tópico importante nas redes modernas, portanto, não podemos falar sobre a web sem gastar algum tempo em **HTTPS** . Este protocolo é *a versão segura* do HTTP (o “S” significa “Seguro”) porque autentica o servidor e criptografa o tráfego. Isso significa que o cliente sabe, sem dúvidas, que está falando com o servidor correto, e o tráfego entre o cliente e o servidor não pode ser ouvido por mais ninguém. HTTPS funciona na **porta** TCP **443** (lado do servidor).

![HTTPs usa TLS / SSL para proteger o tráfego](https://www.ictshore.com/wp-content/uploads/2016/12/1019-04-HTTPS_TLS_and_SSL.png)HTTPs usa criptografia TLS / SSL para proteger o tráfego da web.

O tráfego HTTP normal pode ser manipulado por um invasor facilmente, pois é apenas um texto simples. O tráfego HTTPS ainda é texto simples, mas usa uma camada adicional de segurança na camada de transporte, chamada **TLS (Transport Layer Security)** . TLS é a nova versão do **SSL (Secure Socket Layer)** e é um aprimoramento das conexões TCP que criptografam o tráfego. Basicamente, o aplicativo da web grava texto simples como de costume, mas esse texto é criptografado enquanto desce na pilha OSI. No outro dispositivo, ele será descriptografado ao subir.

## Protocolos de Correio

Os e-mails são uma ótima maneira de se comunicar pela Internet. Eles permitem a troca de *conteúdo baseado em texto* e *rico em mídia* , como imagens, vídeos e qualquer outro arquivo. Tudo isso é entregue quase imediatamente ao destinatário correto, e isso torna o e-mail um componente obrigatório para qualquer negócio. Ao contrário da web, que funciona com um único protocolo, existem vários protocolos envolvidos na troca de emails (envio e recebimento de emails).

Qualquer sistema de e-mail depende de servidores. Um **servidor de e** - **mail** é simplesmente um servidor que está pronto para receber e-mails e armazená-los 24 horas por dia, 7 dias por semana em uma **caixa de correio** , esperando que um usuário faça o login e os verifique. Esse servidor também é aquele que envia e-mails em seu nome para outros servidores. Para enviar e-mails, usamos o **Simple Mail Transfer Protocol (SMTP)** . Este é um protocolo TCP baseado em texto que funciona sobre o transporte TCP na **porta 25** (lado do servidor) e tem um propósito específico: entregar emails ao servidor de destino. Sempre que enviar um e-mail, você o enviará para seu servidor de e-mail usando SMTP. Em seguida, seu servidor verifica todos os destinatários e envia os e-mails para todos os servidores de destino. Nesse ponto, o e-mail ficará armazenado lá até que o usuário verifique sua caixa de entrada.

Para gerenciar os e-mails que você tem em sua caixa de entrada, você pode usar dois protocolos: **Post Office Protocol** **(POP)** , *usado atualmente na versão 3 - POP3* , ou **Internet Message Access Protocol (IMAP)** . O POP3 ( *porta 110* do lado do servidor) é considerado *legado* porque apenas baixa sua caixa de entrada, excluindo-a do servidor. Isso significa que você não pode ver os mesmos e-mails em vários dispositivos, porque o primeiro a vê-los irá baixá-los e excluí-los do servidor. Em vez disso, para usar vários dispositivos, você deve usar IMAP ( *porta 143* do lado do servidor). Com este protocolo, você trabalha em seus e-mails usando uma cópia local temporária, enquanto *a obra-prima é sempre mantida no servidor*. Mais do que isso, o IMAP adiciona a possibilidade de *organizar seus emails em pastas* até mesmo no servidor.

![Protocolos de e-mail como SMTP, POP3, IMAP, mas também HTTP](https://www.ictshore.com/wp-content/uploads/2016/12/1019-05-Mail_protocols_SMTP_IMAP_POP3_HTTP.png)Os e-mails são enviados com SMTP, gerenciados na caixa de correio com POP3 ou IMAP, mas também podem ser acessados via HTTP

Outra consideração importante são os webmails, caixas de correio que você pode acessar usando seu navegador em **HTTP** , sem usar SMTP, IMAP ou POP3. Isso ocorre porque alguém criou um aplicativo da web (basicamente um site) que interage com o servidor de e-mail usando os protocolos corretos e fornece uma interface para o usuário por meio de HTTP. Muitos provedores de e-mail oferecem a possibilidade de verificar sua caixa de entrada usando os protocolos tradicionais, mas também fornecem uma interface web fácil. Na imagem anterior, temos um exemplo, onde o usuário se conecta a um servidor web em vez de um servidor de correio para verificar seus e-mails.

## Controle de dispositivos remotos

Qualquer empresa precisa de uma infraestrutura de TI, que cresce à medida que a empresa cresce. Essa infraestrutura estará cheia de dispositivos diferentes: dispositivos de *rede* , como switches e roteadores, e *servidores de infraestrutura* , como servidores de e-mail. Em grandes ambientes, é necessário ter a possibilidade de se conectar a esses dispositivos e **controlá-los remotamente** , sem ter que ir fisicamente aonde estão. Felizmente, nosso conjunto de protocolos nos fornece duas tecnologias e vários protocolos para fazer exatamente isso.

### Área de trabalho remota

A família de protocolos “Remote Desktop” é o grupo de protocolos que permite controlar dispositivos usando a mesma interface gráfica que você usa quando está fisicamente na frente do dispositivo. Você estabelece uma sessão com o dispositivo remoto, então seu PC irá interceptar tudo o que você fizer e enviar para o dispositivo remoto. Isso significa que ele vai enviar tudo o que você digitar no teclado, os movimentos do mouse e até a conexão de drives USB. Em vez disso, o dispositivo remoto enviará saídas de vídeo e áudio.

![Protocolos de área de trabalho remota, como RDP ou PCoIP](https://www.ictshore.com/wp-content/uploads/2016/12/1019-06-Remote-desktop_protocols.png)Os protocolos de área de trabalho remota permitem a troca de conteúdo visual.

Existem dois protocolos principais nesta família: **Remote Desktop Protocol (RDP)** criado pela Microsoft e usando a *porta* TCP *3389* , e **PC sobre IP (PCoIP)** criado pela VMware. Eles são usados principalmente para gerenciar servidores Windows e em ambientes de *Virtual Desktop Infrastructure (VDI)* . Basicamente, em um ambiente VDI, você apenas usa seu computador para se conectar a um PC virtual remoto e, em seguida, usa esse PC virtual remoto como se fosse seu. Não iremos mais longe nisso, pois está fora do escopo deste artigo.

### Shell Remoto

Nem todos os dispositivos possuem uma interface gráfica: alguns deles possuem apenas uma *interface de texto* , chamada **Shell** , onde você pode simplesmente digitar o texto e ver o texto de volta, você nem pode usar o mouse! Este tipo de interface de usuário é extremamente leve (não consome muitos recursos computacionais) e seu controle pode ser automatizado porque é mais fácil para um script automatizado enviar um texto simples do que emular o movimento do mouse.

![Protocolos de shell remoto, como telnet e operação SSH](https://www.ictshore.com/wp-content/uploads/2016/12/1019-07-Remote_shell_Telnet_SSH.png)Os protocolos de shell remoto permitem a troca de conteúdo de texto.

Dispositivos com recursos escassos, dispositivos legados, dispositivos de rede e servidores Linux oferecem uma interface de shell remota. Essa interface pode ser fornecida usando dois protocolos: **Telnet** ou **Secure Shell (SSH)** . Telnet é um protocolo extremamente simples, mas pode ser extremamente útil: ele apenas abre uma conexão TCP para o dispositivo remoto (por padrão na *porta 23*) e, em seguida, envie tudo o que você digitar. Como todos os protocolos de aplicativo são baseados em texto, você pode fazer telnet em um servidor da Web abrindo uma conexão para a porta 80 e, em seguida, criar uma solicitação HTTP manualmente. Em vez disso, você pode usar a porta 23 para enviar comandos para controlar e configurar o dispositivo remoto. Observe que, mesmo se o dispositivo remoto solicitar sua autenticação, o nome de usuário e a senha fornecidos são enviados em texto simples, para que um invasor intermediário possa ver seus dados pessoais.

*Uma alternativa muito melhor* ao Telnet é o SSH ( *porta TCP 22 do* lado do servidor ). A experiência do usuário é quase idêntica, mas oferece um ótimo nível de segurança porque criptografa o tráfego nas duas direções. Visto que você pode alterar a configuração dos dispositivos usando o protocolo de shell remoto, é melhor configurar esses dispositivos para aceitar apenas a conexão SSH, pois o Telnet pode ser falsificado - um invasor obtendo acesso aos seus dispositivos pode danificar seriamente a sua infraestrutura.

## Transferência de arquivo

Não podemos falar sobre protocolos de aplicativos sem falar sobre **File Transfer Protocol (FTP)** . O nome é autoexplicativo, o FTP permite a troca de arquivos entre um cliente e um servidor, mas também a possibilidade de listar arquivos no dispositivo remoto: em suma, é uma forma de *controlar um sistema de arquivos remoto* .

O FTP funciona com duas conexões TCP separadas, uma para ser usada para controle e outra para dados. A **conexão de controle** ( *porta 21* do lado do servidor) é aquela usada para trocar instruções (por exemplo, *“Pegue este arquivo!”* ), Enquanto a **conexão de dados** ( *porta 20* do lado do servidor) é usada para transferir fisicamente os arquivos.

![O FTP usa um controle e um fluxo de dados TCP](https://www.ictshore.com/wp-content/uploads/2016/12/1019-08-File_transfer_protocol.png)O FTP separa o tráfego de controle do tráfego de dados usando dois fluxos TCP separados.

Existem duas maneiras de abrir uma conexão TCP: ativa ou passiva. Com **o FTP ativo** , o cliente abre a conexão de controle e então envia por ele o comando “PORTA”, especificando em qual porta estará escutando a conexão de dados. O servidor lê essas informações e, em seguida, abre ativamente a conexão de dados com o cliente na porta especificada. Com o FTP passivo, em vez disso, o cliente abre a conexão de controle e envia por ela o comando “PASV” (Passivo). O servidor então entende que o cliente está tentando uma conexão FTP e envia o comando *“PORT”* ao cliente para informá-lo em qual porta ele estará escutando os dados. Em seguida, é o cliente que abre a conexão de dados para o servidor na porta especificada.

![Estabelecimento de conexão FTP ativa e passiva](https://www.ictshore.com/wp-content/uploads/2016/12/1019-09-Active_and_passive.png)O FTP ativo e passivo alcançam o mesmo resultado com um estabelecimento de conexão diferente para o canal de dados.

O FTP ativo é a configuração mais simples, mas o *FTP passivo é o que deve ser usado na maioria das vezes* . Mesmo que o FTP passivo envolva uma troca mais sofisticada, nesta conexão cabe ao cliente abrir a conexão de controle e de dados e isso pode ser extremamente útil quando o cliente está protegido por um firewall, como na maioria dos cenários. Geralmente, os firewalls são configurados para permitir que os clientes se conectem a dispositivos externos, mas qualquer conexão iniciada de dispositivos externos para clientes é negada: isso impedirá que o servidor abra a conexão de dados. Se o cliente é quem está abrindo todas as conexões, *isso será permitido pelo firewall* .

## Conclusão

Apenas para recapitular, a tabela a seguir lista todos os protocolos que abordamos neste artigo com os principais detalhes que você deve lembrar.

| Protocolo | Transporte | Porta do servidor padrão | Descrição                                                    |
| --------- | ---------- | ------------------------ | ------------------------------------------------------------ |
| HTTP      | TCP        | 80                       | Transfira conteúdo da web sem criptografia.                  |
| HTTPS     | TCP        | 443                      | Transfira conteúdo da web com segurança (com criptografia).  |
| SMTP      | TCP        | 25                       | Mande emails.                                                |
| POP3      | TCP        | 110                      | Baixe e-mails de um servidor de e-mail.                      |
| IMAP      | TCP        | 143                      | Gerenciar e-mails no servidor de e-mail.                     |
| RDP       | TCP        | 3389                     | Execute uma sessão de desktop remoto (com interface gráfica) em outro PC. |
| Telnet    | TCP        | 23                       | Envie comandos para um dispositivo baseado em shell, sem criptografia. |
| SSH       | TCP        | 22                       | Envie comandos para um dispositivo baseado em shell, com criptografia. |
| FTP       | TCP        | 21, 20                   | Transfira o arquivo entre um cliente e um servidor.          |

Alguns protocolos da camada de aplicativo.

Com esse conhecimento em mente, você deve ter agora uma ideia geral sobre como funciona a camada de aplicativo. Com isso em mente, você está pronto para enfrentar alguns protocolos específicos da camada de aplicação que são usados para aprimorar as funcionalidades da rede, como veremos no próximo artigo do curso.