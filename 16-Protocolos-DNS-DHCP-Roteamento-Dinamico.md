# Protocolos para a rede: DNS, DHCP, roteamento dinâmico



Os aplicativos podem fazer muitas coisas e, entre elas, também podem aprimorar o funcionamento da camada de rede. Neste artigo, cobriremos alguns protocolos de camada de aplicativo importantes para a rede. Eles são usados para facilitar a configuração da rede, torná-la resiliente a falhas ou ajudar os administradores na configuração inicial dos dispositivos de rede. As informações que você encontra neste artigo são essenciais para qualquer técnico de rede, portanto, boa leitura!

## Protocolos para a rede: a camada de rede não é suficiente

Todos nós sabemos o verdadeiro propósito da camada de rede: *entregar pacotes a hosts remotos* . Esta é uma declaração simples que define extremamente bem o que a camada de rede faz e se destina a fazer. Para manter a *modularidade e a escalabilidade* de toda a pilha OSI, devemos mantê-la dessa forma. No entanto, como a camada de rede é tão limitada por definição, precisamos criar alguns protocolos de camada de aplicativo específicos para melhorar o que acontece na camada de rede. Especificamente, estamos procurando alguns **benefícios** que a camada de rede não tem por padrão.

![Protocolos para os benefícios da rede, automação, flexibilidade e facilidade de uso](https://www.ictshore.com/wp-content/uploads/2017/01/1020-01-Protocols_for_the_network.png)Os aprimoramentos da camada de aplicativo melhoram a experiência do usuário na rede.

A primeira coisa que queremos é **automação** . Queremos que as coisas sejam plug-and-play, reduzindo a configuração que o administrador precisa fazer. Então, queremos aumentar a **flexibilidade** para que a rede (concebida como um conjunto de dispositivos) possa reconhecer as modificações e se adaptar às novas mudanças sem intervenção humana. Também queremos **facilidade de uso** , mantendo a experiência do usuário final o mais simples possível. Para fazer tudo isso, temos vários protocolos, mas os mais importantes são *DNS* e *DHCP* . Iremos tratá-los neste artigo e, em seguida, também teremos uma breve visão geral do *TFTP* e do *roteamento dinâmico* .



### DNS

DNS significa **Domain Name System** e é um protocolo que fornece a tradução entre nomes e endereços IP. Qualquer servidor na Internet possui um endereço IP, mas é extremamente raro que você use endereços IP para navegar até o site de que precisa. Seria impossível lembrar de todos eles. Em vez disso, você usa nomes: você sabe que navega para `google.com`, não para `216.58.205.78`. No entanto, como o computador também precisa saber o endereço IP para enviar o tráfego, não podemos usar nomes sozinhos: é aí que entra o DNS. Basicamente, um cliente pergunta a um servidor DNS *“Qual é o endereço IP deste site?”* e recebe uma resposta contendo esse endereço IP.

![Operação simples de DNS com consulta e resposta](https://www.ictshore.com/wp-content/uploads/2017/01/1020-02-Simple_operation.png)Em suma, o DNS está solicitando o endereço IP dos nomes.

O DNS pode funcionar na **porta UDP 53** (lado do servidor) por padrão, mas também pode usar a porta TCP 53 caso o tráfego passe por um link de baixa qualidade ou caso a resposta contenha muitas informações. O DNS é baseado em duas mensagens, consultas (pelo cliente) e respostas (pelo servidor). Cada computador é configurado com o endereço IP de um servidor DNS e entrará em contato com esse servidor para qualquer consulta DNS que tenha que fazer.

No entanto, a Internet é um lugar enorme e nenhum servidor pode saber tudo sobre ela. Em vez disso, os nomes são divididos em **zonas DNS** , cada zona gerenciada por um conjunto de servidores. Na *raiz da Internet,* temos uma zona chamada *“.” (ponto)* , que é gerenciado pelos servidores DNS raiz, gerenciando o backbone da Internet. Na operação no mundo real, você entra em contato com um deles, que não sabe exatamente qual é o endereço IP do site que está procurando. Em vez disso, ele conhece um DNS mais específico que gerencia esta zona. Em seguida, o cliente entrará em contato com esse outro DNS dinamicamente. Nesse processo, ele será redirecionado *repetidamente e* , eventualmente, entrará em contato com o servidor DNS que conhece as informações sobre o site que procuramos.

![Operação DNS real com redirecionamentos antes da resolução](https://www.ictshore.com/wp-content/uploads/2017/01/1020-03-DNS_Real_operation.png)Uma operação DNS real envolve consultas a vários servidores DNS, geralmente um por zona DNS.

Vamos tirar um momento para explicar a imagem, para que possamos realmente entender este conceito. O cliente entra em contato com o **. (ponto) Servidor DNS** solicitando *mail.ictshore.com* . O servidor não conhece o endereço IP deste site, mas sabe que faz parte da zona .com, por isso informa ao cliente o endereço IP de um servidor que gerencia a *zona .com* . O cliente realiza a mesma consulta ao **servidor DNS .com** , que não sabe exatamente qual é o endereço IP de *mail.ictshore.com* , mas conhece um servidor gerenciando .ictshore.com, então informa ao cliente o IP desse servidor Morada. O cliente tenta novamente, contatando este **servidor DNS .ictshore.com** recém-descoberto .

Desta vez, o servidor DNS conhece o endereço IP do nome de destino, então ele responde com o endereço IP que o cliente estava procurando. Observe que a próxima vez que o cliente iniciar novamente a partir do `.`servidor DNS (ponto) é aquele que ele possui em sua configuração.

A *zona dot DNS* é a raiz da Internet ou nível zero. Então, cada parte que você adiciona adiciona um nível. Por exemplo, `.com`é um *domínio de primeiro nível* , enquanto .ictshore.com é um *domínio de segundo nível* . O nome de um site ou servidor, com todos os seus domínios pai (por exemplo, server1.ictshore.com) é denominado **Fully Qualified Domain Name (FQDN)** .

Outra opção (incomum) é o **DNS recursivo** . Com esta configuração especial, o cliente faz consultas a um servidor DNS que, em vez de redirecionar o cliente para a zona certa, *realiza outras consultas* a outros servidores DNS e, a partir daí, retorna o endereço IP final ao cliente. É difícil encontrar essa configuração no mundo real. Na verdade, você deve evitá-lo por duas razões principais. Primeiro, um invasor pode facilmente sobrecarregar o servidor DNS, pedindo para realizar uma grande carga de trabalho de consultas; em segundo lugar, o servidor pode levar algum tempo para realizar todas as consultas e, durante esse tempo, *o cliente pode expirar* a conexão.

Tanto os servidores DNS quanto os clientes armazenam informações DNS. Especificamente, o cliente DNS apenas se lembra da ligação final entre o nome e o endereço IP e a mantém por minutos ou horas antes de ter que refazer a consulta novamente. O servidor DNS, em vez disso, possui um banco de dados complexo que pode ser comparado a uma tabela com vários registros de diferentes tipos. Um registro DNS pode ser um dos tipos especificados na tabela a seguir.

| ID de tipo | Digite o nome | Descrição                                                    |
| ---------- | ------------- | ------------------------------------------------------------ |
| 1          | UMA           | Este registro é o registro padrão, ele associa um nome a um endereço IPv4. |
| 2          | NS            | Este registro redireciona para outro servidor DNS.           |
| 28         | AAAA          | Este registro associa um nome a um endereço IPv6.            |
| 15         | MX            | Este registro associa um nome a um agente de transferência de mensagem (usado para resolver endereços de e-mail). |
| 5          | CNAME         | Este registro associa um nome a outro nome \, o cliente continuará a fazer consultas para o novo nome retornado. |

Tipos de registro DNS comuns

Existem muitos outros tipos de registro DNS, mas para os fins deste artigo, esses cinco tipos são mais do que suficientes. Geralmente, os servidores DNS não são gerenciados por pessoas que gerenciam a *infraestrutura de rede* : eles são gerenciados por pessoas que gerenciam *servidores de infraestrutura* , portanto, esse conhecimento é o que você precisa para trabalhar com DNS como um técnico de rede.

### DHCP

DHCP significa **Dynamic Host Configuration Protocol** e faz o que o nome diz: configura clientes. Especificamente, DHCP é o protocolo usado para atribuir endereços IP a clientes automaticamente. Além disso, você pode usá-lo para fornecer a eles outras informações úteis para usar a rede (como o gateway padrão ou o servidor DNS). Para este protocolo, o cliente não usa uma porta aleatória ao contrário de outros protocolos. Em vez disso, ele usa a porta **UDP** 68, enquanto o servidor está sempre escutando na **porta 67** .

Um computador configurado para ser um **cliente DHCP** (como quase qualquer computador pronto para usar ) não tem um endereço IP, ele não sabe nada sobre a rede à qual está conectado. Assim, ele envia uma mensagem no broadcast para verificar se existe um servidor DHCP na rede. Nesse caso, o servidor DHCP atribuirá um endereço IP, máscara de sub-rede e gateway padrão ao cliente para que ele possa interagir na rede. Esta é uma *abordagem* muito *flexível* porque se você mover seu PC de uma rede para outra, o endereço IP muda automaticamente. Consequentemente, todos os PCs vêm com DHCP habilitado por padrão como configuração de fábrica.

![Visão geral da operação DHCP, cliente perguntando ao servidor](https://www.ictshore.com/wp-content/uploads/2017/01/1020-04-DHCP_overview.png)Com o DHCP, um cliente pede a um servidor para fornecer um endereço IP válido.

Os endereços obtidos por DHCP não duram para sempre, eles são **alugados** por um período específico (geralmente 24 horas). Nesse intervalo de tempo, o servidor DHCP rastreia a associação de clientes aos endereços IP. Para fazer isso, ele se lembra do *endereço MAC* que emitiu a solicitação. Um cliente que se conecta a uma rede precisa passar por quatro etapas para obter um endereço IP.

Primeiro, o cliente envia um broadcast **DHCP Discovery (D)** para ver se há um servidor na rede disposto a fornecer um endereço IP. Qualquer servidor da rede que queira dar um endereço IP ao cliente responde com uma **Oferta DHCP (O)** , que é sempre enviada em broadcast, contendo um endereço IP oferecido. Neste ponto, os clientes solicitam oficialmente o endereço IP oferecido pelo servidor com um **DHCP Request (R)** . Essa etapa (sempre broadcast = formaliza a solicitação, já que o cliente não está solicitando nenhum endereço IP agora, está solicitando um endereço IP específico. Em seguida, o servidor faz ping nesse endereço IP e se não houver resposta (sempre em transmissão) ) com uma **confirmação de DHCP (A)**. A partir de agora, o cliente pode usar seu novo endereço IP até que o aluguel expire.

![Processo de locação de DHCP (DORA), reconhecimento de solicitação de oferta de descoberta](https://www.ictshore.com/wp-content/uploads/2017/01/1020-05-DHCP_lease_process.png)Um processo de aluguel de DHCP envolve a descoberta do servidor DHCP, sua oferta, uma solicitação oficial e uma confirmação.

Por design, se mais servidores fizerem uma oferta ao cliente, o cliente fará uma Solicitação de Oferta que o cliente **recebeu primeiro** . Outro fato interessante é que se o cliente já possui um endereço IP pode fazer um Discovery especificando o último endereço IP que possuía. Então, se esse endereço IP estiver disponível (ou se já estiver atribuído ao mesmo cliente), o servidor fará uma oferta por esse IP. Em vez disso, se não estiver disponível e o servidor não for autoritativo, o servidor expirará o tempo de descoberta. Se o servidor for **autoritativo** , ele pode negar explicitamente a solicitação. Nesse ponto, o cliente solicitará um endereço IP totalmente novo.

O DHCP vem de um protocolo antigo chamado BOOTP e, sozinho, pode simplesmente nos fornecer um endereço IP, o que não é suficiente. Precisamos saber pelo menos uma máscara de sub-rede e um endereço de gateway padrão para efetivamente originar o tráfego na rede. Além disso, também podemos querer saber o endereço IP de um servidor de nomes para navegar na Internet usando nomes de sites. Para obter todas essas informações extras, devemos configurar o servidor DHCP para fornecer algumas opções. Uma opção é basicamente um identificador numérico associado a um valor (geralmente um endereço IP). Existem toneladas de opções de DHCP padrão e proprietárias, mas vamos verificar as mais importantes.

| EU IRIA | Tamanho   | Descrição                                                    |
| ------- | --------- | ------------------------------------------------------------ |
| 1       | 4 bytes   | Máscara de sub-rede para o cliente                           |
| 3       | 4 bytes + | Endereço IP do roteador padrão                               |
| 4       | 4 bytes + | Endereço IP de um ou mais servidores de horário (NTP) para usar para sincronização de horário |
| 5       | 4 bytes + | Endereço IP de um ou mais servidores DNS                     |
| 12      | 1 byte +  | Nome do host (nome do cliente na infraestrutura DNS)         |
| 15      | 1 byte +  | Nome de domínio (nome da zona DNS da qual o cliente faz parte) |

Opções comuns de DHCP.

Mesmo que um endereço IP tenha 4 bytes, você pode ver que quase todas as opções de endereços IP têm um tamanho de pelo menos 4 bytes, mas podem ter mais. Isso ocorre porque o servidor DHCP pode informar ao cliente vários endereços IP a serem usados para *redundância* .

Agora, suponha que você esteja gerenciando uma infraestrutura de rede para um grande ambiente corporativo. Você deve adquirir um servidor para responder às solicitações de DHCP para cada sub-rede onde você planeja colocar clientes DHCP. Mesmo que os roteadores possam ser servidores DHCP (assim como em casa!), Essa configuração adiciona uma grande carga de administração e é muito descentralizada. Em vez disso, queremos uma implantação centralizada, mas como os clientes podem entrar em contato com um servidor DHCP remoto se eles nem mesmo têm um endereço IP? É aí que o DHCP relay se torna útil. O relé DHCP é uma configuração que você faz em um roteador em uma sub-rede (normalmente é o gateway padrão).

Um roteador com essa configuração ouvirá as solicitações DHCP, as pegará e as colocará em segmentos UDP destinados ao servidor DHCP remoto. Em seguida, o servidor DHCP enviará respostas ao roteador, que os reabrirá e colocará a resposta simples na rede em broadcast, de forma que o usuário nem saiba que o servidor DHCP está remoto. Dessa forma, você pode gerenciar os endereços IP da sua organização de uma maneira melhor. Manter o controle dos endereços em sua organização é o processo de **IPAM (IP Address Management)** . Existem várias ferramentas que permitem fazer IPAM e **DHCP centralizado** em um único servidor.

![Implantação de DHCP centralizada com relés e IPAM](https://www.ictshore.com/wp-content/uploads/2017/01/1020-06-DHCP_centralized_deployment_and_IPAM.png)Em grandes empresas, para oferecer suporte a um sistema de gerenciamento de endereço IP (IPAM), o servidor DHCP é centralizado e as retransmissões em roteadores remotos enviam solicitações aos servidores centrais.

*Como regra de ouro, lembre-se de que o servidor deve sempre estar em sub-redes diferentes das dos clientes. Os clientes devem ter endereços atribuídos por DHCP. Em vez disso, os endereços de servidores e dispositivos de rede devem ser atribuídos manualmente.*

Caso um cliente não consiga obter um endereço de um servidor DHCP, ele obterá automaticamente um **endereço APIPA** do `169.254.0.0/16`gateway padrão sem. Se o seu cliente tem este endereço, algo de ruim aconteceu. Basicamente, você não consegue se comunicar e deve inspecionar sua conexão com a LAN e o servidor DHCP.

### TFTP

TFTP significa **Trivial File Transfer Protocol** , e é um **protocolo** muito simples *(ou trivial?)* Usado para transferir arquivos. Colocamos esse protocolo na seleção de protocolos para a rede por vários motivos. Primeiro, é o usado principalmente para transferir arquivos entre dispositivos de rede. Em segundo lugar, é muito útil durante a configuração inicial desses dispositivos e os telefones VoIP dependem dele. O TFTP é usado principalmente para *baixar logs* ou *enviar o sistema operacional e / ou a configuração* para um dispositivo de rede remoto, como um switch ou roteador.

Ao contrário do FTP, que funciona com dois canais TCP separados (um para controle e outro para dados). TFTP implementa controle e dados em um único canal, que é **baseado em UDP** e usa a **porta 69** (lado do servidor). Cada segmento enviado deve ser confirmado, tornando-o mais lento que o FTP, que aproveita o sistema de confirmação TCP. Outra diferença importante é que você pode usar a mesma sessão de FTP para mover vários arquivos, um após o outro, mas com o TFTP não. Uma sessão TFTP está relacionada a uma transferência de arquivo e é fechada assim que a transferência termina. Como resultado, a transferência de vários arquivos exigirá várias sessões TFTP. Nenhuma versão segura do TFTP existe atualmente.

## Roteamento Dinâmico

As redes modernas são enormes, conectando milhões de dispositivos. Esses dispositivos são organizados em sub-redes e cada sub-rede deve ser capaz de alcançar qualquer outra sub-rede remota. Para tornar isso possível, os roteadores devem saber para onde enviar o tráfego. Para cada sub-rede que eles conhecem, eles devem saber o caminho que o tráfego terá que percorrer para chegar a essa sub-rede. Essas informações são armazenadas em uma parte específica da memória chamada **tabela de roteamento** .

Podemos criar manualmente **entradas estáticas** para colocar na tabela de roteamento. Esta é certamente uma opção para ambientes pequenos com apenas algumas sub-redes. No entanto, em grandes empresas ou provedores de serviços, você terá que lidar com centenas ou mesmo milhares de sub-redes. Ter uma entrada estática para cada um deles se traduz em um grande esforço inicial. A manutenção torna-se um esforço ainda maior: muitas sub-redes significam muitos roteadores. Como resultado, sempre que você fizer qualquer alteração em qualquer sub-rede, *deverá atualizar todos os roteadores* . Além disso, se um link morrer no caminho, todo o tráfego que foi configurado estaticamente para passar por esse caminho será perdido até que o administrador modifique a tabela de roteamento em pelo menos alguns dos roteadores. E se pudéssemos automatizar isso? Bem, *com o roteamento dinâmico podemos*.

**O roteamento dinâmico** significa que os roteadores mantêm de forma autônoma sua tabela de roteamento atualizada. Para fazer isso, eles contam uns com os outros trocando algumas informações. Para trocar informações de roteamento, contamos com **protocolos de roteamento** específicos . Cada protocolo usa seu próprio formato de dados, gerenciado por um algoritmo executado no roteador. Para trocar informações, dois roteadores devem se comunicar com o mesmo protocolo. Em vez disso, se quisermos enviar as informações provenientes de um protocolo para outro protocolo, precisamos de um roteador executando os dois protocolos para fazer isso. Esse processo, chamado redistribuição, é um tópico do CCNP e não vamos nos aprofundar nisso.

![Visão geral dos protocolos de roteamento dinâmico](https://www.ictshore.com/wp-content/uploads/2017/01/1020-07-Dynamic_routing.png)Com o roteamento dinâmico, os roteadores trocam roteadores e descobrem a topologia de maneira autônoma.

Existem várias maneiras de categorizar os protocolos de roteamento. Um deles é baseado no *tipo de informação que trocam* . Com essa categorização, existem três tipos de protocolos de roteamento:

- **Distance Vector** - Este é o tipo de protocolo mais simples. Os roteadores trocam as rotas associadas a um valor chamado *distância* , então o roteador receptor usa a rota com a melhor (menor) distância. Um exemplo de mensagem seria `I can get to 10.1.1.0/24 in 4 hops`. As informações trocadas são recebidas por um roteador, manipuladas (a distância é aumentada) e depois enviadas para outros roteadores. Nesta família de protocolos, podemos encontrar o Routing Information Protocol (RIP) e o Enhanced Interior Gateway Protocol (EIGRP).
- **Link State** - esta família de protocolo é muito mais avançada e consome muitos recursos. Isso ocorre porque esses protocolos mantêm instâncias de banco de dados e trocam registros. Em vez de trocar informações sobre rotas, eles trocam informações sobre links, como `I am Router 1, and I am connected to Router 2`. Essas mensagens são encaminhadas da forma que estão para todos os roteadores que executam o protocolo, sem qualquer manipulação. Então, cada roteador será capaz de criar um mapa da rede com base nessas informações. Com essa imagem em mente, o roteador criará sua própria tabela de roteamento. Esta família de protocolo reage às mudanças de rede muito mais rápido do que Distance Vector. Nesta família, podemos encontrar o Open Short Path First (OSPF) e o Intermediate System to Intermediate System (IS-IS).
- **Path Vector** - Esta família contém um único protocolo, o Border Gateway Protocol (BGP). Este protocolo é usado para trocar informações de roteamento entre redes gerenciadas por diferentes entidades. Você pode usar o BGP para trocar informações com seu provedor de Internet, e os provedores conversam entre si usando o BGP. Este é o único protocolo para este fim e define o funcionamento desta categoria. O BGP conta a distância com base no número de redes (e não de roteadores) que o tráfego percorre. O BGP está fora do escopo do curso CCNA, pois faz parte do currículo CCNP.

### Conclusão

Com este artigo, descobrimos alguns dos protocolos mais importantes que nos permitem usar a Internet da maneira que fazemos, mesmo sem perceber. Também alcançamos o topo do OSI. Agora, aprendemos tudo o que precisamos para começar a mergulhar no campo. Reserve um momento para revisar os artigos do curso CCNA até este. Depois disso, iremos colocar as mãos em dispositivos de rede, configurando switches e roteadores!