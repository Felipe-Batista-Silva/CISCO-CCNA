# Dispositivos de interconexão: a topologia da rede



Conectar dispositivos não é simplesmente passar cabos de um dispositivo para outro, você tem que saber o que está fazendo. Todos os dispositivos em uma rede e a maneira como eles são conectados formam a **topologia** da **rede** , o tópico deste artigo. Aprenderemos quais são as topologias de rede possíveis, quais são suas diferenças e como mudar de uma topologia para outra pode modificar completamente a maneira como nossa rede funciona. Com esse conhecimento, você estará pronto para escalar a pilha OSI facilmente.

## Topologia de rede em um relance

As topologias de rede podem ser definidas como o mapa de uma rede, mas a definição formal é a seguinte.

> Uma topologia de rede é a representação de links entre os nós de uma rede.

Isso pode parecer muito formal, à primeira vista, e provavelmente é, mas uma vez que esclarecermos o conceito de **nó** e **link,** você realmente entenderá esta definição. Um nó é qualquer dispositivo que pode ser conectado a uma rede: não importa como ele pode ser conectado (com um cabo, em Wi-Fi e assim por diante), mas desde que seja capaz de se comunicar com o resto do a rede é considerada um nó. Um computador desktop é um nó, mas também um roteador, um smartphone, um laptop ou um switch. Até mesmo dispositivos de casa inteligente, como geladeiras conectadas ou lâmpadas, são considerados nós se puderem se comunicar em uma rede.

