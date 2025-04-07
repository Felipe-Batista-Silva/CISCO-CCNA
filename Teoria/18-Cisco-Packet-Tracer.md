# Prático: como usar o Cisco Packet Tracer para o CCNA



Obter seu CCNA é muito mais fácil se você tentar o que aprender. Comprar equipamento de verdade pode ser caro, especialmente se você for usá-lo apenas para a certificação. Felizmente, a Cisco nos ajuda com um software de simulação de rede chamado Packet Tracer. Este software foi projetado especificamente para treinamento e permite que você crie uma rede corporativa simulada em poucos minutos. Neste artigo, ajudaremos você a colocar seu Packet Tracer em execução em todos os laboratórios que encontrará no curso CCNA.

## A necessidade de prática

O conhecimento que você obtém no campo é diferente do que você obtém nos livros. Você pode considerar essa afirmação como sempre verdadeira, mas em redes, é extremamente verdadeira. Para configurar *uma rede corporativa* , você deve conhecer muito bem todos os *comandos de configuração* e a lógica por trás deles. Não existem atalhos para conhecer lógica e conceitos, mas com o comando, é um pouco diferente. Em vez de memorizar todos os comandos *palavra por palavra* , se você entender como o dispositivo Cisco os processa, você poderá fazer a configuração de qualquer maneira. Você pode obter dicas pelo sistema operacional e pode contar com o Google para pesquisas rápidas. Além disso, a prática do mundo real permite que você **não explodir sua rede para uma distração**. Existem muitos itens que você conhece, mas que pode esquecê-los quando estiver fazendo a configuração.



Em nosso curso CCNA você pode encontrar muitas dicas para evitar erros, mas a prática é o negócio real. Você tem várias opções para aplicar o que aprendeu:

- Treinamento no local de trabalho - se você já estiver trabalhando em Networking ou TIC
- Software de simulação, como o Cisco Packet tracer
- Software de emulação, como GNS3

A Cisco desenvolveu o Packet Tracer especificamente para **treinamento em nível de CCNA** e é por isso que o escolhemos. Embora o Packet Tracer não possa ajudá-lo com os laboratórios CCNP, é ótimo experimentar coisas de nível CCNA. Mais do que isso, provavelmente é o mais simples de usar e configurar: baixe, instale, pronto. Antes de entrar nos laboratórios, como faremos nos artigos a seguir, é hora de colocar nosso Packet Tracer em execução.

## Bem-vindo ao Cisco Packet Tracer

### Obtenha o Packet Tracer

A primeira coisa que você precisa fazer é **baixar o Cisco Packet Tracer** . Você pode encontrá-lo gratuitamente no site da Cisco Networking Academy [nesta página](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.netacad.com/) . Você só precisa se inscrever para a [campanha de treinamento](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.netacad.com/) do Cisco Packet Tracer com nome e e-mail, então você será redirecionado para o curso de introdução. A partir daí, clique no link “Baixar Packet Tracer” na página principal. Selecione a versão que deseja baixar, de acordo com seu sistema operacional *(Windows? Linux? 64 ou 32 bits?)*e o download começará. Depois de baixar o software, basta instalá-lo. A instalação é um processo seguinte, sem necessidade de recursos avançados como configuração de driver, serviços de rede ou daemons. Feito isso, basta iniciar o software para que possamos dar uma olhada em sua interface.

![Faça o download do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-01-Download_packet_tracer.png)Depois de ingressar no programa de treinamento, você poderá baixar o Packet Tracer seguindo o link dedicado.

*Dica extra: você também pode obter o Packet Tracer para dispositivos móveis, existe uma versão para Android e uma versão para Apple IOS. A Cisco oferece códigos QR apontando para o aplicativo (na Play Store e na Apple Store).*

*Observação: o Packet Tracer pedirá que você se inscreva com sua conta Netacad (aquela que você acabou de criar ao inscrever-se no curso) sempre que iniciar o software. Você pode evitar o login todas as vezes, desconectando seu PC da Internet ao iniciar o Packet Tracer. Você pode conectá-lo novamente assim que for aberto.*

### Packet Tracer 101

