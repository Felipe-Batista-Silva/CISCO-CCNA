# Conceitos de roteamento: como ler a tabela de roteamento



Neste ponto do curso CCNA, sabemos que mudar é uma questão de comunicação local. Os switches conectam dispositivos relativamente próximos: o mesmo escritório, o mesmo prédio e assim por diante. Em vez disso, quando queremos conectar dispositivos remotos, precisamos usar o roteamento. Os roteadores enviam tráfego para outros dispositivos com base nas informações do endereço IP. No centro desse processo, temos a tabela de roteamento. Neste artigo, vamos falar exatamente sobre isso. Veremos como funciona a tabela de roteamento e como lê-la.

Este artigo vem com um laboratório de descoberta. Use o link abaixo para baixá-lo e abri-lo com o Cisco Packet Tracer. Você se beneficiará ao máximo com este artigo se explorar a configuração enquanto a explicamos. Além disso, é grátis!

[![Obtenha este laboratório!  Pratique o que você aprendeu e ganhe experiência com nossos laboratórios de rede e demonstrações - faça o download agora](https://www.ictshore.com/wp-content/uploads/2017/01/get-this-lab.jpg)](https://www-ictshore-com.translate.goog/download/lab-ccna-course-007-read-routing-table/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)

Depois de fazer o download, mantenha-o aberto e continue lendo.

## Introdução ao laboratório Routing Table

### A Topologia

A imagem a seguir mostra a topologia do laboratório que acabamos de baixar.

![Topologia de laboratório, conceitos de roteamento, como ler a tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-01-Lab_topology.png)Esta é a topologia para este laboratório.

Essa infraestrutura é bastante simples, pois contém apenas quatro roteadores. O roteador central, denominado `R0`, tem um cabo que liga a todos os outros roteadores. Cada um deles tem algumas outras redes anexadas *(as nuvens)* . No entanto, se você abrir o Packet Tracer, não verá essas nuvens. Isso ocorre porque estamos emulando redes por meio do uso de *interfaces* de *loopback* .



O conceito de **interface de loopback** pode ser novo para você. Felizmente, é muito simples. Uma interface de loopback é uma interface virtual que você pode criar em roteadores e (alguns) switches. Portanto, é apenas um item lógico completamente gerenciado no nível de configuração. Você pode criar e excluir várias interfaces de loopback, à vontade. Considerando isso, as interfaces de loopback são úteis quando você precisa fazer uma demonstração e um laboratório, como agora. Além disso, você pode usá-los como interfaces de gerenciamento. Por exemplo, um roteador possui várias interfaces com diferentes endereços IP. Para evitar confusão, você pode criar um loopback e atribuir a ele o endereço IP do próprio roteador.

### Os requisitos

Como este é um **laboratório de descoberta** , você não precisará fazer nenhuma configuração ou solução de problemas. Em vez disso, apenas conecte-se aos dispositivos e verifique a configuração ou tente os comandos show. Resumindo, não há requisitos para este laboratório.

## A maneira como um roteador funciona

### A lógica por trás da Tabela de Roteamento

A tarefa de cada roteador é clara: enviar tráfego para o destino correto. Para fazer isso, os roteadores aproveitam sua tabela de roteamento. A tabela de roteamento é exatamente o que o nome diz: uma tabela. Essa tabela, na verdade, é uma **lista de rotas** . Cada rota indica uma sub-rede de destino, bem como a forma de alcançá-la. Especificamente, há apenas duas informações que dizem ao roteador como chegar a um destino. Eles são o próximo salto e a interface de saída.

> Todo pacote recebido pelo roteador será encaminhado de acordo com as informações presentes na tabela de Roteamento.

O **próximo salto** é o endereço IP de um roteador contíguo. Em outras palavras, se dois roteadores estiverem conectados ao mesmo domínio de broadcast da Camada 2, eles serão contíguos. Com essas informações na tabela de roteamento, o roteador sabe que, para essa sub-rede de destino, o tráfego terá que ir para o próximo salto. Observe que o roteador não sabe o que acontecerá com os pacotes depois que eles atingirem o próximo salto. Ele apenas sabe que eles devem ir para lá (para aquele destino dado). Usamos o próximo salto em rotas quando esse próximo salto está em um segmento compartilhado, como links Ethernet.

Em vez disso, podemos usar a **interface de saída** quando temos links ponto a ponto, como Serial. Dessa forma, informamos ao roteador apenas para enviar tráfego de uma interface específica. Já que do outro lado teremos um roteador, e apenas um, ele pegará nosso tráfego e o processará.

#### Um exemplo visualizado

Resumindo, a tabela de roteamento se parece muito com uma série de declarações como *“Para alcançar esta sub-rede, siga este caminho”* ou *“Você pode chegar lá indo primeiro”* . A imagem a seguir mostra exatamente isso, emulando a tabela de roteamento no roteador central.

![O conteúdo da tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-02-The_routing_table.png)A tabela de roteamento visualizada. As setas azuis claras emulam o conteúdo da tabela de roteamento no roteador central.

Dê uma olhada na foto acima. A ideia por trás disso é extremamente simples: a direção da seta indica o próximo salto, enquanto o conteúdo da seta indica o destino. Por exemplo, se olharmos para a seta inferior, sabemos que podemos alcançar a `39.164.80.0/24`sub - rede acessando o roteador na parte inferior direita. O roteador central não sabe exatamente onde está essa sub-rede, apenas sabe que está atrás do roteador no canto inferior direito. Outro exemplo seria `192.168.0.0/16`, que está atrás do roteador à esquerda.

### O processo de pesquisa de rota

#### Visão geral

Agora sabemos que a tabela de roteamento contém todas as informações necessárias para encaminhar um pacote ao destino correto. No entanto, esta é apenas a ponta do iceberg. Precisamos saber *como o roteador usa o conteúdo da tabela de roteamento* .

Antes de começarmos a mergulhar nesse processo, precisamos saber exatamente o que cada rota contém. A tabela de roteamento é uma lista de rotas e, para cada uma, temos a **sub-rede de destino** , sua **máscara de sub-rede** e a **interface de próximo salto / saída** . A isso, podemos adicionar alguns dados sofisticados, como métrica, fonte de roteamento e muito mais, mas isso é para outro artigo.

Quando o roteador recebe um pacote IP, ele compara o cabeçalho do pacote com a tabela de roteamento. Especificamente, o campo a ser correspondido é o **endereço IP de destino** . Para cada rota na tabela de roteamento, o roteador executa um **bit** a **bit-AND** entre o endereço IP de destino e a *máscara de sub-rede* contida na rota. *Não tem certeza do que isso significa?* Temos um [artigo incrível sobre operações bit a bit](https://www-ictshore-com.translate.goog/ict-basics/binary-math-introduction/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) . Se o resultado do bit a bit-AND for exatamente *a rede de destino da rota* , temos uma correspondência. A imagem abaixo explica exatamente isso.

![O processo de pesquisa de rota em relação à tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-03-Route_lookup_process.png)Comparamos o endereço IP de destino do cabeçalho do pacote com a tabela de roteamento. Cada linha é uma rota separada.

Neste exemplo, o endereço IP de destino corresponde à última rota. Portanto, o pacote será enviado de acordo com o próximo salto especificado para aquela rota, que é `10.0.8.1`.

#### Conflitos na tabela de roteamento

Na tabela de roteamento, *cada rota é única* . Isso significa que a combinação da *rede de destino e da máscara de sub-rede* é única. Como resultado, não encontraremos várias rotas com exatamente a mesma rede de destino e máscara de sub-rede. No entanto, uma rota pode conter *vários endereços de próximo salto* para balancear a carga do tráfego entre eles.

No entanto, podemos ter **rotas sobrepostas** . Com eles, uma rota aponta para uma rede alvo que já pode ser alcançada usando a outra rota. De qualquer forma, nesses casos a máscara de sub-rede entre as duas rotas é diferente. A primeira vez que você ler isso, pode parecer confuso. Mas, aqui está um exemplo. Imagine que podemos alcançar `192.168.0.0/16`passando por R1 e `192.168.1.0/24`passando por R2. Se analisarmos a primeira rota, descobrimos que ela cobre qualquer endereço entre `192.168.0.0`e `192.168.255.255`. A segunda rota, em vez disso, é para endereços entre `192.168.1.0`e `192.168.1.255`. Esses endereços são combinados por ambas as rotas! Nesse caso, temos uma sobreposição. Mas não se preocupe, isso é perfeitamente normal.

Quando duas (ou mais) rotas correspondem a um endereço de destino do pacote IP, **a mais específica** é usada. A rota mais específica é aquela com a máscara de sub-rede mais longa. Por exemplo, usando as rotas anteriores, um pacote para `192.168.1.20`irá para R2, enquanto um pacote para `192.168.40.10`irá para R1. *Simples, hein?*

#### A rota padrão

Um caso interessante de rotas sobrepostas é a **rota padrão** . A rota padrão é a de último recurso, aquela a ser usada quando não temos ideia de para onde enviar um pacote. Geralmente, é aquele que aponta para a Internet. Como precisamos que ele corresponda a qualquer coisa para a qual não tenhamos uma rota específica, sempre é `0.0.0.0/0`. Isso corresponderá a qualquer destino único no mundo e se sobreporá a todas as outras rotas. No entanto, se outra rota corresponder também, o roteador usará a rota específica. Isso ocorre porque todas as rotas são mais específicas *(têm uma máscara de sub-rede maior que 0)* .

### Informação de Encaminhamento de Camada 2

Neste ponto, cobrimos todos os fundamentos da tabela de roteamento. No entanto, em roteadores modernos, os pacotes não são comparados a eles. Em vez disso, há outra tabela usada em conjunto com a tabela de roteamento. Para entender isso, primeiro precisamos falar sobre o processo de **reescrita de quadros** .

#### O que é Frame Rewrite?

Os roteadores realizam a reescrita de quadros naturalmente, eles não têm alternativa para fazer isso. **A reescrita de quadros** é o processo de alterar o cabeçalho do quadro da Camada de Link de Dados enquanto mantém o cabeçalho do pacote IP intocado.

Para esclarecer isso, podemos *seguir um pacote ao longo de seu caminho* . Um dispositivo gera um pacote para uma rede remota, sabendo que deve enviá-lo ao seu gateway padrão. Portanto, ele preenche as informações de endereçamento IP com o IP do dispositivo de destino como destino e seu IP como origem. Em seguida, ele coloca o pacote IP em um quadro Ethernet. Para isso, ele usa seu próprio endereço MAC como origem e o endereço MAC de seu gateway padrão como destino. O gateway padrão, que é um roteador, recebe um pacote destinado a si mesmo em L2 e para um dispositivo remoto em L3.

A reescrita de quadros é uma consequência direta do roteamento. Um roteador move pacotes entre diferentes domínios da camada 2, e as informações da camada 2 são significativas apenas dentro do mesmo domínio L2. Portanto, o roteador deve substituí-los por outros válidos. Como resultado, ele usará seu próprio endereço MAC (na interface de saída) como origem e o endereço MAC do próximo salto como destino.

![Reescrita de quadros no processo de pesquisa da tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-04-Frame_Rewrite.png)O roteador do meio está reescrevendo o cabeçalho do quadro.

A partir da imagem, o roteador da esquerda deseja enviar um pacote para o roteador da direita. Deve fluir pelo roteador no meio. Observe como o roteador central altera as informações do cabeçalho Ethernet, enquanto o cabeçalho IP permanece intocado. Os endereços MAC de origem e destino foram alterados.

Além disso, os pacotes podem passar por diferentes transportes da Camada 2 (por exemplo, de Ethernet para Serial), de modo que toda a estrutura da Camada 2 pode mudar. Os roteadores podem cuidar disso reescrevendo o quadro.

#### Tabela de informações de reconfiguração de quadros

Se o roteador continuar olhando para a tabela de roteamento, toda vez que detectar o próximo salto correto, ele deverá criar um novo cabeçalho da Camada 2. Em vez de realizar *a reescrita de quadros em tempo real* , os roteadores modernos implementam uma tabela específica (em hardware), contendo todas as *informações de reescrita de quadros necessárias* . Nós sabemos quais rotas usam qual próximo salto, e sabemos que para alcançar o mesmo próximo salto, o cabeçalho da Camada 2 é sempre o mesmo. Portanto, o roteador prepara um cabeçalho da camada de enlace de dados pronto para a substituição.

No mundo Cisco, isso é chamado de **Express Forwarding** . Com o Express Forwarding, a pesquisa acontece na tabela de roteamento pela primeira vez e todos os outros pacotes para o mesmo destino são processados por hardware. Além disso, os dispositivos Cisco implementam mais um aprimoramento: **CEF (Cisco Express Forwarding)** . Com essa tecnologia, o roteador prepara uma tabela de reconfiguração de quadros (a tabela CEF) antes de receber o tráfego, de forma que mesmo o primeiro pacote seja processado por hardware. Isso acelera muito o roteamento.

O CEF está ativo por padrão na maioria dos dispositivos que o suportam. Se desejar, você pode desligá-lo com o comando de configuração `no ip cef`. Outros fornecedores implementam técnicas semelhantes para aprimorar o desempenho do roteamento.

## A tabela de roteamento no Cisco IOS

Agora é hora de colocarmos nossos equipamentos de laboratório na prática. Abra seu Packet Tracer se ainda não o fez, pois veremos como verificar a tabela de roteamento no mundo real. Você pode se conectar a qualquer dispositivo que desejar, e eu o encorajo a fazer isso, mas observe que R0 (aquele no centro) tem a tabela de roteamento mais completa. Portanto, vamos usar este.

### Como ler a tabela de roteamento

#### Mostrando toda a tabela de roteamento

Se você quiser verificar o conteúdo de toda a tabela de roteamento em um dispositivo Cisco, basta emitir `show ip route`. Este comando está disponível no modo do usuário ( `>`) e no modo exec privilegiado ( `#`). Como resultado, você verá todo o conteúdo da tabela, bem como uma legenda de códigos. Aqui está o exemplo de saída do Roteador 0.

![Use o comando show ip route Cisco IOS para verificar a tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-05-Entire_routing_table.png)Conteúdo da tabela de roteamento em R0.

#### Dividindo a Saída

À primeira vista, a saída pode parecer confusa. Não se preocupe, é muito fácil obter as informações de que precisamos. Primeiro, a Tabela de Roteamento é dividida em seções, que representam uma rede principal. Uma **rede principal** é uma rede classful, para a qual temos pelo menos algumas rotas. Podemos ver um exemplo logo na primeira linha da tabela, conforme destacamos a seguir.

![Principais sub-redes da rede dentro da tabela de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-06-Major_network_subnetting.png)Estas são as três primeiras linhas da tabela de roteamento que vimos anteriormente.

Na primeira linha, nosso roteador está nos informando que a principal rede classful `10.0.0.0/8`está dividida em sub-redes. Além disso, ele nos diz que essas sub-redes não são todas do mesmo tamanho (isso é para *"variavelmente"* ). Bem à esquerda desta linha, não temos nenhuma letra. Isso significa que essa linha é apenas um marcador de posição de seção, não uma rota. Em vez disso, para as duas linhas abaixo, vemos um *“C”* e um *“L”* à esquerda: são rotas. Destacamos a sub-rede de destino em azul claro e a interface de saída em roxo claro.

Aqui temos outro exemplo, desta vez com o próximo salto em vez da interface de saída.

![Rota com interface de saída e próximo salto especificado na Tabela de Roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-07-Next_hop_route.png)Esta rota especifica o próximo salto.

Se você vir “via” em uma rota, então estamos falando de um próximo salto. Nesse caso, a sub `147.31.169.0/24`- rede pode ser acessada `172.16.24.132`.

A tabela de roteamento está no centro dos roteadores, mas, no mundo real, pode conter toneladas de rotas. Portanto, pode ser complexo lê-lo ou encontrar o que queremos. Portanto, basta verificar a próxima seção.

#### Como ajustar a saída da tabela de roteamento

Qualquer engenheiro de rede deve estar muito confortável em navegar na tabela de roteamento. Precisamos ser capazes de apenas ver as rotas que desejamos. O comando para isso ainda é `show ip route`, mas com um pequeno aprimoramento. Desta vez, adicionamos o **endereço IP de destino** logo após o comando. Como resultado, o roteador executará o processo de pesquisa de rota e nos apresentará a melhor rota (mais específica) correspondente. Aqui está um exemplo prático.

![Use show ip route com endereço IP de destino para ver mais informações de roteamento](https://www.ictshore.com/wp-content/uploads/2017/02/1029-08-show_ip_route_target.png)Aqui temos a saída estendida para esse endereço IP específico.

Como você pode ver, aqui podemos encontrar muito mais informações sobre esta rota. No entanto, o básico é sempre o mesmo. Sabemos que é acessível por meio `GigabitEthernet 0/0`de contato `192.168.10.2`. Agora, isso é muito importante: caso não haja uma rota específica para um destino, mas **uma rota padrão esteja presente** , este comando (com o endereço IP de destino) dirá a você *“subnet not in table”* . Portanto, esteja ciente de que você pode usá-lo para fazer a correspondência com todas as rotas, exceto a padrão.

Outra maneira sofisticada de restringir a saída é usar o comando **pipe** . Por enquanto, não explicaremos todos os detalhes sobre isso. No entanto, se você estiver familiarizado com o Linux, saberá que pode usar o caractere de barra vertical seguido por algumas instruções para restringir a saída de um comando. A Cisco é muito semelhante ao Linux nesse sentido. Uma ótima maneira de pular a legenda e apenas ver a tabela de roteamento é usando `show ip route | begin Gateway`. Dessa forma, dizemos ao roteador para começar a mostrar a saída quando encontrar a palavra *“Gateway”* . Observe que isso faz distinção entre maiúsculas e minúsculas, então *“gateway”* não produzirá a mesma saída.

#### A Tabela de Roteamento não é perfeita

A tabela de roteamento funciona extremamente bem. Afinal, é tão simples. Podemos esperar que o tráfego vá para onde a tabela de roteamento diz 100% do tempo. Porém, o que faz a diferença é para onde a tabela de roteamento leva suas informações. A tabela de roteamento é **preenchida por várias fontes** : links conectados, rotas configuradas manualmente e protocolos de roteamento dinâmico. Qualquer configuração errada para esses itens pode resultar em rotas erradas inseridas na tabela de roteamento.

Resumindo, se o roteador está enviando tráfego para um caminho errado, é porque o configuramos errado. Portanto, se você vir uma rota na tabela de roteamento, saberá que o tráfego seguirá para cá. Em vez disso, você não pode dizer pela tabela de roteamento se o tráfego *deve* seguir esse caminho ou não. Você apenas sabe que vai.

## Conclusão

Agora, reserve um minuto para se familiarizar com a tabela de roteamento do Packet Tracer que você baixou. Neste artigo, cobrimos todos os princípios básicos de que você precisa para trabalhar com a tabela de roteamento e, o mais importante, a lógica por trás dela. Apenas para recapitular:

- A tabela de roteamento contém rotas, que instruem os roteadores sobre para onde enviar o tráfego
- Cada rota tem uma rede de destino, uma máscara de sub-rede e um próximo salto ou uma interface de saída
- Na tabela de roteamento, duas rotas idênticas não podem existir, mas duas (ou mais) rotas sobrepostas podem
- Os roteadores realizam a reescrita do quadro ao fazer o roteamento para adaptar o cabeçalho do quadro da camada 2 ao novo segmento de rede
- O CEF (Cisco Express Forwarding) armazena em cache as informações de reescrita de quadros, você pode desligá-lo com o `no ip cef`comando
- Use `show ip route`para verificar o conteúdo da tabela de roteamento

Leve todo o tempo necessário para revisar este artigo. Esses conceitos não são apenas extremamente úteis quando você está trabalhando, mas também são muito importantes na certificação! Quando estiver confiante, continue com o curso CCNA e descubra o outro lado da tabela de roteamento!