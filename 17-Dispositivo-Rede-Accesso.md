# O dispositivo de rede: fator de forma e acesso ao console



Conversamos muito sobre o que é um switch ou um roteador, o que eles fazem e em que camada OSI eles funcionam. No entanto, ainda não falamos muito sobre suas características físicas. Um dispositivo de rede é uma peça tangível de hardware com a qual você pode trabalhar, conectar com o cabo ou empilhar um sobre o outro. Este artigo é exatamente sobre isso, veremos como é *desencaixotar um dispositivo de rede* , como um roteador ou um switch.

## O Dispositivo de Rede

### Visão geral do painel frontal

Dispositivos de rede garantem conexão a outros dispositivos. Por sua natureza, você só pode gerenciá-los por outros meios, especificamente remotamente. Por isso, possuem formato retangular, *curto e grande* . Eles não vêm com mouse, teclado ou tela, você não pode nem conectar esses periféricos a um dispositivo de rede como um switch ou um roteador, isso não faz parte do design. No entanto, alguns dispositivos podem ter *uma pequena tela LCD que* fornece algumas informações básicas sobre a temperatura interna e o estado de saúde do dispositivo.

Em vez disso, você sempre pode encontrar interfaces (também conhecidas como portas). Essas interfaces são os slots onde você pode conectar os cabos, e a maioria deles suporta cabos Ethernet com uma *terminação RJ45* ou *slots SFP* para cabos de fibra óptica. Você pode encontrar todas essas portas na frente do seu dispositivo, enquanto na parte traseira você pode encontrar o cabo de alimentação para a fonte de alimentação. No entanto, muitos dispositivos de rede *não têm um botão liga* / *desliga* , eles ligam assim que recebem energia.



Vamos voltar ao **painel frontal** do nosso dispositivo. Muitas portas serão usadas para conectar dispositivos (outros switches, roteadores ou computadores), mas esse não é o único tipo de porta que você pode encontrar no dispositivo. Algumas portas, separadas das outras, são as únicas para gerenciar o dispositivo: a *porta* do *console* e a *porta AUX* .