![Um nó pode ser ...](https://www.ictshore.com/wp-content/uploads/2016/10/1011-01-Node_could_be.png)Um nó pode ser praticamente tudo: um PC, um roteador, um smartphone, um laptop, um switch, uma geladeira ou uma lâmpada.

O nó é qualquer dispositivo. O **link** , em vez disso, é qualquer tipo de conexão que permite que dois dispositivos conversem. Um cabo coaxial é considerado um link, mas também um cabo Ethernet ou um cabo de fibra óptica. Mesmo uma conexão sem fio é considerada um link. Então, resumindo, *um nó é qualquer dispositivo* , *um link é qualquer conexão* . A topologia é a combinação de ambos, é um desenho onde os links (desenhados como linhas) conectam os nós. A maneira como essa conexão acontece pode mudar muitas coisas.



A primeira coisa que é influenciada pela topologia da rede é o caminho que seus dados terão que percorrer ao passar de um dispositivo para outro. Mesmo que pareça trivial para você, pare um momento para pensar sobre isso. Há muitas coisas envolvidas, que vão muito além da simples entrega das informações para o outro nó. Por exemplo, se forçarmos o tráfego em um determinado caminho previsível, podemos fazer algo nesse caminho para filtrar ou analisar o tráfego (bloquear sites maliciosos, limitar o acesso às redes sociais durante o horário comercial ...). Para fazer isso, devemos conhecer a topologia da rede. Dê uma olhada nos dois casos a seguir. Eles são muito importantes para se ter uma compreensão geral de como funciona a rede.

No primeiro caso, os nós podem se comunicar diretamente entre si. A razão para isso é que eles estão conectados todos no mesmo link, e esta é uma regra geral: *nós no mesmo link podem se comunicar diretamente* . Isso é conhecido como **acesso direto** , e há uma topologia específica para isso, conhecida como barramento: em uma **topologia de barramento** , todos os nós estão conectados ao mesmo link.

![Acesso direto](https://www.ictshore.com/wp-content/uploads/2016/10/1011-02-Direct_access.png)Os três nós na imagem estão conectados ao mesmo link, então o tráfego pode fluir diretamente de um nó para qualquer um dos outros dois.

Essa solução tem algumas desvantagens que veremos quando falarmos especificamente sobre a topologia do barramento, mas o ponto é que os dispositivos podem se comunicar diretamente com seus destinos. Em vez disso, se os dispositivos não compartilharem o meio de comunicação (link), eles ainda poderão se comunicar, mas o tráfego terá que passar *por outro dispositivo* (ou mais!). Isso não é um problema, mas é algo a ser considerado. Por exemplo, esse dispositivo pode ser nosso aparelho destinado a fazer filtragem de tráfego (um firewall ou um proxy embutido) ou pode ser um dispositivo que se destina apenas a encaminhar informações em nome de outros dispositivos (um roteador ou switch), neste caso , é conhecido como um **dispositivo intermediário** .

![Dispositivo intermediário](https://www.ictshore.com/wp-content/uploads/2016/11/1011-03-intermediary_device.png)O nó central é um dispositivo intermediário que passa informações entre os outros nós.

Com esses dois exemplos, é mais fácil entender como a maneira como os dispositivos são conectados *muda* a maneira como eles interoperam. Este é o principal motivo que torna o estudo das topologias de rede tão importante. Nas seções a seguir, continuaremos a falar sobre a topologia de barramento, ou mídia compartilhada, para passar para as topologias estrela e hierárquica, terminando finalmente com malhas.

## Mídia compartilhada

Em uma topologia de mídia compartilhada, os nós são conectados pelo **mesmo link** ou mídia. Hoje, esse link será o ar para as conexões sem fio, mas, no passado, costumava ser uma implementação especial de um cabo coaxial para conectar vários dispositivos. O símbolo de uma mídia compartilhada (um cabo terminado em ambas as extremidades) vem desse cabo coaxial, que precisava de terminações específicas nas extremidades para absorver o sinal, caso contrário, ele teria sido refletido de volta para o cabo criando interferências (é por isso que o *T -forma* ).

![Mídia compartilhada](https://www.ictshore.com/wp-content/uploads/2016/10/1011-04-Shared_media.png)A mídia compartilhada é um link que conecta vários dispositivos juntos.

A primeira coisa que notamos é que o design é extremamente simples. É apenas um cabo! Além disso, tudo o que um dispositivo “diz” no cabo é ouvido de todos os outros nós, portanto, é fácil de se comunicar. No entanto, isso causa um problema: a comunicação não pode se sobrepor, portanto, se um nó estiver se comunicando, nenhum outro nó deve estar se comunicando. Em outras palavras, apenas **um único dispositivo pode estar falando** em um determinado momento, e isso reduz drasticamente a escalabilidade porque quanto mais dispositivos na rede, mais você terá que esperar. Porém, não temos alternativa a não ser compartilhar o ar entre os dispositivos quando se trata de wireless, então se este problema não puder ser resolvido (como no caso do Wi-Fi), devemos tentar encontrar algumas técnicas para mitigá-lo.

Essas técnicas foram desenvolvidas na forma de algoritmos, programas que rodam em cada nó, e que controlam como ele pode interagir com o dispositivo. Dois ramos principais do algoritmo foram desenvolvidos ao longo dos anos, **Carrier Sense Multiple Access (CSMA)** e **Token Ring** . Com o CSMA, os dispositivos ouvem o que está acontecendo na mídia compartilhada e decidem se podem conversar, com base nisso. Com um token ring, um token virtual é passado entre dispositivos e apenas o dispositivo com o token tem permissão para falar. Vamos ter uma visão geral completa dessas técnicas.

O branch CSMA é o branch do algoritmo que usamos hoje, o *verdadeiro líder* da cena. Isso ocorre porque é ele que *maximiza a taxa* de *transferência* dessa mídia compartilhada. Isso é possível porque os dispositivos decidem de forma **autônoma** se devem falar ou não, e os dispositivos que têm algo a dizer podem falar quase imediatamente. CSMA vem em dois sabores, **detecção de colisão (CSMA / CD)** e *prevenção de colisão (CSMA / CA)*. A versão “Avoidance” é um pouco mais sofisticada e é usada para transmissão sem fio. Por enquanto, vamos nos concentrar no mais básico, o algoritmo de detecção de colisão. A lógica por trás desse algoritmo é extremamente simples, como na figura: ouça o que está acontecendo na mídia e fale assim que ninguém mais estiver falando.

![CSMA / CD](https://www.ictshore.com/wp-content/uploads/2016/10/1011-05-CSMA_CD.png)No CSMA / CD, os dispositivos aguardam silenciosamente até que o dispositivo que está conversando no momento termine antes de poderem falar.

A situação na imagem é simples: tanto o Nó A quanto o Nó B querem conversar, mas o Nó C já está falando, então eles terão que esperar. O verdadeiro problema acontece quando o nó C para de falar, tanto A quanto B começarão a falar simultaneamente, fazendo com que os sinais se sobreponham e, no final, interrompendo a comunicação. Portanto, algo mais deve ser implementado para resolver esse problema específico. Uma vez que ninguém mais está falando (a mídia compartilhada está ociosa), o nó espera silenciosamente um *tempo de 96 bits*, o tempo necessário para transmitir 96 bits de informação. Então, se o canal ainda estiver ocioso, ele começa a enviar o sinal. Ao enviar as informações, o nó continua a monitorar a mídia e presume que a entrega foi bem-sucedida apenas se não ouvir mais nada enquanto estiver enviando as informações. Se, em vez disso, ele detectar uma colisão, ele interromperá a transmissão imediatamente e enviará um sinal especial de 48 bits (o sinal de interferência) para notificar os outros nós de que uma colisão acabou de acontecer. Se a transmissão for ruim e uma colisão for detectada, os nós de transmissão que detectaram a colisão aguardarão um período de tempo aleatório antes de iniciar o processo novamente. Isso deve ser aleatório para evitar que as duas estações tentem se sobrepor exatamente da mesma forma na próxima vez,com um temporizador aleatório, um atraso mínimo pode ser criado para evitar exatamente isso: este processo é tratado pelo**algoritmo de recuo** . Se você é um programador, achará interessante o *pseudo-código para CSMA / CD* apresentado a seguir.

enquanto ( **verdadeiro** )   

  **if** ( hasSomethingToTransmit () )   

​    **while** ( mediaIsBusy () ) ;    

​    espera ( 96bit_time ) ;

​    **if** ( mediaIsIdle () )   

​      transmitir ()

​      **enquanto** ( transmitindo () )   

​        **if** ( colisão () )   

​           jamSignal ()

​           esperar ( aleatório () )  

Com CSMA / CD, se a mídia estiver ociosa, qualquer dispositivo que desejar pode transmitir. Isso maximiza o uso da mídia, fornecendo a melhor taxa de transferência para os nós conectados. No entanto, também existe uma tecnologia legada que foi usada para permitir que os nós conversem por meio de mídia compartilhada. Chama-se **Token Ring** e foi desenvolvido originalmente para **topologias circulares** , onde cada nó é conectado ao anterior e ao próximo, e o nó final é conectado ao primeiro, criando um anel fechado. A lógica por trás disso é que é muito simples, os nós elegem um nó "mestre" que *gera um token*, então esse nó envia o token para o próximo nó e, se tiver algo para transmitir, envia também. As informações neste processo podem ser comparadas a um trem, onde o token é sempre o primeiro *vagão* ou locomotiva, e a informação é o segundo vagão. O próximo nó fará a varredura dos vagões de informação e se encontrar um ou mais vagões destinados a si mesmo, ele os tirará do trem. Em seguida, ele anexará o que precisa enviar e empurrará o trem de informações para o próximo nó, e assim por diante. Para simplificar, com esta tecnologia, *apenas o nó que atualmente tem o token pode falar*. Se isso foi implantado originalmente para anéis, também pode ser aplicado a mídia compartilhada, com a vantagem de não haver necessidade de fazer coisas complicadas com trens e vagões porque, quando um nó está tomando conta, todos os nós estarão ouvindo imediatamente.

![Token Ring](https://www.ictshore.com/wp-content/uploads/2016/11/1011-06-Token_ring.png)Com um token ring, apenas o nó com o token pode falar. Depois de enviar as informações, ele também deve passar o token para o próximo nó, e assim por diante.

Como a imagem destaca, se um nó não tem nada a dizer, ele sempre deve passar o token para seu próximo nó. Esta abordagem não pode otimizar o uso da mídia, pois as concessões para falar são distribuídas igualmente, de forma que se um nó tiver muito mais informações para enviar enquanto os outros não têm nada a dizer, então o nó com mais informações terá que esperar, enquanto o outro obterá o token sem necessidade, *desperdiçando tempo e taxa de transferência* . Devido à **falta de flexibilidade** dessa tecnologia, o token ring não é mais usado, mesmo que algumas peças de hardware ainda o suportem.

Em ambas as abordagens, CSMA / CD e Token Ring, um único dispositivo pode falar por vez: quando esse dispositivo está falando, todos os outros precisam ouvir e não podem falar. No entanto, mais tarde, o dispositivo que estava falando originalmente estará ouvindo, enquanto outro dispositivo fará a conversa. Esse tipo de transmissão tem um nome, *half-duplex* . Isso, junto com simplex e *full-duplex* , é um tipo de transmissão, como explica a lista a seguir.

- **Simplex** - as informações podem fluir em uma única direção (como "De A para B, mas não de B para A")
- **Half-duplex** - as informações podem fluir em ambas as direções, mas não simultaneamente
- **Full-duplex** - as informações podem fluir em ambas as direções simultaneamente

É fácil adivinhar: o melhor é *full-duplex* . Felizmente, as redes modernas são completamente full-duplex, mas chegar a esse ponto na implantação técnica não foi tão fácil. Originalmente, a mídia compartilhada era um cabo coaxial instalado na parede de um escritório, com computadores conectados a esse cabo. A próxima etapa foi *concentrar* essa mídia compartilhada com o hub. Um **hub** é um *dispositivo legado ao* qual todos os computadores podem se conectar e que não possui nada além de uma mídia compartilhada. A melhoria é, no entanto, que os hubs funcionam com *cabos Ethernet (RJ45)*e que desta forma você centraliza o ponto onde os computadores se conectam ao resto da rede. Em vez de ter um cabo para todos os escritórios, você tem um cabo por computador, indo do computador ao hub. Dessa forma, uma falha em um cabo desconectará apenas um único computador e se o hub falhar, *ele será substituído facilmente* (não é necessário remover todo o cabo).

![Eixo](https://www.ictshore.com/wp-content/uploads/2016/11/1011-07-Hub.png)Um hub é simplesmente um dispositivo com os circuitos internos fazendo uma mídia compartilhada.

Com o hub, você melhorou algumas características físicas da rede, mas ainda tem comunicação half-duplex. A evolução do hub é o **switch** , e ele é capaz de suportar *transmissão full-duplex* entre qualquer par de nós conectados. Este dispositivo será explicado no artigo dedicado à camada de enlace, por enquanto basta saber que o switch é o caminho a percorrer para ter uma transmissão full-duplex. Agora, em vez disso, é hora de enfrentar algumas outras topologias disponíveis em uma implantação de rede.

## Estrela e Hierárquica

Agora é hora de falar sobre as topologias mais populares em redes Campus (como um lembrete, a rede campus é aquela que atende os dispositivos dos usuários, como laptops e smartphones). Mas essas duas topologias, estrela e hierárquica, são as melhores práticas para serem usadas também em data centers (conectando servidores). Em outras palavras, no momento eles são a melhor escolha na maioria dos casos. Vamos começar com a **estrela** , que é bastante simples: todos os dispositivos se conectam a *um único dispositivo no centro* .

![Topologia em estrela](https://www.ictshore.com/wp-content/uploads/2016/11/1011-08-Star_topology.png)Nessa topologia em estrela, toda origem de tráfego de qualquer nó e destinada a qualquer outro nó deve necessariamente passar pelo Nó A, o ponto central.

O principal benefício de uma topologia em estrela está relacionado ao **gerenciamento e controle centralizados** . Como todo o tráfego passa pelo Nó A, podemos aplicar uma política para restringir alguns usuários de alcançar alguns outros dispositivos na rede, podemos filtrar e inspecionar o tráfego para permitir ou negar alguns aplicativos específicos e podemos gerenciar a infraestrutura geral do Ponto central. Se fôssemos *anexar Internet* a esta topologia, provavelmente a anexaríamos no Nó A. Desta forma, colocamos na posição que é *igualmente acessível de todos os nós*(todos os nós precisam atravessar um link e então estão no Nó A e, portanto, na Internet - em qualquer outro nó, qualquer um, exceto aquele nó, precisaria atravessar dois links). O problema com esse design é que, se o Nó A falhar, todos os outros nós serão desconectados e isolados. Isso pode ser resolvido adicionando dois nós centrais que funcionam igualmente, mas essa é uma tecnologia que ainda não estamos prontos para enfrentar. Trabalhando com essa topologia, lembre-se que os nós externos geralmente são *dispositivos finais* (computadores, servidores, etc.), enquanto o nó central é um *dispositivo intermediário* (hub, switch, roteador, etc.).

A evolução da topologia em estrela é a **topologia hierárquica** , que é *uma estrela de estrelas* . Na verdade, a topologia em estrela é uma topologia hierárquica em si, porque - por definição - uma topologia hierárquica é uma topologia onde o tráfego flui entre nós folha passando por um ou mais nós centrais. A foto lhe dará uma ideia melhor disso.

![Topologia hierárquica](https://www.ictshore.com/wp-content/uploads/2016/11/1011-09-Hierarchical_topology.png)Em uma topologia hierárquica, existem muitos nós folha conectados a nós centrais. Por exemplo. O Nó F pode se comunicar com o Nó H apenas por meio do Nó C e com o Nó D apenas por meio de C, A e B.

Como você pode ver na imagem, esse tipo de topologia se parece muito com uma árvore de cabeça para baixo. E isso é tão verdade que nós externos são chamados de **nós folha** : nós que possuem apenas uma única conexão. Os nós folha são conectados a um nó, que então é a folha de outro nó, que então é a folha de outro nó e desta forma até o nó central, conhecido como **raiz**. Esta é a topologia mais usada porque é flexível e escalonável. Para falar um com o outro, o tráfego entre os nós deve fluir até o primeiro nó central que os dois nós folha têm em comum e então voltar para o destino. Como exemplo, na imagem anterior, o tráfego de D para E irá para B, enquanto o tráfego de D para H irá para B, então para A, então para C e finalmente para H. Para explicar melhor a topologia, os nós têm foi categorizado em camadas. Os nós folha, dispositivos finais, ocupam as camadas inferiores, que podem ser assumidas como a *camada zero* . Então, os primeiros dispositivos intermediários que encontramos (B e C, neste caso) são a *camada um* , enquanto A é a *camada dois* . Pode haver também uma *terceira camada*se houver mais dispositivos, mas esteja ciente de que essas camadas não têm nada a ver com as camadas OSI. Eles não estão relacionados de forma alguma.

Como vantagem dessa topologia, ainda temos **gerenciamento e controle centralizados** . Nesta topologia, se algum nó que não seja folha (camada um ou mais) falhar, outros dispositivos serão desconectados, mas isso não interromperá toda a topologia, ele será **segmentado** (dividido). Isso é verdadeiro mesmo se o nó raiz falhar. Agora, os nós não têm portas infinitas para conectar cabos, então você não pode conectar dispositivos infinitos ao mesmo dispositivo central, então uma topologia hierárquica de várias camadas é muito mais escalável (que pode ser expandida no futuro) do que uma topologia em estrela, que pode ser considerada uma topologia hierárquica de camada única. Mesmo assim, podemos criar um par de dispositivos centrais para manter as funcionalidades normais, mesmo quando um dispositivo central falha. Por essas razões, esta topologia é certamente*a melhor escolha* .

## Malhas

À primeira vista, as malhas parecem topologias aleatórias. E se você não sabe as razões por trás deles, eles na verdade são **aleatórios** para você. Uma malha é uma topologia em que um nó é conectado a um ou mais outros nós, de forma que pelo menos um caminho exista entre dois nós dados. Existem dois tipos de malhas, a malha completa e a malha parcial. Na **malha completa** , cada nó é conectado a todos os outros nós da topologia. Isso adiciona confiabilidade à rede porque, mesmo se um, dois ou mais links ou nós falharem na rede, outros nós ainda terão uma maneira de se comunicar. No entanto, essa configuração é extremamente cara e difícil de gerenciar (cada vez que você adiciona um nó, você terá que conectar todos os outros nós).

![Malha completa](https://www.ictshore.com/wp-content/uploads/2016/11/1011-11-Full_mesh.png)Em uma topologia de malha completa, todos os nós têm um link direto com os outros.

Algo que parece de alguma forma um *compromisso* é a **malha parcial** , onde cada nó é conectado a vários nós, mas não necessariamente a todos os outros (ao contrário da malha completa). De modo geral, os dispositivos cruciais serão aqueles que terão mais links para que possam ser conectados mesmo após falhas de link.

![Malha parcial](https://www.ictshore.com/wp-content/uploads/2016/11/1011-10-Partial_mesh.png)Em uma topologia de malha parcial, cada nó está conectado a um ou mais dos outros, mas não há um link direto entre TODOS os nós, apenas entre alguns deles.

Malhas (completas quando possível, caso contrário parciais) são usadas principalmente no ambiente do **Provedor de Serviços** , para interconectar sites a quilômetros de distância. As conexões entre cidades e países são principalmente malhas parciais, mas isso não se limita à rede dentro do provedor de serviços. Em vez disso, isso também é verdade para a conexão entre dois provedores de serviço diferentes: se você olhar para toda a rede do provedor junto e imaginar que cada rede de cada provedor é um único nó, verá uma malha parcial. Os benefícios das malhas incluem o uso de um caminho direto (use um único link) quando disponível, enquanto usa um caminho com vários links quando um direto não está disponível (como em malhas parciais). A principal desvantagem, em vez disso, é o custo mais alto: pense em quanto custaria para funcionar*mais um cabo submarino* entre Londres e Nova York.

## Topologias de camada 2 e camada 3

Camadas OSI e topologias de rede são tópicos relacionados e, nesta seção, explicaremos por quê. As camadas OSI definem em que nível trabalharemos: a primeira camada é para as pessoas que trabalham com componentes físicos como hardware e cabos, enquanto a sétima camada é para as pessoas que trabalham com aplicativos. Em outras palavras, as camadas OSI definem o **nível de detalhe** da rede. Quanto mais baixo for o nível, maiores serão os detalhes (mas quanto menor for a imagem), quanto mais alto for o nível, menos detalhes (mas quanto maior for a imagem).

Agora, pense nas topologias de rede de uma maneira diferente. Pense que os *links são divididos entre si por dispositivos* . Dependendo do nível da topologia, você terá alguns dispositivos incluídos implicitamente em um link. Em outras palavras, quando em uma topologia você representa um link, não significa necessariamente que é apenas um cabo ou uma rede sem fio, pode ser também um conjunto de cabos e dispositivos. Os parágrafos a seguir explicam isso em detalhes; eles são seguidos por uma topologia de rede. A rede representada é sempre a mesma, mas o nível de detalhes muda em cada topologia.

Em uma **topologia da Camada 2** , cada dispositivo trabalhando na Camada 2 do OSI (Link de Dados) e acima deve ser representado. Basicamente, qualquer dispositivo deve ser representado neste tipo de topologia, exceto repetidores e conversores. Esta topologia é usada para exibir como os dispositivos estão fisicamente conectados uns aos outros.

![Topologia da camada 2](https://www.ictshore.com/wp-content/uploads/2016/11/1011-L2-topology.png)Em uma topologia da camada 2, os dispositivos de rede que trabalham na camada 2 (como o switch central) devem ser representados.

Em uma **topologia da Camada 3** , cada dispositivo trabalhando na Camada 3 do OSI (Rede) e acima deve ser representado: esses dispositivos são roteadores, firewalls, computadores e assim por diante. Switches, pontes e hubs não são representados, mas, em vez disso, incluídos implicitamente nos links. Como você pode imaginar, a camada de rede é a mais importante, já que somos engenheiros de rede, e esse tipo de topologia é o que costumava ter uma visão geral lógica da rede e entender o caminho que as informações devem percorrer para atravessar a rede.

![Topologia da camada 3](https://www.ictshore.com/wp-content/uploads/2016/11/1011-L3-topology.png)Em uma topologia da camada 3, os dispositivos intermediários, como switches, bridges e hubs, não são representados, mas incluídos nos segmentos de rede (o tubo azul no meio).

No *OSI Layer 4 (Transport)* e acima, não temos mais topologias. Isso ocorre porque essas camadas simplesmente não se importam com a rede e o caminho subjacentes, portanto, apenas representamos **túneis** : conexões lógicas entre *dispositivos e / ou aplicativos* . Esses tipos de desenhos são usados especificamente para *fins de segurança* para representar que tipo de tráfego deve ser permitido e que tipo de tráfego deve ser bloqueado.

![Topologia da camada 4](https://www.ictshore.com/wp-content/uploads/2016/11/1011-14-L4-topology.png)Ao representar um túnel, qualquer coisa abaixo disso pode ser omitido e representado como uma nuvem.

Com este artigo, descobrimos as topologias em rede. Esses conceitos são cruciais para se ter um grande entendimento de como as coisas funcionam em um ambiente de TIC. Ter um mapa da rede - a topologia - torna tudo mais fácil, porque sabemos como contornar, sabemos o que está acontecendo. Com isso em mente, estamos prontos para enfrentar as camadas fundamentais da pilha OSI, link de dados e rede. Mas isso é para outro artigo.