Para nosso curso CCNA, estamos usando o **Cisco Packet Tracer 7** . Esta versão apresenta muitos recursos interessantes, como os dispositivos da Internet das Coisas (IoT). A partir desta versão, ao iniciar o software, você deve fazer login com uma **conta Cisco Netacad** para desbloquear todos os recursos. Se você não tem, pode registrar um novo gratuitamente: isso será útil caso você queira seguir algum treinamento oficial também. Ao abrir o rastreador de pacote pela primeira vez, você será solicitado a *conceder acesso à rede* pelo Firewall do Windows. Verifique as redes públicas e privadas e pressione OK, para que você possa usar o Packet Tracer com seus amigos para trabalharem juntos na mesma rede (não é necessário se você planeja trabalhar apenas em seu PC).

![Interface inicial do Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-02-Packet_tracer_interface.png)Isso é o que você vê quando inicia o Cisco Packet Tracer. Uma área de desenho bem grande em branco e vários menus na parte superior, direita e inferior. Abordaremos esse menu em breve.

Com o Packet Tracer, você pode desenhar uma rede, configurá-la e ver como funciona. Você pode até mesmo salvá-lo em um arquivo e carregá-lo mais tarde. Vamos dar uma olhada na **interface que** aparece quando você inicia o software. Como você pode ver, temos uma grande janela branca no meio com vários comandos e menus ao redor. *No topo* , você tem a lista de comandos que você pode encontrar em qualquer programa: Arquivo, Editar, Opções e assim por diante. Então, na barra de ferramentas superior azul, você tem alguns atalhos para comandos que você pode encontrar nos menus acima.

![Menu superior e barra de ferramentas do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-03-Packet_tracer_top_menu.png)Na parte superior da interface do Packet Tracer, você encontra o menu suspenso clássico e alguns atalhos na barra azul.

### Barra de ferramentas de topologia

Logo abaixo da barra de ferramentas superior azul, você pode encontrar um grande painel amarelo. Esta é a **barra de ferramentas** da **topologia** , contendo informações úteis sobre o seu desenho. Você vai contar com essas informações se quiser formatar seu arquivo de forma limpa, com uma imagem de fundo e assim por diante. No entanto, para o uso normal do Cisco Packet Tracer, *você não precisa se preocupar com esta barra* .

![Barra de ferramentas de topologia lógica do Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-04-Packet_tracer_topology_menu.png)Esta é a barra de ferramentas Topologia do Packet Tracer com a guia “Lógica” selecionada.

A *alternância* entre a topologia Lógica e Física é o elemento mais à esquerda da barra. Você pode usá-lo para alternar entre a topologia lógica (ícone com três pontos) ou a topologia física (ícone do servidor).

