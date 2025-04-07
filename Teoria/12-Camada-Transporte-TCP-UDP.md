# A camada de transporte: TCP e UDP



A camada de transporte fica no topo da camada de rede e atende diretamente aos aplicativos: enquanto a camada de rede permite a entrega de informações entre dois computadores em qualquer lugar da Internet, a camada de transporte permite a comunicação entre dois aplicativos em dois computadores diferentes. Neste artigo, descobriremos como isso é possível e, em seguida, teremos uma visão geral de alto nível dos dois protocolos mais importantes que podemos encontrar nesta camada: TCP e UDP. Vamos começar!

## Camada de transporte significa conexões de aplicativo a aplicativo

Se você está seguindo o curso CCNA, deve conhecer muito bem a camada de rede dos três artigos anteriores ( [endereçamento ](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-addressing/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)[IPv4](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-subnetting/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) , [sub](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-subnetting/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) - [rede IPv4](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-subnetting/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) e [IPv6](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv6-addressing/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) ) e saber que ele permite que dois computadores remotos se comuniquem pela rede. Se você observar a razão por trás da comunicação de dois computadores, descobrirá que eles estão realmente se comunicando *para permitir que o aplicativo seja executado neles*comunicar. Todo o tráfego é originado de um aplicativo e destinado a outro aplicativo em outros computadores: pense no que você faz com o seu computador, é extremamente provável que você navegue na web, assista a vídeos online - usando um navegador da web para isso - ou faça chamadas VoIP . por exemplo, com o Skype. Esses aplicativos requerem acesso à Internet para se comunicarem com seu servidor, um computador em algum lugar da Internet fornecendo o conteúdo que você está solicitando. Para navegar na Internet, o servidor é o computador que contém a página da web que você está visitando e que a envia para você sempre que você solicitar; para o YouTube, é o computador enviando o vídeo que você está assistindo, quadro após quadro, enquanto para uma chamada VoIP é o computador do seu amigo com o qual você está em uma chamada que está enviando áudio para você.



Todas essas comunicações acontecem *pela Internet* e, para o seu PC, é bastante fácil enviar tráfego para os **destinos certos** . No entanto, quando o tráfego de resposta volta, o computador precisa entregá-lo ao aplicativo certo, e apenas a ele, de forma que cada aplicativo possa ver apenas seu próprio tráfego. Fazer isso pode ser fácil enquanto falamos com servidores separados; se for esse o caso, então podemos saber que um determinado servidor está fazendo interface com um aplicativo específico, enquanto outro aplicativo está conversando com outro servidor, exatamente como na figura abaixo.