![Porta do console do dispositivo de rede no painel frontal](https://www.ictshore.com/wp-content/uploads/2017/01/1021-01-Front_panel.png)Cada dispositivo de rede possui uma porta de console pronta para ethernet em sua frente. Os dispositivos Cisco os exibem em azul claro e alguns dos modernos incluem uma porta de console alternativa USB Tipo-B paralela.

### Portas de gerenciamento

A **porta do console** é a primeira que você usará após *desembalar o dispositivo* . Para configurar o dispositivo, você deve usar uma interface baseada em texto, onde você escreve o texto, o dispositivo o lê e retorna outro texto para você: as portas de console fornecem exatamente isso, permitindo uma [transmissão síncrona](https://www-ictshore-com.translate.goog/free-ccna-course/transmission-control-protocol-advanced/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) de caracteres de texto. Mesmo que as portas do console sejam um plugue RJ45, você não pode usar um cabo de rede simples aqui, mas deve usar um cabo de console específico, que tem um lado RJ45 e um lado *RS232 (serial)* . Muitos PCs modernos não têm um conector RS232 embutido, então você deve usar o cabo do console em combinação com um *conversor USB para serial*. Devido à natureza desta conexão, os cabos do console são relativamente curtos (alguns centímetros a alguns metros), eles não são para transmissão de longa distância.

![Cabo Cisco Console para controlar um dispositivo de rede](https://www.ictshore.com/wp-content/uploads/2017/01/1021-02-Console_cable.jpg)Este é o cabo oficial do console Cisco.

A **porta AUX (Auxiliar)** também foi projetada para configurar o dispositivo de rede, mas de uma maneira diferente. Com a porta do console, para conectar ao dispositivo, devemos estar próximos a ela. Com a porta AUX, podemos fazer isso **remotamente** . Especificamente, essa porta foi projetada para funcionar como um telefone analógico. Usando um modem, você pode ligar para um número de telefone atribuído ao dispositivo e obter acesso à sua configuração. Isso permite que você se conecte ao dispositivo remotamente mesmo se a rede cair, no entanto, isso não é tão comum hoje em dia. Mesmo que a ideia por trás seja boa, já que permite o **gerenciamento Out of Band (OOB)** do dispositivo (o dispositivo é gerenciado por meio de uma rede dedicada), esta solução não é barata.

Para permitir isso, você deve preparar uma infraestrutura totalmente separada executando cabos físicos separados para todos os seus dispositivos, conectá-los a um *Private Branch Exchange (PBX)* e, em seguida, à rede de telefonia pública, tendo o cuidado de obter todos os números de telefone necessários . Além disso, os sistemas de telefonia modernos dependem da rede e não funcionarão se a rede estiver inativa. Por causa disso, o uso de portas AUX agora é considerado uma *prática legada* . No entanto, essa porta funciona com a mesma lógica da porta do console. Isso significa que você pode *usar alguns truques* para usar essa porta como uma porta de console, caso a porta de console esteja quebrada. Isso, no entanto, está fora do escopo deste artigo.

## O fator de forma

### Dispositivo de rede em um rack

Agora que temos uma ideia geral sobre a forma de um dispositivo de rede, é hora de falar sobre isso em termos técnicos. Na verdade, *o fator* de *forma* de um dispositivo de rede é simplesmente sua forma. Podemos dividir dispositivos de TIC em duas categorias principais: *dispositivos de usuário final* e *dispositivos de data center* . Os **dispositivos do usuário final** são aqueles usados diretamente por alguém. Um exemplo de dispositivo de usuário final pode ser um laptop, um smartphone ou um computador desktop. Em vez disso, **os dispositivos do data center** servem a outros dispositivos: são dispositivos de rede, switches, roteadores, firewalls e assim por diante. Por isso, esses dispositivos não foram projetados para serem colocados em uma mesa. Em vez disso, eles são colocados em salas específicas (os centros de dados).

Em um data center, muitos dispositivos diferentes de fornecedores diferentes precisam compartilhar o mesmo espaço. Sem algumas regras, isso pode resultar em uma grande confusão. Felizmente, temos essas regras. Para maximizar o espaço dedicado aos dispositivos, temos o conceito de **rack** . Um rack é um armário projetado para armazenar dispositivos. Um data center é uma sala com um ou mais racks. *Os racks têm tamanhos padrão* e os dispositivos a serem colocados dentro deles também devem seguir esses tamanhos. Especificamente, a largura e a profundidade são sempre as mesmas, enquanto a altura pode variar, mas apenas em incrementos de *1,75 polegadas* (ou *44,45 mm*) Isso significa que podemos ter dispositivos de 1,75 ”ou 3,5”, mas não de 3,0 ”. Por isso, não medimos a altura de um dispositivo em polegadas ou milímetros, mas sim em **Rack Units (RUs)** , com `1RU = 1.75"`.

### Fator de forma de configuração do switch

Embora essas regras de rack se apliquem a todos os dispositivos de data center, há alguns conceitos específicos que se aplicam apenas a dispositivos de rede. Agora estamos realmente falando sobre o fator de forma. O **fator de forma** é o formato do dispositivo de rede em termos de *flexibilidade e modularidade* . Em dispositivos de rede, podemos encontrar três tipos de fatores de forma em switches.

- **Switches de configuração fixa** - switches com este formato têm 1RU de tamanho. Você não pode expandir o número de portas neles. Este é o fator de forma mais simples e barato disponível.
- **Switches de configuração empilháveis** - switches com este formato são semelhantes aos de configuração fixa, com alguns aprimoramentos. Você pode conectá-los juntos com um cabo específico, eles funcionarão como um único dispositivo. O cabo usado, para dispositivo Cisco, é denominado Cisco StackWise. Ele pode conectar até 9 interruptores em loop (primeiro dispositivo para o segundo, segundo para o terceiro e terceiro para o primeiro).
- **Switches de configuração modulares** - esses switches são os mais caros (e poderosos). Eles têm um chassi que é basicamente uma caixa com fontes de alimentação redundantes, e nele você pode colocar várias placas de linha, de acordo com a sua necessidade. As placas de linha são componentes que hospedam fisicamente as portas, enquanto o chassi permite a comunicação entre placas de linha. Este tipo de dispositivo é usado no backbone corporativo.

A imagem a seguir apresenta os diferentes fatores de forma já explicados.

![Fator de forma do dispositivo de rede: switch em configuração fixa, empilhável ou modular](https://www.ictshore.com/wp-content/uploads/2017/01/1021-03-Form_factor.png)Um switch pode vir em fatores de forma diferentes, dependendo da finalidade do dispositivo.

## O console

### Entrando no console

Agora que conhecemos as características físicas de um dispositivo de rede, é hora de ver como podemos configurá-los. Desta forma, nos artigos seguintes podemos começar a colocar as mãos na parte de configuração. Para obter acesso do console a um dispositivo de rede, você precisará do cabo do console e do conversor USB para serial. Depois disso, você precisará de um software de emulação de terminal. Esse software é o que controla o processo de envio e recebimento de caracteres no cabo do console. Felizmente, existem vários softwares livres para fazer exatamente isso. O mais famoso e mais simples é o [PuTTY](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) : nem precisa ser instalado, é um arquivo executável simples que você pode baixar e rodar conforme a necessidade.

*Dica: os conversores USB para serial não são dispositivos plug-and-play, você deve instalar seus drivers. Felizmente, essa não é uma tarefa complexa. Verifique com o fabricante do seu conversor qual é o driver que você deve instalar.*

Assim que seus drivers estiverem prontos, execute PuTTY como administrador. Antes de conectar, você pode querer verificar as configurações Serial. Vá para a aba **Conexão> Serial** , tudo deve estar como na imagem abaixo *(configurações padrão)* .

![Configurações padrão do PuTTY em série](https://www.ictshore.com/wp-content/uploads/2017/01/1021-04-PuTTY_Settings.png)A imagem mostra as configurações padrão do PuTTY para uma conexão serial.

Quando estiver pronto, o dispositivo de rede será ligado e tudo estiver conectado, você pode iniciar a conexão. Faça isso na guia **Sessão** , selecionando *Serial* . Você também terá que especificar a linha serial, que é a porta serial do seu PC que você está tentando usar. As linhas seriais comuns são **COM1** , **COM3** e **COM5** . Se receber um erro dizendo *“Não foi possível abrir a porta serial”,* provavelmente você está usando a linha serial errada.

![Conectando-se a um dispositivo de rede no console usando PuTTY](https://www.ictshore.com/wp-content/uploads/2017/01/1021-05-PuTTY_Session.png)Para conectar no console a um dispositivo de rede usando PuTTY, vá em “Sessão”, selecione “Serial” e clique no botão “Abrir”.

![Erro de PuTTY COM e como resolvê-lo](https://www.ictshore.com/wp-content/uploads/2017/01/1021-06-PuTTY-COM_error.png)Caso você escolha a linha serial (COM) errada, você obterá este tipo de erro.

Se tudo estiver OK, uma nova janela preta aparecerá. Lá, pressione a tecla Enter algumas vezes até que algum texto apareça. Se o dispositivo for novo, ele o solicitará ao assistente de configuração. Em vez disso, se este dispositivo tiver alguma configuração, pode ser necessário autenticar com o usuário e a senha.

## As solicitações da Cisco

### Cisco Prompts System

A conexão a um dispositivo no console é idêntica, independentemente do fornecedor. No entanto, o que você digita depois de fazer login depende dos fornecedores de hardware. Cada produto implementa seus próprios comandos de configuração proprietários. Não existe um padrão sobre isso, você só precisa saber o que digitar. No entanto, a lógica por trás da configuração é sempre a mesma: você deve entrar em uma *área de configuração específica* para executar determinados comandos. A Cisco implementa esse conceito com um **sistema de prompts** simples .

Configurar um dispositivo de rede significa enviar e receber texto. No entanto, não é como escrever um documento de texto, *é muito parecido com um bate* - *papo* : você escreve o texto linha por linha e pressiona enter. Cada vez que você escreve uma linha e pressiona enter, o dispositivo processa a instrução e se comporta de acordo. Depois disso, ele envia um texto para informar que está pronto para processar mais comandos. Esse pedaço de texto, que você encontrará *no início de cada linha* , é chamado de **prompt** . É um identificador visual do estado atual de configuração / gerenciamento.

### Modo de usuário e privilegiado

Assim que você faz login em um dispositivo, entra no **modo de usuário** . Este prompt é identificado pelo nome do dispositivo seguido por um sinal “maior que” (>). Como referência de exemplo, digamos que estamos configurando um dispositivo denominado “Roteador”. Nesse caso, o prompt será `Router>`. Neste prompt, não podemos fazer quase nada, então podemos digitar o comando enable. Esse comando nos pedirá para fornecer uma senha (se configurada anteriormente) e, em seguida, nos levará ao **modo Exec privilegiado** , identificado pelo *sinal de sustenido* (#, por exemplo `Router#`). A partir daí, podemos fazer todos os comandos de verificação de que precisamos. Além disso, podemos entrar no **modo de configuração** . Para fazer isso, digitamos terminal de configuração e, em seguida, estamos neste novo prompt`Router(config)#`.

A partir daí, podemos definir as configurações gerais sobre o dispositivo e entrar nos modos de configuração específicos do item. Por exemplo, temos modos específicos para configurar interfaces, VLANs, protocolos de roteamento e assim por diante. Para acessar o “modo pai”, você pode digitar `exit`. No entanto, observe que o modo Privilegiado não é filho do modo Usuário, e digitar `exit`no modo Exec privilegiado irá desconectá-lo do dispositivo, mostrando novamente o prompt de login. De qualquer modo de configuração, você pode digitar `end`para chegar ao modo Exec privilegiado imediatamente. A imagem a seguir mostra como se mover entre os prompts da Cisco.

![Cisco Prompts (modo de usuário, modo privilegiado, configurar terminal e mais)](https://www.ictshore.com/wp-content/uploads/2017/01/1021-07-Cisco_prompts.png)A Cisco oferece vários prompts, cada um deles com seu comando exclusivo.

## Conclusão

Após este artigo, você saberá como lidar com dispositivos de rede de uma perspectiva física. Você aprendeu como se locomover entre os prompts da Cisco, então está pronto para colocar as mãos na configuração real. No próximo artigo, mostraremos como praticar toda a configuração de nível CCNA de que você precisa. O legal disso é que você pode fazer isso sem comprar nenhum equipamento de rede! Em seguida, continuaremos o guia CCNA com vários laboratórios para aumentar suas habilidades técnicas!