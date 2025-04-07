# A camada de enlace de dados do modelo OSI



A camada de enlace de dados é aquela que permite a comunicação entre dois nós contíguos, que são nós com acesso a um meio comum (conectados diretamente ou por meio de um meio compartilhado). Mesmo que isso possa parecer simples à primeira vista, nessa camada os protocolos começam a se envolver. Na camada de enlace de dados, muitas tarefas cruciais devem ser realizadas, como a detecção de interferências, a entrega para o nó correto se mais nós compartilham o acesso à mesma mídia ou as regras que permitem que um dispositivo fale na mídia ou esperar sua vez. Neste artigo, vamos cobrir tudo isso, indo ainda mais fundo para realmente entender a camada de enlace de dados.

## Camada de ligação de dados

Já conhecemos o papel da camada de enlace de dados do [artigo sobre a pilha OSI](https://www-ictshore-com.translate.goog/discover/osi-model-introduction/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) : permitir a comunicação entre dois dispositivos contíguos. A camada física não tem inteligência embutida, trata-se apenas de transformar bits em sinais e vice-versa, sem saber o que esses bits realmente significam. Acima disso, *a camada de enlace de dados controla a camada física* e é ela quem conhece o significado desses bits. Mudando o ponto de vista, a camada de enlace de dados também permite que a camada de rede se comunique perfeitamente em uma rede heterogênea. Em outras palavras, a camada de rede não se preocupa com a forma como os dados são colocados no cabo, nem se a mídia muda de cabeada para sem fio, graças à **camada de enlace de dados**que lida com tudo isso de forma autônoma.



Até agora, falamos apenas sobre conceitos, mas no final, essa camada de enlace de dados tem que ser implementada em algum lugar. E está presente em qualquer dispositivo de rede (caso contrário, o dispositivo não seria capaz de se comunicar), especificamente na **Placa de Interface de Rede (NIC)** . A NIC é um módulo interno que você já encontrará embutido em quase todos os computadores modernos que permite que o dispositivo se conecte à rede. Uma NIC gerencia apenas um tipo de conexão, então você terá uma NIC para conexão Ethernet e uma NIC para conexões sem fio. Os dispositivos de rede intermediários têm várias dezenas de NICs porque sua função é conectar outros dispositivos. Dentro de um computador, a NIC se comunica com **a Unidade de Processamento Central (CPU)** do seu PC graças ao **PCI Express**bus, um canal de comunicação dentro de cada computador que permite que os componentes internos conversem entre si. *A CPU é o cérebro do dispositivo* e é quem gerencia os dados do aplicativo: os aplicativos são executados dentro da CPU. Cada aplicativo iniciará com seus próprios dados (como uma página da web no caso de um navegador da web) e quebrará esses dados em uma forma de camada de rede dentro da CPU, então a CPU passará esses dados da camada de rede para *o NIC que irá gerenciar a camada de enlace de dados* e, em seguida, sua transformação em sinais (camada física).

![Da CPU para o cabo](https://www.ictshore.com/wp-content/uploads/2016/11/1012-01-From_the_CPU_to_the_cable.png)O aplicativo é gerenciado na CPU, que pega dados significativos e os divide em pacotes, enviados para a NIC que lê o bit e os coloca no cabo como sinais.

Para intermediar a comunicação entre a mídia e a CPU, a camada de enlace de dados é dividida em duas subcamadas. Na parte superior, temos a camada **Logical Link Control (LLC)** , que se comunica com a CPU, enquanto na parte inferior temos a camada **Media Access Control (MAC)** , que coloca os sinais no cabo e os lê a partir de isto. Suponha que tenhamos que mudar de uma mídia com cabo para uma sem fio, a parte do link de dados que gerencia essa mídia terá que mudar. Com esta estrutura, a subcamada MAC muda entre diferentes camadas físicas, mas a camada LLC permanece a mesma, fornecendo uma *interface consistente*para a camada de rede. Isso não apenas permite que a camada de rede seja verdadeira e completamente independente da camada física, mas permite que a CPU e o aplicativo nela imagine que estão falando diretamente com o aplicativo no outro dispositivo.

É aqui que o conceito de **encapsulamento** se torna extremamente importante. Como sabemos, as informações são originadas por um aplicativo da camada OSI 7, depois são repassadas até atingir a camada física. Cada vez que os dados atravessam uma camada *de cima para baixo*, essa camada adiciona algumas informações. Esses elementos extras são então enviados pela mídia física e lidos do outro dispositivo, na mesma camada: as informações adicionadas pela camada de apresentação do remetente serão lidas da camada de apresentação no receptor, as informações adicionadas na camada de sessão serão ler na camada de sessão e assim por diante. No dispositivo receptor, essas informações extras são lidas da camada pretendida e, em seguida, removidas antes de passar os dados para a camada superior, de modo que, no final, *o aplicativo receptor lerá apenas o que o aplicativo de origem enviou*. O encapsulamento acontece adicionando algumas informações no início dos dados e, às vezes, no final também. No entanto, informações nunca são adicionadas no meio dos dados. Os dados do aplicativo, além de todas as informações extras adicionadas pelas camadas, são chamados de **Unidade de Dados de Protocolo (PDU)** , e a PDU da camada de apresentação será *menor do* que a PDU da camada de enlace, pois na camada de enlace mais camadas foram adicionadas suas informações.

A fim de tornar dois aplicativos coisas que eles estão *falando diretamente* , como se estivessem no mesmo computador, *aproveitamos* fortemente o *encapsulamento* . Na CPU, vamos preparar os dados para serem enviados para a camada de rede, então a CPU pensa que acabou de enviar a informação desta forma. Em vez disso, a NIC a recebe e adiciona à PDU da camada 3 as informações específicas da camada de enlace. A NIC do dispositivo receptor usará essas informações de link de dados para garantir que os dados não sejam interrompidos durante a transferência e que os dados sejam realmente destinados a esse dispositivo. Nesse caso, ele removerá as **informações da camada de enlace** e passará o restante para a CPU, de forma que a CPU receptora pense que acabou de receber os dados da rede. A camada de rede PDU é chamada*Pacote* , embora a PDU da camada de enlace seja chamada de **Quadro** , a NIC terá que colocar os pacotes em quadros ao enviar e extrapolar os pacotes dos quadros ao receber.

![MAC e LLC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-02-MAC_and_LLC.png)Os dispositivos pensam que estão se comunicando diretamente na camada 3, mas na realidade os dados L3 são encapsulados em envelopes L2 no nível de NIC do remetente e desencapsulados no nível de NIC do receptor: o caminho real é o tracejado . Nele, o LLC se comunica com a CPU e o MAC se comunica com a camada física.

As informações adicionadas na camada de enlace de dados habilitam todos os recursos dessa camada, como entrega de informações ao receptor correto por meio de uma mídia compartilhada ou detecção de interferência. Na seção seguinte, começaremos a ver o que são essas informações e como são utilizadas.

## Endereçamento na camada 2

A coisa mais importante feita na camada 2 do OSI é a **entrega de informações** ao dispositivo de destino. Isso está na base de qualquer comunicação, sem essa comunicação não seria possível. Então, para entregar os dados ao dispositivo de destino correto, temos que saber onde está esse dispositivo, temos que saber seu endereço. E isso é muito parecido com as *cartas do correio tradicional* , as informações da camada de link de dados são um envelope contendo dados das camadas superiores. Como na entrega do correio tradicional, lemos o *endereço no envelope* para saber para onde a carta deve ir.

![Endereços](https://www.ictshore.com/wp-content/uploads/2016/11/1012-03-Address.png)Em uma estrada, cada casa tem seu próprio endereço (aqui são números).

O networking é extremamente semelhante ao que acabamos de explicar. Como toda casa tem seu próprio endereço na realidade, *cada dispositivo tem seu próprio endereço* na rede. Um dispositivo terá um *endereço de camada 2* e um *endereço de* *camada 3* e, em seguida, cada aplicativo nesse dispositivo terá um endereço de camada 4. Por enquanto, vamos nos concentrar no endereço da camada 2.

![Endereços MAC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-04-MAC_Address.png)Como as casas em uma estrada têm endereços, os PCs em uma rede têm endereços MAC.

Esses códigos estranhos que você vê na imagem são os endereços da camada 2 dos dispositivos: os endereços MAC. Um **endereço MAC** tem seis bytes longos e é representado em **notação hexadecimal** . Se você está seguindo o Curso CCNA aqui em ICTShore.com, você saberá através do [artigo de matemática binária o](https://www-ictshore-com.translate.goog/free-ccna-course/binary-math-introduction/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) que é notação binária e notação decimal (se não, eu encorajo você a dar uma olhada). A notação hexadecimal é exatamente assim: a notação decimal é baseada em potências de dez, a notação binária é baseada em potências de dois e a notação hexadecimal é baseada em potências de 16. Você não precisa saber matemática hexadecimal como matemática binária, mas é útil para saber o básico.

Cada dígito vale *16 valores* , indo de *0 a 9* e, em seguida, a partir de *A a F* . Para representar 16 valores em binário, precisaríamos de 4 bits, portanto, um único dígito hexadecimal representará um nibble e dois representarão um byte. Abaixo, você encontrará uma tabela rápida útil para conversões.

| Decimal | Binário | Hexadecimal |
| ------- | ------- | ----------- |
| 0       | 0000    | 0           |
| 1       | 0001    | 1           |
| 2       | 0010    | 2           |
| 3       | 0011    | 3           |
| 4       | 0100    | 4           |
| 5       | 0101    | 5           |
| 6       | 0110    | 6           |
| 7       | 0111    | 7           |
| 8       | 1000    | 8           |
| 9       | 1001    | 9           |
| 10      | 1010    | UMA         |
| 11      | 1011    | B           |
| 12      | 1100    | C           |
| 13      | 1101    | D           |
| 14      | 1110    | E           |
| 15      | 1111    | F           |

Conversão de valores entre decimal, binário e hexadecimal.

Novamente, a notação hexadecimal é *apenas uma convenção* para representar endereços MAC de uma maneira mais legível, mas eles são armazenados em binário como qualquer outra informação. Vamos explorar a anatomia do endereço MAC com um pouco mais de detalhes.

![Anatomia do endereço MAC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-05-MAC_Address_anatomy.png)O endereço MAC é dividido em duas partes: o OUI que identifica o fornecedor ou fabricante da NIC, e a parte específica da NIC que identifica aquela NIC específica entre as produzidas por aquele fornecedor.

Um endereço MAC é um endereço de camada 2 *atribuído a qualquer NIC* , portanto, um dispositivo com duas NICs terá dois endereços MAC diferentes. Pode ser representado de diferentes maneiras: em notação pontilhada como na imagem, com notação de hífen `E4-AA-18-F6-B8-97`, ou com notação pontilhada dividindo as palavras `e4aa.18f6.b897`: são aceitas maiúsculas e minúsculas, desde que no mesmo endereço use apenas um dos (todas em minúsculas ou todas em maiúsculas).

Um endereço MAC identifica especificamente essa NIC e é **único** : não existe nenhuma duplicata no mundo. Os primeiros três bytes (três pares de dígitos) são chamados de **Organizationally Unique Identifier (OUI)** e são atribuídos a uma empresa produtora de NICs. Então, quando essa empresa produzir NICs, ela atribuirá os últimos três bytes do MAC ao NIC. Grandes produtores de NICs, como a Cisco, compraram vários OUIs porque eles produzem tantos NICs que ter apenas três bytes para definir seu identificador exclusivo não era suficiente. Como o OUI é atribuído a empresas, podemos entender a partir do endereço MAC de um dispositivo que foi o fabricante de sua NIC, várias ferramentas existem para fazer exatamente isso e estão disponíveis online gratuitamente, como no [site Wireshark](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.wireshark.org/tools/oui-lookup.html). Se estiver curioso e quiser experimentar, no Windows, pressione Windows + R, digite `cmd`e pressione Enter. Em seguida, digite `ipconfig /all`e procure o item da lista “Endereço físico”.

O endereço MAC já vem instalado na NIC. Ele pode ser modificado via software, mas o MAC original na NIC não pode ser removido completamente porque está codificado no hardware, isso é chamado de **Burnt-in Address (BIA)** , porque não pode ser removido. Usar um endereço MAC diferente do BIA não é uma prática comum e geralmente envolve atividades maliciosas, como *spoofing* (tentar ler o tráfego que não era destinado a nós).

Os endereços MAC são usados para entregar as informações ao dispositivo de destino correto. O quadro de link de dados contendo informações da camada 3 terá o endereço MAC de destino e o endereço MAC de origem. A entrega é baseada apenas no endereço MAC de destino, mas no endereço MAC de origem do dispositivo de destino para saber para onde enviar a resposta (observe que isso não é verdade para todos os dispositivos).

![Envelope de link de dados](https://www.ictshore.com/wp-content/uploads/2016/11/1012-06-MAC_from_to.png)O quadro da camada de enlace é como um envelope contendo os dados da Camada 3. No envelope, temos todas as informações para entregar essa carta no dispositivo local correto.

*Nota: Explicamos que o endereço MAC está relacionado à NIC e não diretamente ao dispositivo, mas a partir de agora, apenas para simplificar, vamos falar sobre ele como se estivesse relacionado também ao dispositivo.*

Nem todos os endereços MAC são iguais, existem três tipos: *unicast* , *broadcast* e *multicast* , e isso porque esses três tipos de endereços estão relacionados a três tipos diferentes de transmissão de dados, com nomes exatamente iguais. As informações são obtidas sempre de um **único dispositivo** , mas podem ser destinadas a um ou mais dispositivos.

Em uma transmissão **unicast** , as informações são destinadas a um dispositivo específico e apenas a ele. *Um endereço unicast* identifica especificamente um único dispositivo. O endereço unicast do dispositivo de origem será escrito no quadro como endereço de origem, mesmo para transmissão broadcast e multicast (já que o dispositivo de origem é apenas um). Mesmo que as informações sejam destinadas a um *único dispositivo de destino* , em uma mídia compartilhada todos podem ouvir tudo. Com o endereço de destino escrito no quadro, cada dispositivo ouvindo pode ler o endereço de destino e entender se o quadro foi realmente para ele mesmo (e se for, continuar a leitura).

![Unicast](https://www.ictshore.com/wp-content/uploads/2016/11/1012-07-Unicast.png)Em uma mensagem unicast, o destino pretendido é um único dispositivo.

Em uma **transmissão** por **broadcast** , as informações são destinadas a todos os dispositivos conectados a essa mídia compartilhada. Um endereço de broadcast indica tudo destino, e existe apenas um único endereço de broadcast: `FF:FF:FF:FF:FF:FF`. Este é um endereço especial sem OUI. Um quadro de broadcast será gerado a partir de um único dispositivo como sempre, com o endereço unicast desse dispositivo especificado como endereço de origem e terá o endereço de broadcast como endereço de destino. Todos os dispositivos na mídia sabem que este é o endereço de transmissão e ouvirão ativamente o tráfego enviado para esse endereço.

![Transmissão](https://www.ictshore.com/wp-content/uploads/2016/11/1012-08-Broadcast.png)Em uma mensagem de broadcast, o dispositivo de origem é um único dispositivo, mas o destino é um endereço MAC especial que indica todos os dispositivos conectados à mídia. Cada dispositivo ouvirá este quadro.

Em uma transmissão **multicast** , as informações são destinadas a vários dispositivos conectados à mídia compartilhada, mas não a todos. Como sempre, o endereço de origem no quadro é o endereço unicast do dispositivo de origem, mas como destino, temos um endereço multicast especial. Um endereço multicast é qualquer endereço que tenha *o oitavo bit começando da esquerda definido para um* . O equipamento de rede Ethernet tratará esses quadros apenas como quadros de broadcast, para que sejam entregues a todos os dispositivos. Então, os dispositivos que assinaram esse endereço MAC multicast irão, na verdade, ler o quadro inteiro, outros dispositivos irão simplesmente descartá-lo. Mesmo que o termo técnico seja *"assinar um endereço multicast"*, um dispositivo só tem que estar disposto a ouvir, não há dispositivo central que aceite uma assinatura ou algo assim: os dispositivos decidem de forma autônoma qual tráfego multicast eles devem ouvir.

![Multicast](https://www.ictshore.com/wp-content/uploads/2016/11/1012-09-Multicast.png)Em uma entrega multicast, o endereço MAC de destino é um endereço MAC especial que é tratado como um broadcast, todos os dispositivos irão recebê-lo e então apenas os dispositivos interessados irão ler o conteúdo (aqueles que “assinaram” aquele endereço multicast).

Agora que temos uma ideia de como a comunicação da camada 2 é possível, é hora de ver como isso realmente acontece.

## O Quadro Ethernet

O quadro Ethernet é o envelope que contém as informações provenientes das camadas superiores. Já sabemos que ele deve conter os endereços MAC de origem e destino, mas não é só isso. Existem dois frames Ethernet diferentes, **Ethernet II,** que é o antigo legado, e o frame **802.3,** que é o usado hoje.

![Frame Ethernet](https://www.ictshore.com/wp-content/uploads/2016/11/1012-10-Ethernet_Frames.png)O quadro Ethernet é o envelope de enlace de dados real que contém os dados da camada 3. Ele adiciona todas as informações necessárias para permitir a entrega local. Ele vem em duas variantes, Ethernet II e 802.3.

O quadro é composto de três partes: o **cabeçalho** , a **carga útil** e o **FCS** . O cabeçalho é o conjunto de campos que acompanham a transmissão, necessários apenas para transmitir / receber. A carga útil é o conteúdo das camadas superiores e o FCS é um campo que permite ao receptor verificar se a mensagem foi interrompida durante a transmissão. O cabeçalho é composto pelos endereços e pelo campo tipo / comprimento.

As informações devem ser enviadas como uma série de bits em sequência, portanto, os quadros são apenas isso. Além disso, o PDU das camadas superiores é colocado dentro dessa sequência. Os primeiros 8 bytes a serem enviados são essencialmente um preâmbulo para os dois quadros, eles anunciam que algo está chegando para que os receptores possam se preparar. O **preâmbulo** tem a função de permitir que o receptor se prepare para o quadro que está chegando e se sincronize com a técnica Phase Locking Loop. Um preâmbulo é basicamente um sinal que sobe e desce (1, depois 0, depois 1 novamente e assim por diante). Este preâmbulo foi reduzido de 8 para 7 bytes na versão 802.3 porque deve criar algum espaço para o Delimitador do Quadro Inicial. Isso foi possível graças a *PLLs* mais modernos que funcionaram até mesmo em uma transmissão de 7 bytes.

Então, temos o **Start Frame Delimiter (SFD)** no *quadro 802.3* . Isso diz ao receptor “Ok, agora chegamos. O próximo bit fará parte do quadro, então leia ”. Isso é muito importante porque originalmente o dispositivo de destino teria que ouvir o preâmbulo desde o primeiro bit e contar 8 bytes para entender onde a mensagem começou. Agora, com o SFD, o dispositivo de destino não precisa mais contar, é percebido pelo remetente quando a mensagem chega usando o SFD. Dessa forma, mesmo que o dispositivo de destino perca algum do preâmbulo, ele sempre pode receber a mensagem se o PLL foi tão bom para sincronizar o relógio nos bytes do preâmbulo que foram ouvidos do dispositivo de destino.

Então, em ambos os frames, temos o **Endereço de Destino** e o **Endereço de Origem** . Estes são os endereços MAC do receptor pretendido e do dispositivo emissor. O endereço de destino vem primeiro para que qualquer dispositivo que esteja ouvindo a mídia possa lê-lo rapidamente e decidir se deve ouvir o quadro ou não.

Após o endereço de origem, no frame *Ethernet II* , temos o campo Type, tecnicamente denominado **EtherType** . Isso indica qual protocolo está encapsulado dentro desse quadro. Cada protocolo que pode ser encapsulado no quadro Ethernet (geralmente protocolos da camada de rede) tem seu próprio identificador numérico, esse identificador é o conteúdo deste campo. Conhecendo o tipo de conteúdo, o dispositivo receptor sabe a extensão do conteúdo encapsulado e, portanto, pode ler o número correto de bytes. Essa abordagem, no entanto, não suportava flexibilidade: o dispositivo receptor não era capaz de lidar com mensagens de comprimento variável e mecanismos complexos foram colocados em prática para permitir mensagens de comprimento variável. Com o *quadro 802.3* mais recente, era necessária uma maneira mais simples de fazer isso, então alteramos esse campo em **Comprimento** . Isso apenas informa ao dispositivo receptor quantos bytes tem o conteúdo encapsulado.

Após o campo *Tipo / Comprimento* , encontramos a **carga útil** . Este é apenas o conteúdo encapsulado, informações provenientes das camadas superiores da pilha OSI.

No final do frame, encontramos o **Frame Checksum (FCS)** . Este é o campo usado para verificar se o quadro foi entregue corretamente: é um resumo do quadro. O dispositivo receptor cria esse resumo novamente começando do próprio quadro e, em seguida, compara o resumo que criou com o resumo que recebeu. Se forem iguais, a mensagem não foi interrompida e será processada, se forem diferentes significa que algo deu errado e o frame será descartado. Observe que se o quadro for descartado, o dispositivo de envio não será notificado e você pode criar o resumo a partir do quadro, mas não vice-versa.

Agora, o quadro 802.3 é usado na conexão de cabo Ethernet. No entanto, esta não é a única conexão disponível hoje. Outra conexão muito usada é o Wi-Fi, que tem seu próprio quadro.

## Camada 2 no ar

O quadro Wi-Fi é definido no [padrão IEEE 802.11](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=http://www.ieee802.org/11/) . É muito mais complexo do que o quadro Ethernet porque a transmissão pelo ar envolve muito mais itens. Antes de passar para o quadro, devemos conhecer a lógica por trás da transmissão. Em uma mídia compartilhada com fio, quem fala quando é gerenciado pelo algoritmo *CSMA / CD* , que explicamos no [artigo sobre topologias de rede](https://www-ictshore-com.translate.goog/free-ccna-course/network-topology/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) . Em uma rede sem fio, o algoritmo é um pouco diferente, é o **CSMA / CA** .

CSMA / CA significa Carrier Sense Multiple Access **Collision Avoidance**, e é exatamente isso que ele faz: os dispositivos que usam esse algoritmo tentam evitar a colisão antes que ela aconteça, porque a detecção de colisão não pode ser aplicada neste caso. O facto de CSMA / CD não ser adequado neste caso deve-se ao facto de os dispositivos comunicarem sempre com um Ponto de Acesso, que é o dispositivo central. O Ponto de Acesso pode escutar um único dispositivo por vez, e se o seu dispositivo “ver” o ponto de acesso, isso não significa necessariamente que você vê todos os dispositivos vistos pelo ponto de acesso (talvez o AP esteja no topo de uma colina, você pode ver, mas você pode ver os dispositivos do outro lado da colina). Portanto, se a colisão acontecer entre o AP e outro dispositivo tentando falar (ignorando que você já estava falando), ela não pode ser detectada corretamente. É por isso que deve ser *evitado de antemão* .

Um dispositivo que deseja transmitir algo espera que o canal fique ocioso: se o canal estiver ocupado, o dispositivo espera por um tempo de desligamento aleatório. Assim que o canal estiver ocioso, em CSMA / CD apenas transmitiríamos. Em vez disso, em CSMA / CA, o dispositivo envia uma mensagem de **Solicitação de Envio (RTS)** para o Ponto de Acesso e, em seguida, aguarda um curto período de tempo. Se dentro desse tempo o dispositivo receber o **Clear to Send (CTS)**mensagem do Ponto de Acesso, então segue com a transmissão, caso contrário considera o canal ocupado e o dispositivo espera novamente pelo tempo de recuo aleatório, então tente novamente enviando o RTS (ou aguarde antes de enviá-lo se sentir que o canal ficou ocupado). Neste processo, assumimos que o Ponto de Acesso tem visibilidade para todos os nós, por isso perguntamos se podemos transmitir. Se você é programador ou sabe um pouco sobre o assunto, vai achar interessante o seguinte *pseudocódigo* para o CSMA / CA.

enquanto ( **verdadeiro** )   

  **if** ( hasSomethingToTransmit () )   

​    **while** ( mediaIsBusy () ) ;   

​      sendRTS ()

​      esperar ( aShortTime )

​      **se** ( recebido CTS () )   

​        transmitir ()

Este mecanismo colocado em prática com o algoritmo CSMA / CA também é possível graças à implementação de 802.11 como quadro. Na Ethernet com fio, temos apenas *frames de dados* : frames que transportam informações originadas nas camadas superiores, mas no Wi-Fi, também precisamos de frames de *gerenciamento* e *controle* , frames que mantêm e monitoram a comunicação. Por exemplo, quando você procura um ponto de acesso Wi-Fi gratuito e vê muitas redes em seus smartphones, você as vê porque os pontos de acesso nessa rede enviaram um *quadro de Beacon* , um quadro para notificá-lo da existência da rede. Para o propósito deste artigo, veremos apenas o **quadro de dados 802.11**. Felizmente, você não precisa saber o quadro 802.11 para a certificação CCNA, nem para trabalhos de nível CCNA. No entanto, pode ser interessante dar uma olhada nele.

![Quadro 802.11](https://www.ictshore.com/wp-content/uploads/2016/11/1012-11-802_11_Frame.png)O quadro 802.11 é muito mais complexo do que o quadro Ethernet porque precisa lidar com a entrega no ar, o que é muito mais complexo.

Os primeiros dois bytes do quadro são dedicados ao **controle de quadros** . Este não é um único campo, mas sim uma combinação de campos menores e sinalizadores, onde um sinalizador é um campo com um único bit e que pode, portanto, ser definido apenas como verdadeiro (1) ou falso (0). No controle de quadros, temos os seguintes campos.

- **Versão do protocolo** - Versão do protocolo 802.11, geralmente 0
- **Tipo** - tipo de quadro, como dados, controle ou gerenciamento
- **Subtipo** - Usado junto com o tipo para identificar exatamente que tipo de quadro é este
- **ToDS** - verdadeiro se o quadro for direcionado a um sistema de distribuição
- **FromDS** - verdadeiro se o quadro vier de um sistema de distribuição
- **Mais fragmentos** - verdadeiro se os dados das camadas superiores foram divididos em vários quadros (e a decisão foi tomada na camada 2)
- **Tentar novamente** - verdadeiro se esta for uma retransmissão de um quadro
- **Gerenciamento de energia** - Indica qual será o estado da energia do remetente após a transmissão
- **More Data** - True se outro frame estiver chegando, usado pelos APs para facilitar a recepção para clientes que estão em modo de economia de energia
- **Quadro protegido** - verdadeiro se o quadro estiver criptografado (usando segurança Wi-Fi, como WEP ou WPA)
- **Pedido** - defina se a entrega de "pedido estrito" for usada

Então temos a *Duração* e até **4 endereços** , onde o *Endereço 1* é o receptor, o *Endereço 2* é o transmissor e o *Endereço 3* é usado para fins de filtragem pelo receptor. Antes do quarto endereço, temos o **Sequence Control** , que é usado para controlar a ordem dos frames e eliminar duplicatas. Após o quarto endereço, temos o *conteúdo* proveniente das camadas OSI superiores.

## O interruptor

O **switch** é o *dispositivo rei* na camada de enlace de dados. É um dispositivo de rede que geralmente tem *8, 12, 24 ou 48 portas* (NICs) usadas para conectar computadores e dispositivos finais. Por exemplo, encontrará um switch conectando todas as estações de trabalho de um escritório. É o sucessor moderno do hub e traz várias melhorias para a mesa. Antes de falar sobre isso, devemos primeiro entender dois conceitos, a colisão e o domínio de broadcast.

O **domínio de colisão** é o conjunto de dispositivos que ouvirão uma mensagem unicast originada por um deles. Com um hub com quatro dispositivos conectados, quando qualquer um desses quatro dispositivos enviava uma mensagem unicast para um dos outros três, todos os outros três tinham que ouvir a mensagem, mesmo que não fosse por eles. Um **domínio de broadcast** , em vez disso, é o conjunto de dispositivos que ouvirão uma fonte de mensagem de broadcast de um deles.

![Domínio de colisão e transmissão](https://www.ictshore.com/wp-content/uploads/2016/11/1012-12-Collision_and_broadcast_domain.png)Em um hub, os domínios de colisão e broadcast se sobrepõem. Com um switch, os domínios de colisão são drasticamente reduzidos ao link entre o switch e o dispositivo final.

A melhoria mais importante que o switch traz para a mesa é a **segmentação do domínio de colisão** : com um switch, as mensagens unicast são entregues apenas ao receptor pretendido, então o domínio de colisão que com o hub teria envolvido todos os dispositivos, com o switch é limitado entre o dispositivo e o próprio switch. Os domínios de broadcast, em vez disso, não são limitados: todos os dispositivos conectados a um switch ouvirão a transmissão fornecida por qualquer um deles, e esse é um comportamento desejado. Além disso, observe que o *tráfego multicast é tratado como uma transmissão* e enviado para todos os dispositivos, exceto a fonte do switch. Isso ocorre porque o switch não pode saber qual endereço multicast os computadores assinaram.

Para segmentar os domínios de colisão, o switch precisa fazer algum tipo de raciocínio, em comparação com o hub que foi limitado apenas para replicar eletricamente o sinal para todos os outros dispositivos. Esse processo de pensamento é implementado com a **tabela de endereços MAC** . Esta é uma tabela armazenada na memória do switch e associa os endereços MAC dos dispositivos conectados à porta do switch onde esses dispositivos estão conectados.

![Tabela de endereços MAC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-13-MAC_address_table.png)A tabela de endereços MAC contém as informações necessárias para uma mudança para domínios de colisão de segmento.

No entanto, essa tabela de endereços MAC deve ser **dinâmica** : você não pode comprar um switch com uma tabela de endereços MAC já preenchida simplesmente porque o fabricante não pode saber quais dispositivos você vai conectar a esse switch. Mais do que isso, tem que ser muito dinâmico porque você pode desconectar um dispositivo para conectar outro, e o switch precisa saber que você fez essa alteração. Felizmente, essa tabela é mantida e atualizada dinamicamente pelo switch. Sempre que o switch é ligado, ele começa com uma tabela de endereços MAC vazia e a *preencherá* assim que o tráfego começar a fluir. Cada vez que o switch recebe um quadro, verifique o *endereço de destino* e o *endereço de origem*. Se o switch souber onde o endereço de destino está conectado, ele enviará o quadro apenas por essa porta. Se o switch não souber em que porta o endereço de destino está conectado, ele enviará o quadro de todas as portas, exceto aquela em que recebeu o quadro. Enquanto isso, ele associa o endereço de origem à porta onde recebeu o quadro.

![Preenchendo a tabela de endereços MAC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-14-Populating_the_MAC_address_table.png)Cada vez que um switch recebe um quadro, ele usa o endereço de origem contido nele para atualizar sua tabela de endereços MAC. Se possível, entregue o quadro ao dispositivo correto com base no endereço de destino; caso contrário, como nesse caso, entregue-o a todos os dispositivos, exceto ao remetente.

Esperançosamente, o dispositivo de destino responderá de volta. Quando a **mensagem de resposta** for recebida do switch, ele verificará novamente o endereço de destino e, como sabe onde está o dispositivo, enviará esse dispositivo apenas para aquela porta específica. Ele também verificará o endereço de origem, aprendendo uma nova ligação entre o endereço MAC e a porta. A comunicação entre esses dois dispositivos, a partir de agora, não irá inundar o tráfego para outros dispositivos porque o switch sabe onde eles estão conectados.

![Usando a tabela de endereços MAC](https://www.ictshore.com/wp-content/uploads/2016/11/1012-15-Using_the_MAC_address_table.png)Quando o switch recebe um quadro destinado a um dispositivo com um endereço MAC conhecido (e, portanto, uma porta conhecida), o quadro é enviado pela porta correta, e somente por ela.

Isso permite **a transmissão full-duplex** , porque você pode enviar e receber simultaneamente (usando diferentes pares de fios internos do cabo Ethernet), uma vez que não ocorre mais colisão. Essa foi uma melhoria muito importante na rede, mas não é a única coisa que um switch pode fazer.

O switch tem a possibilidade de funcionar de duas maneiras diferentes, *cortar* e *armazenar e encaminhar* . Com **cut through** , assim que o switch lê o endereço de destino, ele começa a enviar o quadro para fora da porta (ou portas) de destino. Em vez disso, com a técnica de **armazenamento e encaminhamento** , o switch ouvirá toda a mensagem, armazenando-a em buffer e, em seguida, verificará o FCS para ver se foi interrompido e somente se for um bom quadro o enviará para fora da porta de destino ( ou portas). Os switches funcionam geralmente no modo store e forward, uma vez que o atraso é tão pequeno que não é significativo com a velocidade das redes modernas.

Outro recurso interessante dos switches modernos são **as redes locais virtuais (VLANs)** . Basicamente, você pode configurar um switch para agrupar sua porta em grupos, onde cada grupo será um domínio de broadcast. O tráfego de broadcast se espalhará apenas entre portas dentro do mesmo grupo e com portas em um grupo diferente. Em outras palavras, você usa um único switch para criar vários switches virtuais.

![Transmitir VLANs de domínios](https://www.ictshore.com/wp-content/uploads/2016/11/1012-16-Broadcast_domains_vlan.png)Com um switch, você pode agrupar portas em domínios de broadcast diferentes e independentes, chamados VLANs.

Mesmo considerando tudo o que um switch traz para a mesa, os switches não foram adotados imediatamente quando foram inventados. Isso ocorre por causa do alto custo que eles tinham e porque os requisitos de tecnologia não eram tão rígidos para precisar de uma largura de banda tão alta como é hoje. Mas esse não é o único motivo, originalmente os switches costumavam fazer seu trabalho no software, então todo o tráfego era processado pela CPU e isso reduzia a velocidade. Os switches modernos funcionam com os **Circuitos Integrados Específicos do Aplicativo (ASICs)** , componentes de hardware que realizam algumas tarefas muito específicas com extrema rapidez. Com alguns ASICs específicos, os switches modernos são capazes de manter a transmissão full-duplex na velocidade do fio (como se os dois dispositivos finais estivessem conectados diretamente).

Hoje em dia, não podemos imaginar uma rede sem switches. E agora, com o conhecimento que desenvolvemos sobre a camada de enlace de dados, temos as ferramentas para entender os motivos. Mais do que isso, temos as ferramentas para entender verdadeiramente os conceitos da Camada de Rede, como faremos em artigos posteriores.