![Canais IP separados podem permitir a identificação da aplicação de sourcing](https://www.ictshore.com/wp-content/uploads/2016/12/1016-01-Separate_IP_Channels.png)Se o cliente estiver conversando com servidores separados para cada aplicativo, poderemos identificar o tráfego do aplicativo com base no IP do servidor.

Isso é ótimo, mas não podemos presumir que cada aplicativo irá se comunicar com um servidor separado dedicado apenas a isso. Por exemplo, o YouTube é um site que contém vídeo, como você pode identificar e diferenciar o tráfego da página da web do próprio vídeo? Isso pode se tornar mais difícil quando você está falando com um único servidor para vários aplicativos, portanto, não podemos contar com **canais IP** sempre **separados** (servidores de destino diferentes).

![O aplicativo que usa um único canal IP não pode ter seu tráfego diferenciado sem um mecanismo que não dependa de endereços IP](https://www.ictshore.com/wp-content/uploads/2016/12/1016-02-Single_IP_Channel.png)Se todo o tráfego para todos (ou alguns dos) aplicativos no cliente for enviado para o mesmo servidor, como podemos identificar o tráfego de cada aplicativo?

A camada de transporte foi projetada especificamente para resolver esse problema e faz isso de uma maneira terrivelmente simples. Na camada de transporte, damos um endereço para cada aplicativo que deseja se comunicar pela rede. Esse endereço identifica exclusivamente o aplicativo no computador e é um *número inteiro de 16 bits* denominado **Port ID** . Esse número pode ir de 0 a 65.535; o aplicativo pode solicitar um ID de porta específico, mas é o sistema operacional do dispositivo que deve garantir que esse ID de porta não esteja sendo usado por outro aplicativo. Com esses identificadores, podemos manter o tráfego de diferentes aplicativos separados.

*Dica: “ID da porta” é simplesmente chamado de “Porta” na maioria das vezes.*

![Multiplexação de porta da camada de transporte para manter o tráfego separado](https://www.ictshore.com/wp-content/uploads/2016/12/1016-03-Port_multiplexing.png)Com IDs de porta, o tráfego de cada aplicativo permanece separado do outro, independentemente dos endereços IP.

Considerando que o Port ID é *único apenas dentro de um computador* , ele pode ser usado apenas a partir do próprio computador: quando o computador recebe um pacote IP de qualquer outro dispositivo, ele enviará a carga útil para o aplicativo correto com base no Port ID. No entanto, a entrega de um computador para outro ainda é baseada no roteamento IP. Com base nisso, a ID da porta pode ser usada para identificar de forma única um aplicativo em um computador, enquanto um endereço IP público pode ser usado para *identificar de forma única um computador na Internet* . Isso significa que *a combinação de endereço IP e ID de porta identifica* exclusivamente um aplicativo na Internet. Essa combinação de endereço IP e ID de porta é tecnicamente conhecida como **soquete** : dois soquetes juntos identificam exclusivamente*a comunicação entre dois aplicativos* pela Internet.

Como o ID da porta é um inteiro, ele é representado como um *número positivo decimal* , e quando temos que escrever um soquete, apenas escrevemos o endereço IP e o ID da porta, separados *por dois pontos* . Isso é fácil no IPv4, pois o endereço IP é escrito em notação com pontos (por exemplo `10.10.10.91:80`), mas pode se tornar mais complexo com o IPv6, pois já contém dois pontos. Nesse caso, usar colchetes para separar o endereço IPv6 a partir do Porto ID como segue: `[2001:db8:acad::12]:80`.

![Comunicação de soquete](https://www.ictshore.com/wp-content/uploads/2016/12/1016-04-Socket_communication.png)Dois soquetes identificam exclusivamente uma comunicação entre dois aplicativos na Internet.

Já sabemos que o conceito é bastante simples: dar um identificador aos aplicativos para manter o tráfego separado. No entanto, ainda não sabemos *como isso é implementado* . Você pode adivinhar a resposta, o aplicativo (como um navegador da web, um jogo, Skype etc.) passa seus dados para a camada de transporte, onde alguns **itens extras** são adicionados. Os dados do aplicativo, mais os itens adicionados a esta camada, da *unidade de dados do protocolo da camada de transporte* *(PDU)* , que é conhecida como **segmento** ou *datagrama* . O cabeçalho do segmento é diferente se o protocolo usado for *TCP ou UDP* , mas não importa o protocolo usado, dois itens estão sempre presentes: **ID da porta de origem** e**ID da porta de destino** . Eles são apenas o que o nome diz que são, o ID da porta de origem identifica o aplicativo no dispositivo que criou aquele segmento, enquanto o ID da porta de destino identifica o aplicativo no dispositivo ao qual esse segmento se destina.

![Segmento, o PDU da camada de transporte, encapsulado no pacote IP e, em seguida, no quadro de enlace de dados](https://www.ictshore.com/wp-content/uploads/2016/12/1016-05-Segment.png)O segmento (roxo) é o PDU da camada OSI de transporte.

Assim como com os endereços IP, tínhamos alguns endereços privados específicos, endereços públicos e endereços multicast, com IDs de porta temos alguns intervalos específicos: nem todos os aplicativos podem usar os mesmos IDs de porta. Especificamente, podemos dividir os IDs de porta em três intervalos: portas **conhecidas** , portas **reservadas e** portas **dinâmicas ou privadas** . A finalidade e os detalhes desses intervalos estão contidos na tabela a seguir.

| Nome do intervalo | Portas no intervalo | Descrição                                                    |
| ----------------- | ------------------- | ------------------------------------------------------------ |
| Bem conhecido     | 0-1023              | As portas nesta faixa são usadas para serviços populares (como HTTP, FTP, DNS, etc.) e geralmente são usadas no dispositivo que fornece o serviço (o servidor). |
| Reservado         | 1024-49151          | As portas nesta faixa são usadas para aplicativos de serviço (aqueles em execução em servidores), mas que foram adicionados posteriormente ao número conhecido ou para serviço proprietário (você pode adquirir na IANA sua própria ID de porta). Às vezes, as portas neste intervalo são usadas como dinâmicas (veja abaixo). |
| Dinâmico          | 49152-65535         | As portas neste intervalo são usadas pelo aplicativo cliente, pois não precisam de um ID de porta específico, mas, em vez disso, apenas qualquer porta para poder fazer solicitações aos servidores: um aplicativo cliente usará dinamicamente um ID de porta aleatório desse intervalo. |

Intervalos de portas da camada de transporte.

Agora que conhecemos a lógica da camada de transporte e seu componente mais importante (a ID da porta), podemos nos concentrar no que os dois protocolos mais usados nesta camada - *TCP e UDP* - adicionam à mistura, suas vantagens e desvantagens.

## Visão geral do TCP

### Visão geral

O primeiro protocolo que devemos verificar é o TCP, que é a sigla de **Transmission Control Protocol** . Este protocolo tem sido o rei indiscutível desta camada nas últimas décadas, é o mais *complexo* e **rico em recursos** . Este protocolo foi projetado com um objetivo principal: garantir uma *entrega confiável* de dados entre aplicativos remotos. Vamos dar uma olhada em suas características.

![TCP em um relance, o protocolo orientado à conexão que permite uma entrega confiável](https://www.ictshore.com/wp-content/uploads/2016/12/1016-06-TCP_overview-1.png)O TCP é um protocolo orientado a conexão que permite a entrega confiável e ordenada de dados.

Como podemos ver na imagem, o TCP é um protocolo **orientado à** conexão, o que significa que os dois aplicativos devem estabelecer uma conexão antes que possam realmente começar a enviar dados um ao outro. Isso significa que *eles devem concordar* que devem se comunicar antes de poderem fazê-lo. Ao ter uma conexão, podemos *usá-la para controlar a transferência de dados a* fim de garantir **uma entrega confiável** de dados. Isso significa que, quando a informação é enviada, é garantido que ela será recebida do outro lado da aplicação. Isso é possível porque o receptor notifica o remetente quando ele recebe os dados e, caso não receba, existe um mecanismo que aciona o remetente para *retransmitir os dados*que não foi recebido. Mas as características não param por aí, o TCP também é capaz de garantir a **entrega solicitada** (os dados chegam na ordem em que foram enviados, caso contrário, são reordenados pelo receptor) e *reduzir a velocidade de transmissão com base no congestionamento da rede* .

### Cabeçalho TCP

Todas essas funcionalidades são possíveis graças à implementação do TCP com um cabeçalho dedicado no segmento e com algoritmos específicos que rodam no computador que está usando o TCP para falar. Esses algoritmos leem e definem os campos no cabeçalho TCP com base em alguma lógica que explicaremos mais tarde neste artigo, mas antes de podermos chegar a isso, temos que folhear o próprio **cabeçalho TCP** .

![Cabeçalho do segmento TCP](https://www.ictshore.com/wp-content/uploads/2016/12/1016-07-TCP_segment.png)Este é o cabeçalho do segmento TCP. Os dados opcionais são as opções de cabeçalho que podem ou não estar presentes.

O TCP é um protocolo extremamente poderoso, porém complexo. Explicar todos os seus recursos aqui está fora do escopo deste artigo, portanto, o próximo artigo do curso CCNA será dedicado a todos os detalhes do TCP. Por enquanto, explicaremos apenas os campos que permitem que você entenda como o TCP funciona em alto nível.

- **Porta de origem** - identifica o aplicativo no dispositivo que originou o segmento atual.

- **Porta de destino** - identifica o aplicativo no dispositivo que receberá o segmento atual.

- **Número de sequência** - no TCP, enviamos um fluxo de bytes. Este campo é um número inteiro que identifica a qual byte no fluxo completo corresponde o primeiro byte da carga útil do TCP.

- **Número de confirmação** - Este campo é um número inteiro usado pelo receptor para informar ao remetente que recebeu alguns dados. É preenchido com o número do byte que o receptor espera ver a seguir, após o que já recebeu.

- Sinalizadores

   \- Esses sinalizadores são campos longos de 1 bit usados para definir parâmetros específicos da conexão

  - **ACK** *(Confirmação)* - Defina como 1 do receptor para dizer ao remetente para verificar o campo de número de confirmação
  - **RST** *(redefinir)* - informar ao outro dispositivo que a conexão está sendo encerrada imediatamente (redefinição forçada da conexão)
  - **SYN** *(sincronização)* - usado para estabelecer uma conexão
  - **FIN** *(Concluir)* - Usado para fechar uma conexão normalmente

- **Checksum** - Hash / Resumo de todo o segmento usado a partir do receptor para verificar se nenhum erro ocorreu durante a transmissão

Conhecendo esses campos, estamos prontos para explicar como o TCP funciona e como ele implementa seus recursos mais básicos, além disso, estaremos prontos para entender os complexos no próximo artigo.

### Estabelecendo a conexão

Já dissemos que o TCP é *orientado à conexão* , agora é hora de ver como ele realmente estabelece uma conexão. Isso é desativado com um procedimento chamado **handshake de três vias** , porque envolve três trocas de dados. Neste procedimento, um dispositivo deseja falar com outro e iniciar a conexão com ele enviando um segmento TCP vazio com o **sinalizador SYN definido como 1** . Este segmento contém basicamente apenas as portas de origem e destino e esse conjunto de sinalizadores. Na maioria das vezes, *o dispositivo que inicia a conexão é o cliente*(aquele que pede serviços). Se o dispositivo do outro lado for um aplicativo ouvindo a porta de destino especificada, e se esse aplicativo estiver disposto a responder a esse dispositivo, ele retornará um segmento vazio com os IDs de porta especificados, o **sinalizador SYN definido como 1 e o ACK sinalizador definido como 1** . Ao fazer isso, o dispositivo informa ao iniciador que obteve a solicitação e também deseja abrir a conexão. Neste ponto, o dispositivo que originalmente iniciou a conexão, envia de volta um quadro para o outro dispositivo com o **sinalizador ACK definido como 1** . Depois disso, a conexão é estabelecida com sucesso e os dois dispositivos podem começar a trocar dados. A imagem a seguir mostra exatamente isso.

![Handshake TCP de três vias, que é SYN, SYN + ACK, ACK](https://www.ictshore.com/wp-content/uploads/2016/12/1016-06-Three_way_handshake.png)O handshake TCP de três vias pode ser dividido em três etapas: SYN, SYN + ACK, ACK.

Obviamente, a porta de origem e a porta de destino nos segmentos enviados pelo cliente serão a porta de destino e a porta de origem nos segmentos de resposta enviados pelo servidor.

### A transferência de dados

Uma vez que a conexão é estabelecida, a verdadeira troca de dados começa e a **entrega confiável** vai com ela. Este recurso, que vem com a **entrega solicitada** , depende de dois campos no cabeçalho do segmento TCP: *número de sequência* e *número de confirmação*. Os aplicativos veem as conexões TCP como fluxos de bytes, de modo que podem dizer como cada byte recebido está localizado em todo o fluxo. Com esse conceito em mente, quando um aplicativo está enviando dados para outro, o número de sequência é usado para dizer qual é a posição do primeiro byte de dados sendo enviado (o primeiro byte da carga útil) em todo o fluxo de dados. Digamos que temos que enviar 1.000 bytes, mas podemos enviar apenas 100 por vez. O primeiro número de sequência será 0, o segundo 100, o terceiro 200 e assim por diante. Tem uma utilização simples e imediata: permite ao receptor reordenar os segmentos caso os receba na ordem errada (talvez alguns deles tenham percorrido um caminho diferente na rede, mais rápido ou mais lento). O remetente, no entanto, pode enviar um número limitado de bytes (mesmo em segmentos diferentes),mas depois disso, ele tem que parar e esperar que o receptor os reconheça, para dizer que realmente recebeu os segmentos. Este é o propósito docampo de *número de confirmação* . É usado pelo receptor para informar ao remetente o que o byte está esperando (de todo o fluxo). Isso implica que todos os bytes anteriores a este foram recebidos corretamente, por exemplo, se o número de confirmação for definido como 800, significa que os bytes de 0 a 799 foram recebidos corretamente. A figura a seguir explica esse procedimento de forma visual.

![Confirmação de TCP com número de sequência e números de confirmação](https://www.ictshore.com/wp-content/uploads/2016/12/1016-09-acknoledgment.png)O TCP tem um sistema de números de sequência e confirmação que permite a reordenação dos dados, bem como a entrega confiável.

Conforme a imagem destaca, caso o receptor tenha perdido um segmento, mas o próximo tenha sido recebido corretamente, o receptor enviará de volta ao remetente um número de confirmação que permite a retransmissão do segmento perdido, desta forma todos os segmentos recebidos depois disso **serão ser descartado** . Este não é o comportamento ideal, mas é aquele usado nas implementações mais básicas que não dependem do *Reconhecimento Seletivo* , o que está além do escopo deste artigo. Observe *que a retransmissão é acionada em três casos*: quando o receptor não recebe segmentos, quando o remetente não recebe segmentos de confirmação (assume que os segmentos enviados não foram recebidos após um tempo limite expirado) e quando o receptor verifica se a soma de verificação não corresponde ao segmento.

Pelo que vimos até agora, podemos pensar que o TCP permite que os dados sejam enviados em apenas uma direção, mas isso não é verdade. Uma conexão TCP permite a transferência bidirecional de dados, e isso significa que não há realmente um remetente e um receptor, mas, em vez disso, cada dispositivo enviará aos outros dados com um número de sequência crescente e esperará números de confirmação deles. Para simplificar, em um segmento, um dispositivo diz *“Ei, estou enviando a você bytes 3.200 do meu stream. Estou esperando byte 1.800 do seu stream ”* . Os números de sequência e confirmação *no mesmo segmento não estão relacionados* .

### Término de conexão

Agora que sabemos como ocorre a transferência de dados, é hora de verificar como a conexão é encerrada. Existem duas maneiras, a reconfiguração da conexão e o encerramento normal.

A **redefinição da conexão** é bastante simples: por qualquer motivo, um dispositivo pode querer *encerrar uma conexão imediatamente* . Este tipo de fechamento não exige que o outro dispositivo concorde, o dispositivo que optou por este fechamento apenas envia um segmento com o **sinalizador RST definido como 1** , então não aceitará mais do dispositivo / aplicativo oposto. As razões por trás desse tipo de encerramento de conexão são várias: uma causa comum é quando *um aplicativo não está aceitando conexões* , então ele responde com RST toda vez que recebe um segmento SYN; outro caso é quando a conexão tem problemas sérios que *um dispositivo decide que é hora de desistir da transmissão* , então ele apenas envia um RST. Outros casos são geralmente relacionados a*violações de segurança* .

O **fecho elegante** é um pouco mais sofisticado e é o que deve ser usado quando estiver tudo bem. Quando um dispositivo termina de enviar dados, ele envia um quadro com o **sinalizador FIN definido como 1** . Se o outro dispositivo também tiver terminado, ele enviará os **sinalizadores FIN e ACK definidos** , caso contrário, ele enviará apenas o sinalizador ACK para dizer “Ok, não vou ouvir você, mas continue a me ouvir”. Caso ainda não envie o flag FIN, o outro dispositivo ficará disponível para enviar as confirmações, mas não os dados. Assim que este segundo dispositivo também terminar, ele enviará o sinalizador FIN, então o dispositivo que iniciou o fechamento enviará um segmento com o **sinalizador ACK definido como 1**, então a conexão é considerada encerrada. Mesmo que este seja o tipo de encerramento de conexão pelo livro, muitos aplicativos que trabalham em um modelo cliente-servidor usam redefinição de conexão porque é mais rápido e economiza recursos no servidor (o soquete é fechado assim que não for necessário, para que possa ser reutilizado com outro cliente).

Com esse conhecimento do TCP, você está pronto para discutir suas vantagens e desvantagens em relação ao UDP, protocolo apresentado logo abaixo neste artigo.

## UDP em resumo

### Visão geral

UDP significa **User Datagram Protocol** , e nasce ao mesmo tempo que TCP. No entanto, nos primeiros dias da Internet, era apenas uma pequena parte do tráfego usado. No entanto, com o aumento da velocidade de conexão e com o crescimento dramático dos aplicativos em tempo real, o UDP agora é o rei da camada de transporte da mesma forma que o TCP, e há estudos que planejam eliminar completamente o TCP em favor do UDP. Nesta seção, explicamos como o UDP funciona e quais são os motivos para isso. Vamos começar com uma visão geral rápida.

![Visão geral do UDP, um protocolo sem conexão que permite a entrega rápida de dados com o melhor esforço](https://www.ictshore.com/wp-content/uploads/2016/12/1016-10-UDP_Features.png)UDP é um protocolo sem conexão que permite a entrega rápida de dados com o melhor esforço.

UDP é um protocolo **sem** conexão, e isso significa que os dados podem ser enviados imediatamente: não há necessidade de estabelecer uma conexão antes que os dados possam ser enviados, em vez disso, um aplicativo pode simplesmente escolher enviar os dados imediatamente. É um protocolo **rápido** , permitindo que mais dados sejam enviados com um único segmento se comparado ao TCP, e funciona da **melhor maneira** : isso significa que não há mecanismo embutido para verificar se os segmentos foram recebidos, eles são enviados apenas na esperança que eles não serão perdidos. Isso também implica na falta de entrega solicitada. Caso desejemos utilizar o UDP para ter uma entrega confiável e / ou ordenada, tivemos que implementar esses recursos na camada de aplicação.

### Cabeçalho UDP

O UDP não é tão complexo quanto o TCP e não há algoritmos complexos em execução em computadores que usam esse protocolo. Verifique seu cabeçalho para descobrir como é simples.

![Cabeçalho UDP e segmento](https://www.ictshore.com/wp-content/uploads/2016/12/1016-11-UDP_segment.png)Este é o segmento UDP simples: cabeçalho mais dados.

Como você pode ver, o cabeçalho UDP contém apenas as informações que permitem a entrega ao aplicativo correto. Temos a porta de origem e a porta de destino, temos um campo de comprimento para dizer ao receptor qual é o comprimento do segmento (cabeçalho e dados) e temos uma soma de verificação para verificar a integridade dos dados. Mais do que isso, a porta de origem e a soma de verificação *são campos opcionais* ! Digamos que queremos usar esses dois campos de qualquer maneira, temos um **cabeçalho de 64 bits** , que é muito menor do que o *cabeçalho TCP de 160 bits* . Isso significa que em um único segmento podemos enviar *96 bits a mais* de dados com UDP do que com TCP: isso permite que mais dados sejam enviados em um único segmento e, portanto, o protocolo seja **mais rápido** .

Neste ponto, você pode estar um pouco confuso. É UDP melhor ou pior do que TCP? É mais rápido, mas o que acontece se os dados forem perdidos? É para isso que serve a próxima seção. Dê uma olhada!

### UDP vs TCP

O UDP é extremamente mais rápido que o TCP, e não apenas porque envia 96 bytes a mais em cada segmento, mas também porque não há conexão estabelecida e o remetente não precisa aguardar confirmações. É um protocolo que realmente funciona na camada de Transporte, porque a retransmissão e a entrega solicitada devem ser tarefas gerenciadas na camada de sessão (que o TCP também cobre). Por ter um protocolo leve na camada de transporte, podemos decidir quais outros recursos extras implementar dentro do aplicativo, como na figura a seguir.

![Os recursos UDP são muito básicos, você pode adicionar o que quiser na camada de aplicativo](https://www.ictshore.com/wp-content/uploads/2016/12/1016-12-Custom_feature.png)Com o TCP temos todos os recursos implementados no próprio TCP, com o UDP podemos escolher quais recursos implementar e como fazê-lo, dependendo de nossas necessidades.

Como você pode ver na imagem, com o TCP todos os recursos da camada de sessão são sempre implementados. Em vez disso, usando o TCP, podemos selecionar quais recursos implementar com base em nossas necessidades. Por exemplo, o *Trivial File Transfer Protocol (TFTP)* requer o reconhecimento dos dados recebidos, enquanto o *Real-Time Protocol (RTP)* requer a entrega ordenada.

O UDP é hoje usado principalmente para **aplicativos em tempo real** , com o RTP instalado em cima dele na camada de sessão. Isso ocorre porque os aplicativos em tempo real (fluxos de vídeo e / ou áudio) precisam de velocidade (caso contrário, não seriam em tempo real!) E entrega ordenada, se possível: isso significa que se eles receberem dois segmentos quase ao mesmo tempo, eles tem que saber qual tem que ir primeiro, mas caso eles não recebam algo, não há tempo para providenciar a retransmissão, o stream deve continuar (é por isso que às vezes você pode ouvir interrupção em uma chamada VoIP). Por causa de sua simplicidade e extensibilidade, o UDP está sendo considerado um ótimo protocolo para substituir o TCP no futuro, mas por enquanto, essas idéias permanecem apenas teorias e estudos.

Com este artigo, você agora entende como funciona a camada de transporte e está pronto para mergulhar no TCP e, em seguida, nas camadas de sessão e apresentação, pois esses serão os tópicos dos próximos artigos da série de cursos CCNA.





----



