# Camadas de sessão e apresentação no modelo OSI



As camadas de sessão e apresentação na pilha OSI podem ser consideradas *camadas sofisticadas* , pois são conhecidas apenas por uma pequena parte dos engenheiros de rede. Provavelmente, isso ocorre porque todos os seus recursos se combinam em protocolos da camada de transporte ou em protocolos da camada de aplicativo. Porém, com este artigo, você descobrirá toda a beleza dessas duas camadas, aprendendo o que elas fazem e como são implementadas.

## Limitações UDP

De volta ao curso CCNA, descobrimos que o único lugar em que podemos ver as camadas de sessão e apresentação realmente implementadas é quando são baseadas no transporte UDP. O UDP deixa algum espaço para essas duas camadas (se comparado ao TCP) porque é *extremamente simples* e *carece de recursos* . Esses recursos podem ser implementados nas camadas superiores individualmente, adicionando modularidade. Apenas para refrescar sua mente, o UDP tem as duas limitações a seguir.



![Limitações do UDP: pedido de segmento e entrega confiável](https://www.ictshore.com/wp-content/uploads/2016/12/1018-01-UDP_limitation.png)O UDP não pode reordenar segmentos nem transmiti-los de forma confiável.



O UDP, por si só, não ordena os pacotes e, portanto, o receptor não pode adivinhar a ordem em que foram enviados originalmente. Além disso, não é confiável, o que é perdido é apenas perdido, nenhum componente UDP acionará uma retransmissão. Adicionar esses recursos, no entanto, aumentaria a complexidade do algoritmo por trás do UDP em execução em hosts e adicionaria campos extras no cabeçalho UDP enviado com cada segmento. Tudo isso, e especificamente os bytes extras adicionados ao cabeçalho do segmento, é chamado de **sobrecarga** : a quantidade extra de informações que permite que os dados do aplicativo sejam entregues corretamente. Nosso objetivo é obter a entrega dos dados do aplicativo da maneira que desejamos, com *o mínimo de sobrecarga possível* .



No artigo sobre [TCP avançado](https://www-ictshore-com.translate.goog/free-ccna-course/transmission-control-protocol-advanced/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) , já explicamos como podemos reduzir o overhead do TCP usando ACK seletivo e compactação de cabeçalho, mas todos esses itens complexos não podem reduzir o cabeçalho TCP ao tamanho de um cabeçalho UDP. Em vez disso, com UDP, seguimos uma abordagem diferente: partimos de quase nenhum recurso (apenas entrega para o aplicativo correto usando números de porta) e *adicionamos os recursos de* que precisamos nas camadas superiores.

## Camada de sessão

A camada de sessão é aquela que implementa sessões de aplicação um a um: ela define a retransmissão de dados, o método de ordenação de segmento e controla a comunicação em geral. Todos esses recursos são cobertos pelo TCP para aplicativos que usam esse protocolo de transporte, mas os aplicativos que aproveitam o UDP precisam implementar esses recursos de forma autônoma (dentro do aplicativo) ou contar com um protocolo extra especificamente localizado na camada de sessão. Muitos aplicativos (como TFTP) contam com a primeira opção, enquanto a segunda alternativa é a privilegiada para VoIP. Para tráfego VoIP, o protocolo que usamos para a sessão é o **protocolo de transporte em tempo real (RTP)**. Como estamos falando sobre aplicativos que usam UDP como seu transporte subjacente, gastar algum tempo em RTP certamente vale a pena, já que Voz e Vídeo são os aplicativos principais entre todos *os aplicativos baseados em UDP* .

![Cabeçalho do protocolo de transporte em tempo real](https://www.ictshore.com/wp-content/uploads/2016/12/1018-02-UDP_RTP_Frame.png)O protocolo de transporte em tempo real estende o cabeçalho UDP.

O cabeçalho RTP na imagem é inserido logo após o cabeçalho UDP e adiciona recursos extras, como a reordenação de segmentos e sua temporização, que são extremamente importantes para um aplicativo que deve ser executado em tempo real. Aqui está a explicação de seus campos.

- **Versão** - Versão do RTP, a atual é a versão 2
- **P (preenchimento)** - Sinalizador usado para indicar se o preenchimento está presente ou não no segmento
- **X (extensão)** - sinalizador usado para indicar se o cabeçalho da extensão está presente ou não
- **CC (contagem CSRC)** - Número de identificadores CSRC contidos no cabeçalho
- **M (Marcador)** - Sinalizador que, se definido, indica que este segmento tem alguma relevância especial para a aplicação
- **PT (Payload Type)** - indica o tipo de payload RTP (por exemplo, para VoIP / fluxo de vídeo)
- **Número de sequência** - Usado do receptor para reordenar pacotes, incrementado em um a cada segmento enviado
- **Timestamp** - Horário em que o segmento foi criado, usado para permitir que o receptor reproduza o conteúdo do segmento (assumindo que seja áudio ou vídeo) no intervalo adequado
- **SSCS** - Identificador de fonte de sincronização, identifica um fluxo de segmentos UDP / RTP
- **CSRC** - Contribuindo com IDs de fontes, indica a fonte do fluxo de áudio, vários CSRCs podem ser especificados se houver várias fontes (por exemplo, em uma conferência de três partes)
- **Extensão do cabeçalho** - cabeçalho extra, opcional e específico do perfil

Esses campos são o mínimo necessário para permitir a transmissão e são projetados especificamente para fluxos em tempo real, áudio e vídeo, principalmente. Olhando para o cabeçalho, você ainda pode encontrar o número de sequência como no TCP, mas *nenhum número de confirmação* . Isso ocorre porque o RTP permite que o receptor **reordene os segmentos**, mas não para providenciar uma retransmissão. Esse comportamento é propositalmente projetado dessa forma, já que uma chamada VoIP ou um stream de vídeo precisa ser entregue agora. Caso algo se perca, não haja tempo para retransmitir, o show deve continuar. Se o retransmitirmos, chegará tarde demais, então não haverá nenhum ponto na retransmissão. Outro campo interessante que adiciona um recurso que falta ao UDP é o timestamp, com esse campo você pode saber quando o conteúdo foi gerado e reproduzir o som e o vídeo **no mesmo intervalo em** que foi gerado. Caso contrário, você teria fluxos de áudio e vídeo *aumentando e diminuindo a velocidade de* acordo com a conexão de rede disponível.

Uma pergunta que me fizeram várias vezes ao falar sobre reordenar pacotes é *"Como eles chegaram na ordem errada em primeiro lugar?"* e esta é certamente uma boa pergunta. A resposta tem muito a ver com **roteamento** , portanto, está na **camada de rede**na pilha OSI. Os roteadores funcionam independentemente dos protocolos e aplicativos da camada superior, eles são executados com base no endereçamento e nas rotas IP. Pode acontecer que um nó falhe na rede e o tráfego tome um caminho diferente para evitar cair no link defeituoso ou simplesmente um roteador descubra um caminho melhor para um destino. Como tudo isso acontece de forma dinâmica, em um determinado momento o tráfego pode passar por um link e um segundo depois por outro. Nem todos os links têm a mesma velocidade, portanto, é possível que um segmento enviado posteriormente, mas por um link rápido, chegue antes de um segmento enviado anteriormente, mas em um link lento. Vamos dar uma olhada na imagem a seguir.

![Segmentos em caminhos diferentes](https://www.ictshore.com/wp-content/uploads/2016/12/1018-03-Different_put.png)Os segmentos podem seguir um caminho diferente na Internet.

Dispositivos de borda (computadores, servidores) não sabem sobre a infraestrutura de rede, então eles apenas sabem que *existe a possibilidade de* segmentos serem desordenados durante a transmissão por caminhos diferentes. Por isso, eles têm que implementar *mecanismos de reordenamento* . A reordenação é crucial para quase qualquer aplicativo; para transferir um arquivo, precisamos saber a ordem de sua parte e, para transferir o fluxo de áudio, precisamos saber em que ordem reproduzir os sons.

## Apresentação para aplicativos em tempo real

A camada de apresentação é provavelmente a mais misteriosa. Isso ocorre porque quase nenhum aplicativo o implementa, nem entre os aplicativos UDP. O que essa camada faz é definir como os dados devem ser apresentados ao aplicativo. Mais uma vez, vindo para nos resgatar, temos VoIP e stream de vídeo, os que mais aproveitam esta camada. Basicamente, quando você faz uma chamada VoIP, existem alguns parâmetros envolvidos no fluxo de áudio, como a taxa de bits ou a taxa de compressão, apenas para citar alguns. Para ter o fluxo de áudio mais suave possível, todas as partes envolvidas devem concordar sobre como irão trocar áudio e vídeo. RTP é o terreno comum que não pode ser alterado, aqui estamos falando sobre como escrever a carga útil do segmento RTP. Em outras palavras, estamos definindo o codec.

![Codecs de áudio G.711 e iLBC](https://www.ictshore.com/wp-content/uploads/2016/12/1018-04-Audio_codec.png)G.711 e iLBC são dois codecs de áudio usados para transmitir voz sobre IP.

Alguns codecs podem privilegiar a compressão, usando menos largura de banda, mas mais recursos computacionais, outros podem usar muita largura de banda, mas quase nenhum recurso computacional ou outros requerem menos recursos, sacrificando a qualidade do áudio. Nenhuma escolha pode ser certa em todas as ocasiões, o melhor codec para qualquer situação depende das suas necessidades.

## Camadas de sessão e apresentação na sombra

Agora sabemos do que realmente tratam essas duas camadas, mas vamos parar um momento para verificar por que elas não são famosas como as outras camadas OSI. Ainda antes tivemos a chance de entender como quase não há necessidade de implementá-los, pois seus recursos são abordados em outro lugar, porém é hora de dar alguns exemplos, como na figura a seguir.

![Camadas de sessão e apresentação](https://www.ictshore.com/wp-content/uploads/2016/12/1018-05-session_and_presentation_shadow.png)As camadas de sessão e apresentação são combinadas com as camadas de transporte e aplicação na maioria das vezes, especificamente com TCP.

O que a imagem diz também está listado abaixo com um pouco mais de detalhes.

- **HTTP (protocolo de transferência de hipertexto)** - usado para transferir páginas da web, a camada de sessão é controlada por TCP, embora não haja necessidade de uma camada de apresentação, pois as informações são enviadas em texto simples ou binário bruto
- **FTP (File Transfer Protocol)** - usado para transferir arquivos de e para um servidor, a camada de sessão é tratada por TCP, embora não haja necessidade de uma camada de apresentação, pois as informações são enviadas em binário bruto
- **SMTP (Simple Mail Transfer Protocol)** - Usado para enviar e-mails de um servidor para outro, a camada de sessão é tratada por TCP enquanto não há necessidade de uma camada de apresentação, pois as informações são enviadas em texto simples
- **SSH (Secure Shell)** - usado para se conectar a um dispositivo remoto e controlá-lo por meio de comandos textuais usando criptografia, a camada de sessão é tratada por TCP, embora não haja necessidade de uma camada de apresentação, pois as informações são enviadas em texto simples
- **IMAP (Internet Message Access Protocol)** - usado para se conectar a um servidor de e-mail e verificar e-mails, a camada de sessão é gerenciada por TCP, embora não haja necessidade de uma camada de apresentação, pois as informações são enviadas em texto simples
- **VoIP (Voice over IP)** - Este não é um protocolo real, mas sim um tipo de aplicativo, o RTP gerencia a camada de sessão enquanto a camada de apresentação existe e é gerenciada na camada de aplicativo

Este artigo era muito leve, assim como o UDP. Com esse conhecimento, você conhece todas as diferenças entre UDP e TCP e está pronto para discutir as tecnologias implementadas em uma rede para suportar aplicações modernas. Nos artigos a seguir, começaremos a ver alguns protocolos da camada de aplicativo antes de nos aprofundarmos nos itens de configuração.