![Cisco Packet Tracer alternar entre topologia lógica e física](https://www.ictshore.com/wp-content/uploads/2017/01/1022-05-Switch_between_physical_and_logical.png)Alterne entre topologia lógica e física.

Além disso, vamos usar a **topologia lógica** quase o tempo todo. Isso ocorre porque aqui podemos ver a interconexão lógica entre os dispositivos e trabalhar com um fundo branco limpo. Só para você saber, na topologia física vemos os mesmos dispositivos em racks e wiring closets. Aqui está uma captura de tela de um arquivo **totalmente** novo com **a** guia de **topologia física** selecionada.

![Topologia física do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-06-Physical_topology_pane.png)Na topologia física, você pode ver cidades fictícias, edifícios e wiring closets.

### O menu Desenho

À direita da área de desenho, temos o **menu de desenho** , contendo algumas ferramentas para enriquecer seu projeto. Você pode usar este menu para colocar notas de texto no desenho, adicionar formas geométricas e redimensioná-las. Dentro deste menu, você também pode encontrar algumas ferramentas não relacionadas ao desenho, mas sim à inspeção de pacotes. Por exemplo, com a ferramenta *“Inspecionar”* , você pode verificar os dados que trafegam em um cabo. A inspeção de pacotes é um recurso muito interessante do Cisco Packet Tracer, e veremos isso mais adiante neste artigo.

![Menu de desenho do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-07-Packet_tracer_left_menu.png)Este é o “menu de desenho” padrão do Cisco Packet Tracer.

De cima para baixo, os comandos disponíveis são estes: *Selecionar, Colocar nota, Excluir, Inspecionar, Desenhar um polígono, Redimensionar forma, Adicionar PDU simples e Adicionar PDU complexo* .

### Barra de ferramentas em tempo real e modo de simulação

Logo abaixo da janela de desenho, encontramos outra *barra de ferramentas amarela* . Este é sobre o modo que queremos que nossos dispositivos se comportem. Podemos alternar entre dois modos, tempo real e simulação. No **modo em tempo real** , os dispositivos reagem imediatamente aos seus comandos, assim como os dispositivos do mundo real. Você pode até mesmo adiantar o tempo, por exemplo, para pular o processo de inicialização. No **modo de simulação** , em vez disso, você deve pressionar um botão para passar para o próximo instante. Isso permite que você inspecione os dados que trafegam nos cabos e é muito útil para *fins de* depuração e *aprendizado* .

![Barra de ferramentas de cronometragem do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-08-Timing_panel.png)Use a barra de ferramentas de modo para jogar com as opções de tempo.

Se você estiver no modo de tempo real, no canto esquerdo deste painel, você encontrará o tempo decorrido desde a criação do arquivo Packet Tracer atual. Incrementos de tempo, segundo a segundo, somente se você mantiver o arquivo aberto. Além disso, você tem a opção de **desligar e ligar os** dispositivos ou **avançar o** tempo. Clicar em *“Dispositivos de ciclo de energia”* fará com que todos os dispositivos sejam reinicializados imediatamente.

Se você alternar para o **modo de simulação** , encontrará um novo painel à direita. Neste painel, você pode ver uma lista de pacotes enviados pela rede e controlar a maneira como o Packet Tracer coleta essas informações. Com os *“Play Controls”* , você define como o tempo passa. Para fazer isso, você tem duas opções: encaminhamento manual ou encaminhamento automático. Com o encaminhamento manual, você deve pressionar o botão *“Capturar / Encaminhar”* para ver a próxima etapa de um pacote. Em vez disso, com *“Auto Capture / Play”* isso será feito de forma automática e lenta. Use a barra abaixo para ajustar a velocidade. Abaixo disso, você também pode definir filtros para especificar quais pacotes deseja ver.

![Menu de simulação do Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-09-Simulation_menu.png)Este é o menu de simulação do Cisco Packet Tracer.

### Menu do dispositivo

Mantivemos o menu mais importante por último: a **barra de ferramentas** do **dispositivo** . Na parte inferior da interface do Packet Tracer, temos uma grande barra que podemos usar para inserir dispositivos na imagem. Depois de adicionar um dispositivo a partir daqui, seremos capazes de controlá-lo a partir da janela de desenho. Antes de falar sobre isso, vamos dar uma olhada nesta barra de ferramentas.

![Barra de ferramentas do dispositivo Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1022-10-Device_panel.png)Barra de ferramentas do dispositivo Packet Tracer com “Dispositivos de rede” selecionados.

A partir da captura de tela, esta barra de ferramentas está dividida em duas partes. À esquerda, temos duas linhas de ícones: a *categoria superior* está no topo e a *subcategoria* está na parte inferior. Se você passar o mouse sobre qualquer ícone nessas duas linhas, verá a descrição no retângulo branco que separa a linha. Dependendo da combinação de categoria e subcategoria, o Packet Tracer apresentará diferentes dispositivos na parte direita da barra de ferramentas. Não faz sentido listar todos os dispositivos disponíveis neste artigo; é muito mais fácil explorar as várias guias. No entanto, o Packet Tracer contém vários modelos de switches, roteadores, dispositivos finais e - a partir da versão 7 - *dispositivos IoT* .

Para *começar* , aqui estão as categorias de dispositivos mais importantes com as quais trabalharemos. Acima de tudo, vamos usar dispositivos de rede. Então, há duas outras categorias que devemos usar com eles: dispositivos finais e conexões. Em dispositivos finais (o ícone do computador), você pode encontrar computadores, smartphones e servidores. **Em** vez disso, as **conexões** são representadas por um parafuso laranja e você as usa para interconectar outros dispositivos.

## Adicionar e conectar dispositivos

### Como adicionar dispositivos na janela de desenho

Agora que sabemos como o Packet Tracer funciona, é hora de adicionar alguns dispositivos! Depois de adicionar um dispositivo à janela de desenho, você poderá controlá-lo. Portanto, usando o painel de dispositivos que já explicamos, selecione **Dispositivos finais> Dispositivos finais** . Em seguida, arraste dois “PCs genéricos” para a sua área de desenho. Depois disso, vá para **Dispositivos de rede> Switches** e arraste o switch chamado 2960 (2960-24TT) para a imagem. Para simplificar, os colocamos em forma de triângulo.

![Cisco Packet Tracer: como adicionar dispositivos](https://www.ictshore.com/wp-content/uploads/2017/01/1022-11-Adding_devices.png)Dois PCs e um switch adicionados ao Cisco Packet Tracer.

### Como conectar dispositivos juntos

Agora que adicionamos os dispositivos, precisamos conectá-los. Para fazer isso, selecione a categoria **Conexões> Conexões** . Agora temos várias possibilidades, entre elas você pode fazer o Packet Tracer decidir qual cabo se adapta melhor a cada condição. No entanto, por hoje vamos usar um cabo direto de cobre simples (a linha sólida preta). Você sabe pelos artigos anteriores que um dispositivo pode ter *várias NICs* , então como selecionamos aquela para conectar o cabo? É extremamente simples. Basta selecionar o cabo e clicar no dispositivo que deseja conectar: será aberto um menu com todas as interfaces disponíveis.

![Cisco Packet Tracer: como adicionar cabos](https://www.ictshore.com/wp-content/uploads/2017/01/1022-12-Adding_cables.png)A partir das interfaces / portas disponíveis, você pode selecionar o que você precisa.

Para este exemplo, iremos nos conectar `PC0 FastEthernet 0`a `Switch FastEthernet 0/1`e `PC1 Fast Ethernet 0`a `Switch FastEthernet0/2`. Assim que conectar os cabos, você verá alguns pontos coloridos em suas pontas, conforme figura abaixo.

![Cisco Packet Tracer: pontos laranja nos cabos](https://www.ictshore.com/wp-content/uploads/2017/01/1022-13-Wait_for_spanning_tree.png)Os dispositivos agora estão conectados.

Os dados podem viajar por um cabo apenas se os dois pontos nele forem verdes. No entanto, ao conectar os cabos, você verá o lado do switch ficando laranja. Isso ocorre porque o switch está fazendo algumas verificações antes de ligar a interface, então você só precisa esperar (ou adiantar o tempo). O ponto que indica o status da porta se refere ao status da interface do dispositivo mais próximo. Pode ser de três cores diferentes.

- **Verde** - a porta está funcionando nas camadas 1 e 2 do OSI
- **Laranja** - a porta está ligada, mas o software a está bloqueando
- **Vermelho** - a porta está desligada

Quando suas portas ficarem verdes, você estará pronto para ver como configuramos os dispositivos no Cisco Packet Tracer.

## Configurando dispositivos no Cisco Packet Tracer

### Configurando um Dispositivo de Rede

No Packet Tracer, você trabalhará com uma grande variedade de dispositivos. Portanto, você vai enfrentar diferentes maneiras de configurar dispositivos, dependendo do próprio dispositivo. Existem duas categorias principais de dispositivos: *dispositivos de rede* e *dispositivos* *finais* , cada um com sua própria configuração.

Você vai configurar dispositivos de rede usando a **CLI (Command-Line Interface)** , onde você interage com o dispositivo usando apenas texto. Para acessar a CLI de um dispositivo de rede, basta clicar nele com a ferramenta de seleção. Uma nova janela aparecerá e, a partir de suas guias, basta selecionar CLI. Dessa forma, você obterá acesso de console ao dispositivo.

![Cisco Packet Tracer: gerencie switches via CLI](https://www.ictshore.com/wp-content/uploads/2017/01/1022-14-Controlling_switches.png)Esta é a CLI do nosso switch.

Neste tutorial, não vamos configurar nenhum dispositivo de rede. A única opção que adicionamos funcionará *imediatamente* , sem a necessidade de configuração. Em vez disso, continue lendo para ver como iremos configurar os dispositivos finais.

### Configurando Dispositivos Finais

A configuração dos dispositivos finais é relativamente simples, pois você pode fazer isso completamente na interface gráfica do Cisco Packet Tracer. O mecanismo é sempre o mesmo, basta clicar no dispositivo que deseja configurar e uma nova janela aparecerá. Nessa janela, navegue até a guia de configuração. Lá, precisamos configurar a `FastEthernet 0`interface, então clique nela no menu à esquerda (caso não veja, clique `INTERFACE`nesse menu para ver as interfaces).

![Cisco Packet Tracer: configure o endereço IP em um computador](https://www.ictshore.com/wp-content/uploads/2017/01/1022-15-Configure_IP.png)Esta é a janela que usamos para definir o endereço IP de um dispositivo.

Nesta janela, selecione “Estático” na caixa “Configuração de IP”. Em seguida, configure o PC à esquerda com um endereço IP de `192.168.1.1`e uma máscara de sub-rede de `255.255.255.0`. Depois disso, configure o outro PC com um endereço IP `192.168.1.2`e a mesma máscara de sub-rede do outro. Por enquanto, você não precisa especificar mais nada: você pode apenas fechar essas janelas, o Packet Tracer manterá as alterações feitas.

## Modo de simulação do Packet Tracer

### Preparando-se para a captura

Na rede, chamamos de **captura** do conteúdo de um pacote que capturamos para fins de depuração. Em outras palavras, um pacote está fluindo para um cabo e podemos, de alguma forma, verificar seu conteúdo quando ele está no cabo. O rastreador de pacotes nos permite fazer isso no modo de simulação, mas devemos criar algum tráfego para capturar. A primeira coisa que queremos fazer é mudar para o modo Simulação. Agora, nada pode acontecer a menos que avancemos manualmente o tempo. De qualquer forma, antes disso, precisamos configurar *filtros de captura* para informar ao Packet Tracer que tipo de pacote queremos ver.

![Cisco Packet Tracer: exemplo de modo de simulação](https://www.ictshore.com/wp-content/uploads/2017/01/1022-16-Capture_ARP_and_ICMP.png)Para esta captura, veremos pacotes ARP e ICMP.

Por padrão, o Packet Tracer ouvirá tudo. Para mudar isso, clique em *“Mostrar Todos / Nenhum”* para remover todos os filtros ativos. Em seguida, clique em *“Editar filtros”* para adicionar manualmente ARP e ICMP, que você pode encontrar na guia IPv4. Agora, estamos prontos para gerar o tráfego a ser capturado.

### Gerando tráfego

Para este exemplo, vamos gerar algum tráfego indo de um PC para outro. O tráfego que vamos criar é ICMP, e faremos isso com um **comando ping** . Basicamente, com o ping, um PC pergunta ao outro *"Você está aí?"* e o outro responde.

Selecione o PC à direita, vá para a *guia Desktop* e clique em **Prompt de Comando** .

![Cisco Packet Tracer: guia da área de trabalho no PC](https://www.ictshore.com/wp-content/uploads/2017/01/1022-17-Go_to_command_prompt.png)Esta é a guia da área de trabalho para um PC no Packet Tracer.

Quando o prompt for aberto, execute ping no endereço IP do outro PC. Neste caso, faremos isso com o comando `ping 192.168.1.1`.

![Cisco Packet Tracer: como fazer ping](https://www.ictshore.com/wp-content/uploads/2017/01/1022-18-Pinging.png)Efetuando ping no outro PC no Packet Tracer.

Agora, nada vai acontecer porque o Packet Tracer está esperando que avancemos no tempo. Enquanto isso, se você verificar a área de desenho, verá que dois pacotes estão armazenados em buffer em seu PC, esperando para ir para o cabo.

![Cisco Packet tracer: buffer de pacotes no modo de simulação](https://www.ictshore.com/wp-content/uploads/2017/01/1022-19-Packet_buffer.png)Pacotes no buffer do PC.

Cada protocolo é indicado com uma cor, portanto dois pacotes do mesmo protocolo sempre terão a mesma cor. Nesta figura, existem dois pacotes de duas cores: um é o ICMP e o outro é o ARP. Você pode ver que eles estão esperando para serem enviados por causa do ícone de carregamento de barras em movimento no envelope. Pressione **Capturar / Encaminhar** no menu de simulação para enviar o primeiro pacote para o cabo.

### Verificar o conteúdo dos pacotes

Se você acha que isso é bom, o Packet Tracer tem ainda mais a oferecer. Se você clicar em qualquer envelope, poderá ver todos os seus detalhes, incluindo os cabeçalhos de qualquer camada OSI. Aqui está um exemplo do pacote ARP.

![Cisco Packet Tracer: verifique o PDU](https://www.ictshore.com/wp-content/uploads/2017/01/1022-20-PDU.png)Esta é a PDU ARP coletada com o Packet Tracer.

Agora, é hora de você brincar com esse recurso e ver como as solicitações ICMP acontecem. Lembre-se de verificar o prompt do seu PC assim que terminar para ver os registros das respostas.

## Conclusão

Após este artigo, você agora deve ter o Packet Tracer instalado e funcionando em seu PC. Mais do que isso, você sabe como usar. Isso será extremamente importante à medida que continuarmos com o curso CCNA, já que você usará o Packet Tracer para tentar tudo o que aprender, com a ajuda de nossos laboratórios guiados.