# Camada de rede: endereçamento IPv6 e protocolo IPv6



O IPv4 ainda é o rei da camada de rede, mas *a necessidade de um protocolo moderno que* reflita as necessidades dos aplicativos modernos está ficando cada vez maior. Como engenheiro de rede, você deve saber como funciona o IPv6 e por que foi projetado dessa forma, pois o futuro está cada vez mais próximo e é melhor se preparar para ele. Este é o objetivo deste artigo, dar a você uma visão geral desse protocolo, sua lógica e explicar quais melhorias o tornam melhor do IPv4. Com esse conhecimento sólido, você estará pronto para configurar os dispositivos de rede para oferecer suporte à nova versão do protocolo da Internet. Para fazer isso, é hora de aprender como funciona o **endereçamento IPv6** .

## IPv6 supera os limites do IPv4

Pense no quanto o mundo mudou nos últimos quarenta anos. Mais do que isso, pense no quanto a tecnologia evoluiu nesse intervalo de tempo. Fizemos muitas melhorias em todos os campos de tecnologia, de carros a casas, da cadeia de produção à saúde. Em suma, *tudo mudou* , e isso por um motivo: nossas necessidades mudaram. Mais do que isso, nossas necessidades estão sempre mudando, e essa é a razão por trás da necessidade de um novo protocolo de Internet. O IPv4 foi projetado no final dos anos setenta e, como ainda o usamos em 2016, significa que é bastante funcional. No entanto, a forma como o usamos mudou ao longo dos anos, de modo que em 1994 começamos a desenvolver o IPv6, *sabendo que o IPv4 não duraria para sempre* . Vamos ver por quê.



O protocolo da Internet é projetado para fornecer um endereço aos dispositivos e permitir a comunicação remota entre eles. No entanto, nos anos setenta, os dispositivos que precisavam se comunicar eram poucos. Apenas alguns supercomputadores e servidores estavam conectados à Internet. No entanto, o IPv4 foi projetado para suportar o crescimento de dispositivos conectados à Internet. Os dispositivos continuaram a crescer exponencialmente e, em algum ponto, percebemos que não podíamos mais desperdiçar endereços IP: então, mudamos do endereçamento classful para o endereçamento classless ( [saiba mais em nosso artigo IPv4](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-addressing/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) ). Dessa forma, atrasamos vários anos a transição, mas a partir de agora, as coisas conectadas à Internet já passaram os endereços IPv4 disponíveis, por diversos fatores. Primeiro, temos **mais dispositivos**do que antes, como smartphones, laptops e tablets. **A Internet das Coisas (IoT)** é uma tecnologia em crescimento em que praticamente tudo tem um endereço IP, *de geladeiras a carros* ; e usamos conexões de **banda larga com a Internet** que estão sempre ativas, então precisamos de endereços IP 24 horas por dia, 7 dias por semana.

![Endereços IPv4 acabando](https://www.ictshore.com/wp-content/uploads/2016/12/1015-01-IPv4_address_run_out.png)Em 2012, as coisas conectadas à Internet dobraram os endereços IPv4 disponíveis em todo o mundo.

Embora a falta de endereços IPv4 seja provavelmente o motivo mais importante para ter um novo sistema de endereçamento, o IPv4 tem várias **limitações** que podemos superar agora com o IPv6:

- **Marcação de prioridade** - Muitas aplicações modernas requerem *tráfego em tempo real* , como Voice over IP ou Video Streaming, e este tráfego tem que viajar pela rede antes de mais nada, para permitir que a aplicação seja em “tempo real”. Com o IPv4, temos a possibilidade de marcar um tráfego especial como aquele com uma prioridade, mas este complexo não é muito prático, pois temos que verificar e marcar cada um dos pacotes.
- **Endereçamento ponta a ponta** - para adiar a escassez de endereços IPv4, depois de adotar um sistema de endereçamento sem classes, começamos a usar a *tradução de endereços de rede* para converter vários endereços IPv4 privados em um único ou em alguns endereços IPv4 públicos: isso resulta na troca de endereços o caminho, e o remetente e o destinatário não sabem o endereço IP “verdadeiro” um do outro. Isso pode ser um problema para alguns aplicativos de segurança.
- **Espaço de endereçamento** - Como já dissemos, o IPv4 não pode oferecer tantos endereços quanto precisamos agora.
- **Configuração de cliente simples** - Para configurar um endereço IPv4 em um cliente (dispositivo do usuário final), você deve colocá-lo manualmente na configuração do dispositivo ou depender de um servidor nessa sub-rede ( *um servidor DHCP* ), não há maneira automática de criar um endereço IP.

![Limitações de IPv4 e benefícios de IPv6, marcação de prioridade, endereçamento ponta a ponta, espaço de endereçamento e configuração simples de cliente](https://www.ictshore.com/wp-content/uploads/2016/12/1015-02-IPv4_limitations.png)O IPv4 carece de vários recursos extras que estão disponíveis no IPv6 e são exigidos pelos aplicativos modernos.

Agora que sabemos as razões por trás da criação deste novo protocolo, é hora de apresentar o *Internet Protocol versão 6* com todos os seus recursos e características: vamos dar uma olhada na próxima seção.

## Endereçamento IPv6: prefixos e endereços

Assim como na versão anterior, o IPv6 funciona com endereços. No entanto, na versão 4, um endereço tem 32 bits, enquanto no IPv6 tem **128 bits** . Isto significa que temos 2 128 possíveis endereços (o número é 340.282.366.920.938.463.463.374.607.431.768.211.456 e lê-se como *340 undecillion* ). Este é um número enorme, e representá-lo em notação pontilhada seria longo e difícil de ler: em vez de quatro números em notação pontilhada, teríamos 16 números. Então, mudamos *a forma como representamos* o endereço.

Um **endereço IPv6** é representado em blocos de quatro *dígitos hexadecimais* , com colunas para dividir cada bloco do próximo. Um único dígito hexadecimal pode representar quatro bits, então cada bloco representará dois bytes (16 bits). Assim, reduzimos o número de blocos de 16 para 8, mas podemos fazer algo mais. Em endereços IPv6, é muito provável que você encontre vários zeros, já que o espaço de endereçamento é muito maior do que o que precisamos hoje, então você vai escrever blocos inteiros de zeros. Felizmente, os *zeros à esquerda em cada bloco podem ser omitidos* . Dessa forma, temos um endereço bastante compacto, mas podemos fazer muito melhor. Se você tiver vários blocos consecutivos que valem zero, você pode representá-los como *um único bloco vazio*(duas colunas consecutivas). Obviamente, isso pode ser feito apenas uma vez, porque se você fizer isso duas vezes no mesmo endereço, não saberá como expandir o endereço para seu estado “normal”. Então, agora temos um endereço extremamente compacto: dê uma olhada na foto abaixo.

![O endereço IPv6 em notação redefinível por humanos, podendo ser omitidos os blocos nulos iniciais e consecutivos](https://www.ictshore.com/wp-content/uploads/2016/12/1015-03-IPv6_addresses.png)Um endereço IPv6 pode ser representado de forma compacta, omitindo alguns zeros, conforme descrito.

É importante lembrar que podemos reduzir e compactar a forma como representamos um endereço IPv6 por uma questão de legibilidade, mas não podemos realmente reduzir a forma como ele é armazenado na memória do computador: ele sempre ocupará 128 bits e será tratado como *um número de 128 bits* . Pensando nisso, sabemos que os endereços IPv4 podem ser divididos em três partes: os primeiros bits são para o principal, os do meio são o ID da sub-rede e os últimos são o ID do host. O IPv6 é um pouco diferente porque não temos mais majors. Em vez disso, o endereço é dividido em duas partes iguais: os primeiros 64 bits são o **prefixo** da **rede** e os últimos 64 bits são a **ID** da **interface** .

![Formato de endereço IPv6, 64 bits de prefixo de rede e 64 bits de ID de interface](https://www.ictshore.com/wp-content/uploads/2016/12/1015-04-IPv6_address_format.png)O formato do endereço IPv6 é simples e inclui apenas um prefixo de rede e um ID de interface.

O prefixo da rede pode ser comparado ao *ID da sub-rede IPv4* , ele representa um grupo de endereços IPv6. O ID da interface é muito semelhante ao *ID do host IPv4* , mas com uma diferença simples no conceito. Com a versão 4, estávamos acostumados com o fato de que os endereços IP eram relacionados ao host, mas a verdade é que um endereço IP está relacionado à *interface de rede (NIC)* e, se um host tiver vários NICs, pode ter vários endereços. Esse *erro estético* também foi corrigido com o IPv6. Mais do que isso, no IPv6 não temos máscaras de sub-rede, mas apenas uma **notação do tipo CIDR** (notação de barra) para indicar o quanto efetivamente é longo o prefixo da rede, que geralmente é **/ 64** .

Você pode imaginar que quem está lhe dando um endereço IP, neste caso, um endereço IPv6, é o seu Provedor de Internet. Isso é totalmente correto, mas de onde os provedores obtêm endereços? Vamos mudar o ponto de vista, começando de cima em vez de embaixo. O *Internet Architecture Board (IAB)* e a *Internet Corporation for Assigned Numbers (ICANN)* projetam a Internet e então delega a **Internet Assigned Numbers Authority (IANA)** para distribuir endereços em todo o mundo. No entanto, a IANA não fornece endereços diretamente aos provedores, mas sim aos cinco **Registros Regionais da Internet (RIRs)** . Cada RIR administra a atribuição de endereços IP para uma região: *AfriNIC* cobre a África, *APNIC*é o da Ásia-Pacífico, *ARNIC* é para a América do Norte, *LACNIC* cobre a América Latina e Caribe e *RIPE NNC* é o responsável pela Europa. São eles que atribuem endereços a Provedores de Internet (ou grandes empresas), enquanto o ISP dá endereços a clientes finais. Lembre-se de que você só pode obter seu próprio endereço de um RIR, porque de um provedor você só pegará emprestado um endereço do espaço de endereçamento do ISP. Dado que, para IPv6, IANA dá prefixos de rede com tamanho indo de **/ 19 a / 32** para RIRs, e eles então atribuem espaço de endereçamento em blocos de **/ 48 a / 56** para ISPs. O cliente final deve obter exatamente um **prefixo / 64**, mas nem sempre é verdade, portanto, prefixos ainda menores podem ser atribuídos ao usuário final.

![Atribuição de endereçamento global IPv6, da IANA aos clientes](https://www.ictshore.com/wp-content/uploads/2016/12/1015-05-IPv6_global_addressing.png)A IANA atribui endereços aos RIRs, que os atribuem aos ISPs que os emprestam aos clientes. Os clientes finais devem pedir emprestados apenas prefixos de rede / 64.

Os prefixos de rede IPv6 são atribuídos estritamente de acordo com **a localização geográfica** . Essa ideia foi aplicada também no IPv4, e no início do IPv6, mas sem ser uma regra estrita. Agora, isso é feito totalmente pelo manual, porque com o IPv6 temos uma grande carga de endereços e um roteador não pode ser capaz de lembrar uma rota diferente para cada prefixo, em vez disso, ele deve saber apenas como chegar aos prefixos asiáticos, americanos prefixos e assim por diante, economizando muita memória e poder computacional no roteador. Explicaremos esse conceito, conhecido como *sumarização* , posteriormente no curso CCNA.

Para resolver a falta de espaço de endereçamento, usar *endereços IP de 128 bits* em um pacote IPv4 teria sido suficiente, mas a falta de endereços não é o único problema que estamos tentando resolver. Por todos os motivos que já explicamos anteriormente, precisamos não apenas de um novo sistema de endereçamento, mas de *uma nova* **Estrutura de Camada de Rede** , no centro da qual temos o **pacote IPv6** . Como você pode ver na imagem abaixo, o cabeçalho do pacote é muito mais simples e com menos campos do que o que usamos no IPv4. Vamos ver o propósito de cada campo.

![Cabeçalho do pacote IPv6](https://www.ictshore.com/wp-content/uploads/2016/12/1015-06-IPv6_packet.png)O cabeçalho do pacote IPv6, muito mais simples do que o IPv4.

A primeira coisa que você vê no **cabeçalho de um pacote IPv6** é o tamanho dos endereços de origem e destino, que são 128 bits cada. Alguns outros campos estão presentes para permitir um melhor gerenciamento da entrega de conteúdo. Você pode encontrar todos os detalhes na lista a seguir.

- **Versão** - indica a versão do protocolo IP, constante a 6 para IPv6 (o valor binário é `0110`)

- Classe de tráfego

   \- Apesar de representada como um único campo, esta é na verdade a união de dois campos menores que, juntos, classificam a importância do tráfego, permitindo que os roteadores priorizem o tráfego importante sobre o tráfego normal

  - **Serviços diferenciados** - os primeiros 6 bits do campo de classe de tráfego são efetivamente usados para indicar a importância / prioridade para o pacote atual
  - **ECN** - os dois últimos bits do campo de classe de tráfego são a Notificação Explícita de Congestionamento, usada a partir dos dispositivos de comunicação para notificar o congestionamento da rede um ao outro

- **Rótulo de fluxo** - este é um identificador do fluxo de tráfego no qual este pacote está contido; quase nunca enviamos um único pacote IP, mas uma série deles, isso identifica o grupo de pacotes ao qual o pacote atual pertence para que os roteadores no caminho possam ter uma dica e enviar todos os pacotes do mesmo fluxo no mesmo caminho , para que cheguem na ordem certa ao destino desejado

- **Comprimento da carga útil** - indica o tamanho da carga útil do pacote IPv6, em bytes, incluindo extensões de cabeçalho, se houver

- **Próximo cabeçalho** - indica o próximo cabeçalho que o dispositivo encontrará ao ler o pacote, que geralmente é o cabeçalho do datagrama da camada de transporte (a primeira coisa que você encontrará na carga útil) - no entanto, isso pode ter *valores especiais* em caso adicionamos opções ao cabeçalho IPv6

- **Hop Limit** - funciona exatamente como o TTL do IPv4, é diminuído por cada roteador ao longo do caminho e todos os pacotes recebidos com 0 neste campo são descartados

- **Endereço de origem** - endereço IPv6 do remetente

- **Endereço de destino** - endereço IPv6 do receptor

Com o **próximo** campo de **cabeçalho** , os criadores do IPv6 fizeram um trabalho muito bom. No caso de usarmos um cabeçalho IPv6 simples sem nenhuma extensão, o próximo cabeçalho que iremos encontrar é o *cabeçalho da Camada de Transporte* . Porém, caso desejemos adicionar algumas opções para estender o cabeçalho IPv6, o próximo cabeçalho que encontraremos é uma **extensão do cabeçalho IPv6** , portanto sabemos que após o endereço de destino ainda não temos a carga útil. O campo Próximo Cabeçalho é repetido no final de cada extensão de cabeçalho, para que você possa seguir várias extensões uma após a outra e, após a última extensão, você pode finalmente anexar sua carga útil da Camada 4. As extensões de cabeçalho IPv6 estão fora do escopo deste artigo, mas saiba que elas existem.

## Métodos de endereçamento IPv6

Com o IPv4, tínhamos três tipos principais de endereços (tecnicamente conhecidos como *métodos de endereçamento* ): unicast, multicast e broadcast. No IPv6, isso muda drasticamente: preservamos apenas o *unicast* e o *multicast* , enquanto removemos o broadcast. Para isso, adicionamos *endereços de link-local* e *anycast* . Depois de compreender esses novos tipos de endereço, você mudará completamente a maneira como vê o endereçamento IP.

### Link-local

Um **endereço local de link IPv6** é um endereço válido apenas *no domínio de transmissão* (é local para ele). Esse endereço não é roteável, o que significa que nenhum roteador pode ter uma rota para ele porque deve estar conectado diretamente e pode ser comparado a um endereço da camada 2, porque se comporta da mesma maneira. Tínhamos um conceito semelhante no IPv4, o endereço APIPA ( `169.254.0.0/16`), que é válido apenas dentro do mesmo segmento de rede. O propósito disso, no entanto, é revolucionário, e veremos isso quando falarmos sobre a **descoberta de vizinhos**. Como o endereço local de link é válido apenas dentro do domínio de broadcast, outro dispositivo pode ter seu endereço em outro domínio de broadcast, ou mesmo o mesmo dispositivo com NICs em domínios de broadcast diferentes pode ter o mesmo endereço local de link em cada NIC. Para endereços locais de link, todos `fe80::/10`os prefixos de rede são reservados, mas só `fe80::/64`podem ser atribuídos a interfaces. De um modo geral, para endereços locais de link, a parte do ID da interface do endereço é gerada automaticamente com a técnica **EUI-64** (a menos que seja configurado manualmente): o endereço MAC do NIC é dividido em duas partes (OUI à esquerda, específico do NIC à direita), então `FFFE`é adicionado entre os dois. Por exemplo, um NIC com endereço MAC `00:19:80:fd:48:de`terá um EUI-64 de`001980FFFEfd48de`, resultando em um endereço local de link IPv6 de `fe80::0019:80ff:fefd:48:de/64`.

![Endereços locais de link IPv6, exclusivos dentro do domínio de transmissão](https://www.ictshore.com/wp-content/uploads/2016/12/1015-07-IPv6_link_local_address.png)Os endereços locais de link IPv6 devem ser exclusivos dentro do domínio de transmissão (neste exemplo, temos os domínios de transmissão azul claro e verde).

### Multicast

Se com o IPv6 introduzimos o endereço local de link, também removemos os endereços de broadcast: o endereço de broadcast direcionado e o endereço de broadcast padrão. No entanto, ainda precisamos de uma maneira de enviar informações a todos os nós do segmento, portanto, não podemos simplesmente nos livrar da transmissão. Em vez disso, temos que encontrar maneiras diferentes de fazer o que a transmissão fez. E *substituímos completamente as transmissões* , aproveitando o conceito de **endereço multicast** . Assim como o IPv4, um endereço multicast é um endereço “inscrito” por vários nós: esses nós ouvirão esse endereço. Todos os endereços multicast, em IPv6, pertencem ao `ff00::/8`prefixo.

A estrutura de um endereço multicast IPv6 é dividida em quatro grupos de bits. Começando da esquerda, temos o **prefixo de rede** (primeiros 8 bits constantes de `ff`), quatro bits de **sinalizadores (FLG)** e quatro bits de **escopo** . O escopo indica onde o endereço multicast é válido e, portanto, único (por exemplo, uma organização, o domínio de broadcast etc.). Dos quatro bits disponíveis para sinalizadores, apenas três são usados, conforme descrito a seguir.

- **Reservado** - o primeiro e mais significativo bit não é usado atualmente, mas é reservado para usos futuros
- **Rendezvous (R)** - Definido para um dos pontos de encontro está incorporado
- **Prefixo (P)** - definido como um dos endereços com base nas informações do prefixo da rede
- **Transiente (T)** - Definido como zero se este for um endereço multicast conhecido, definido como 1 se este for um endereço atribuído dinamicamente

O valor do **campo de escopo (SC)** , pode variar modificando a primeira parte do endereço, que reflete onde o endereço é único conforme segue.

- `ff02::`- **link-local** , o endereço multicast é válido e exclusivo dentro do link (domínio de transmissão)
- `ff05::`- **site-local** , o endereço multicast é válido e exclusivo dentro do mesmo site, local ou edifício (dentro de um contexto maior, como uma empresa)
- `ff08::`- **escopo organizacional** , o endereço multicast é válido e único dentro da mesma organização, empresa ou empresa
- `ff0e::`- **escopo global** , atribuído pela IANA e válido em todo o mundo
- `ff01::`- **interface local** , o endereço multicast é válido e único dentro da mesma interface, o tráfego para esse endereço nem chega a tocar no link de rede, mas permanece interno ao nó, é o equivalente ao endereço de **loopback** do IPv4

Os *112 bits* restantes à direita realmente compõem o endereço multicast e, no final, a estrutura de um endereço multicast IPv6 será muito parecida com a figura a seguir.

![Formato de um endereço multicast em IPv6](https://www.ictshore.com/wp-content/uploads/2016/12/1015-08-IPv6_multicast_address_format.png)Este é o formato de endereço multicast: prefixo, sinalizadores, escopo e endereço (112 bits).

Na verdade, existem muitos endereços multicast IPv6 *bem conhecidos* , mas por enquanto é importante que você se lembre de apenas dois deles, relatados na tabela a seguir.

| Endereço  | Alcance | Descrição                                                    |
| --------- | ------- | ------------------------------------------------------------ |
| `ff02::1` | Ligação | Todos os nós do link. Ele efetivamente substitui um endereço de **broadcast** . |
| `ff02::2` | Ligação | Todos os roteadores no link.                                 |

Endereços multicast IPv6 conhecidos, de que você deve se lembrar.

IPv4 originalmente não suportava endereço multicast e este era um complemento para este protocolo. O IPv6, em vez disso, suporta nativamente o conceito de multicast, mas, pelo que vimos, é quase idêntico ao conceito de multicast que tínhamos no IPv4. E isso é verdade para os endereços multicast que vimos até agora, embora haja uma categoria especial de endereços multicast que se comporta de uma maneira diferente: o *endereço multicast do nó solicitado* .

Um **endereço multicast de nó solicitado** é um endereço multicast especial subscrito por um único nó. Ele é criado automaticamente tendo os últimos *24 bits* do endereço IPv6 da interface e anexando-os a este prefixo fixo: `ff02:0:0:0:0:1:ff00::/104`. Como exemplo, o `fe80::2aa:ff:fe28:9c5a`endereço local do link irá gerar este `ff02::1:ff28:9c5a`endereço multicast de nó solicitado. Observe que os últimos 24 bits correspondem aos últimos 6 dígitos hexadecimais. Qual é a razão por trás do desenvolvimento de um endereço tão estranho? Qual é o propósito de ter um endereço multicast sendo ouvido por um único nó? Com este formato de endereço, alcançamos uma funcionalidade única. Quando falamos sobre [Ethernet e camada de enlace de dados](https://www-ictshore-com.translate.goog/free-ccna-course/data-link-layer/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) , aprendemos que os endereços multicast*são tratados como* endereços de *broadcast* por switches e dispositivos da camada 2. Com esse endereço multicast, podemos ter nosso tráfego tratado como tráfego de broadcast dos *dispositivos* da *camada 2* e como tráfego unicast dos dispositivos da camada 3. A necessidade disso será explicada posteriormente neste artigo.

### Anycast

O IPv4 não suporta o conceito de endereço anycast nativamente, e para implementar isso com o IP na versão 4, temos que quebrar as especificações do protocolo. Com o IPv6, isso é diferente, porque **anycast** tem suporte nativo. Um endereço anycast está *entre o conceito de endereço multicast e unicast* . Para ser mais específico, é na verdade um *endereço unicast atribuído a vários dispositivos em* todo o mundo e, em vez de identificar o próprio dispositivo, identifica os **serviços**oferece. Isso permite que outros dispositivos apontem para esses serviços e alcancem o dispositivo mais próximo que oferece esse serviço, sem realmente saber qual é o dispositivo mais próximo. Isso simplifica a configuração do cliente (dispositivo do usuário final), mas adiciona complexidade aos roteadores no caminho. Quanto mais os dispositivos que compartilham o mesmo endereço anycast estão distantes (em termos de roteadores no caminho), mais complexidade é adicionada à mistura. Isso, no entanto, permite uma **distribuição geográfica** dos serviços.

### Endereços unicast

Os endereços unicast no IPv6 são o que costumavam ser no IPv4: são atribuídos a **uma única interface** e a identificam na Internet. Mesmo que ainda tenhamos endereços IPv6 *site-local* unicast se comportando como endereços IPv4 privados, não há necessidade de multiplexar vários endereços privados em um único endereço público para economizar espaço: *cada dispositivo pode ser atribuído com seu próprio endereço público* , temos muitos endereços. Desta forma, o plano de endereçamento de uma empresa pode ser criado diretamente com endereços públicos ao invés de privados.

Outra revolução que o IPv6 traz para a mesa é que **vários endereços unicast** do mesmo prefixo podem ser atribuídos *à mesma interface de rede* . Para isso, você pode adicionar endereços anycast e um único endereço local de link (este é aquele do qual você não pode ter várias instâncias).

A partir de agora, IANA está atribuindo endereços apenas do `2000::/3`prefixo, enquanto o `2001:db8::/32`prefixo é reservado para fins de documentação e não pode ser usado em ambientes da vida real.

## Descoberta de vizinho e descoberta de roteador

Já sabemos que o IPv6 é um framework totalmente novo que não se destina apenas a substituir seus antecessores, mas também a muitos protocolos dos quais o IPv4 depende. Entre eles, está o *Address Resolution Protocol (ARP)* , que é usado para mapear endereços IPv4 para endereços MAC. Com o IPv6, podemos nos livrar completamente desse protocolo usando um mais eficiente, o **Neighbour Discovery Protocol (NDP)** . O NDP depende do pacote **ICMPv6 (Internet Control Message Protocol versão 6)** para fazer seu trabalho.

O pacote ICMPv6 é uma PDU da camada 3 que, na verdade, é encapsulada em um pacote IPv6. Sua estrutura é bastante simples, temos um campo **Tipo** e um campo **Código** (ou subtipo), um checksum para verificar se tudo foi entregue corretamente e depois algum espaço para dados específicos do ICMPv6, que variam de acordo com o tipo e código. A figura a seguir, a título de exemplo, mostra os campos apresentados no *pacote ICMPv6 do tipo 134* .

![ICMPv6, a base do Protocolo de Descoberta de Vizinhos](https://www.ictshore.com/wp-content/uploads/2016/12/1015-09-ICMPv6.png)O protocolo ICMPv6 é aquele em que a descoberta de vizinho depende. Neste exemplo, esta é uma mensagem Tipo 135 ICMPv6.

Na substituição do ARP, usamos dois tipos diferentes de pacotes ICMPv6. O **tipo 135** é usado em substituição de *solicitações ARP* , e o **tipo 136** é usado em substituição de *respostas ARP* , este é o processo de **descoberta** de **vizinho (ND)** *.* Um nó deseja se comunicar com outro nó no mesmo domínio de broadcast, mas conhece apenas o endereço unicast IPv6 do destino, enquanto o endereço do link local e da camada 2 ainda são desconhecidos. Para obter essas informações, o remetente cria um pacote ICMPv6 com Tipo 135, conhecido como **Solicitação de Vizinho (NS)**e envie-o para o endereço multicast do nó solicitado do dispositivo de destino. Dessa forma, os dispositivos da camada 2 ao longo do caminho tratarão esse pacote como um broadcast, encaminhando-o para todos os dispositivos. No entanto, apenas o dispositivo de destino será aquele que o processará. Em seguida, o nó de destino criará um novo pacote ICMPv6 com Tipo 136, conhecido como **anúncio de vizinho** , para responder à solicitação com as informações solicitadas.

![Descoberta de Vizinhos, Solicitação de Vizinhos e Publicidade de Vizinhos](https://www.ictshore.com/wp-content/uploads/2016/12/1015-10-Neighbor_discovery.png)A descoberta de vizinho é o processo que conta com NS e NA para recuperar o endereço MAC e o endereço local do link de nós no mesmo domínio de transmissão, a partir de seu endereço IPv6 unicast.

Um processo semelhante é colocado em prática para encontrar o gateway padrão para um domínio de broadcast. Um dispositivo cliente envia um pacote ICMPv6 com tipo definido como 133 ( **Router Solicitation, RS** ) na inicialização, procurando roteadores no segmento. Este pacote é enviado ao endereço multicast de todos os roteadores `ff02::2`. Então, qualquer roteador no segmento responderá a isso com um tipo 134 ( **Anúncio de roteador, RA** ), contendo o endereço do roteador, bem como outras informações que são úteis para o dispositivo cliente obter seu endereço IP de um servidor ou para criar automaticamente o seu próprio (este último caso conhecido como *Configuração automática de endereço sem* **estado** ou **SLAAC** ).

![Solicitação de roteador (RS) e anúncio de roteador (RA).](https://www.ictshore.com/wp-content/uploads/2016/12/1015-11-Router_solicitation.png)Com a solicitação do roteador, um nó pede que todos os roteadores no segmento respondam. Os roteadores no segmento respondem, fornecendo aos nós as informações necessárias para ingressar na rede.

Anúncios de roteador são originados de endereços locais de link e são gerados em resposta a solicitações e também periodicamente (a cada 200 segundos). Quando são gerados periodicamente, destinam-se a todos os nós do segmento ( `ff02::1`endereço multicast).

## Migração de IPv4

Agora sabemos como o IPv6 é bonito, mas substituir todos os componentes de hardware e software do mundo por algo que suporte IPv4 e IPv6 ou apenas IPv6 é apenas um sonho, pelo menos no futuro previsível. Em vez disso, a migração será (e é) um processo lento e duradouro, onde o IPv4 e o IPv6 estarão presentes juntos por algum tempo. Para facilitar isso, várias técnicas foram desenvolvidas para apoiar a **migração** e a **interoperação** dessas duas versões do protocolo da Internet.

A primeira e mais fácil técnica é conhecida como **Dual-Stack** . Essa técnica permite a migração da versão 4 para a versão 6, mas não permite que dispositivos IPv4 se comuniquem com dispositivos IPv6. O conceito é muito simples, como você deve ter adivinhado pelo nome: os dispositivos executam **duas pilhas OSI** , uma contendo a estrutura IPv4 e outra contendo a estrutura IPv6. Dessa forma, os dispositivos intermediários podem encaminhar e rotear o tráfego IPv6 e IPv4, mas a rede IPv4 lógica permanece separada da rede IPv6 lógica. Isso significa que um dispositivo que fala apenas IPv6 não será capaz de falar com outro dispositivo que fale apenas IPv4. A maioria dos componentes de hardware modernos (clientes, servidores, roteadores) oferece suporte a pilha dupla.

![Comunicação de pilha dupla, com IPv4 e IPv6 separados](https://www.ictshore.com/wp-content/uploads/2016/12/1015-12-Dual_stack.png)Com a pilha dupla, os dispositivos intermediários executam duas pilhas OSI para oferecer suporte a ambos os protocolos separadamente.

Uma ótima técnica para permitir que dispositivos do protocolo mais antigo conversem com dispositivos com o novo protocolo é conhecida como **NAT6to4** , que significa *conversão de endereço de rede “seis para quatro”* . A ideia por trás disso é muito simples, preenchemos os últimos 32 bits de um prefixo IPv6 específico ( `2002::/16`) com os 32 bits do endereço IPv4. Em seguida, o tráfego pode ser roteado apenas na rede IPv6. No entanto, a rede IPv6 deve ser configurada de forma a oferecer suporte ao roteamento *dentro* desse `2002::/16`prefixo.

![NAT6to4, fazendo o IPv4 falar com o mundo IPv6](https://www.ictshore.com/wp-content/uploads/2016/12/1015-13-NAT6to4.png)Com o NAT6to4, os roteadores podem converter endereços IPv4 em endereços IPv4 especiais.

Finalmente, temos **o encapsulamento IPv6 sobre IPv4** . Isso é usado para enviar informações com IPv6, criando uma ponte sobre uma rede que suporta apenas IPv4. Isso permite a migração porque o IPv6 pode se espalhar por áreas não IPv6, mas não a interoperação porque tem que ser feita por dois dispositivos de pilha dupla que mantêm as duas pilhas divididas. O pacote IPv6 é encapsulado dentro de um pacote IPv4 *como um datagrama da Camada 4 e* , em seguida, é enviado pela rede somente IPv4, visando o dispositivo de pilha dupla de destino. Esse dispositivo obterá o pacote IPv6 do pacote IPv4 e continuará o roteamento em outro domínio IPv6.

![Encapsulamento IPv6 sobre IPv4](https://www.ictshore.com/wp-content/uploads/2016/12/1015-14-IPv6_tunneling.png)Os roteadores de pilha dupla também são capazes de criar túneis IPv6 em redes somente IPv4.

Em suma, com este artigo apresentamos a beleza do IPv6 a partir das falhas do IPv4. Agora sabemos quais são as causas básicas por trás da criação desta versão mais recente do protocolo da Internet e quais são os benefícios que ela traz. Abordamos os métodos de endereçamento e os tipos de endereços, a substituição que ele traz para a estrutura TCP / IP por Neighbour and Router Discovery e, finalmente, tratamos de algumas técnicas usadas para permitir a transição do protocolo antigo para o novo protocolo. Com este conhecimento sólido da camada de rede, abrangendo desde endereçamento IPv4 e sub-redes até IPv6, agora estamos prontos para enfrentar as camadas superiores da pilha OSI, apresentando a camada de transporte e seus protocolos incríveis, mas isso é para o próximo capítulo do Curso CCNA.