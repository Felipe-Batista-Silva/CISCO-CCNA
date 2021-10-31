# Configuração de rotas estáticas e outras fontes de roteamento



Ler a tabela de roteamento é apenas a primeira parte. Precisamos entender de onde a tabela de roteamento obtém suas rotas e como ela escolhe uma em vez da outra. Além disso, você precisa ser capaz de configurar rotas manualmente. Se você deseja começar a manipular a tabela de roteamento, este artigo é para você. Abordaremos a configuração de rotas estáticas em um dispositivo Cisco e, em seguida, exploraremos todos os detalhes da tabela de roteamento que ainda não cobrimos no artigo anterior. Abordaremos tópicos importantes como distância administrativa, rotas métricas e flutuantes.

Como este é um artigo de configuração e descoberta, ele vem com um laboratório do Packet Tracer. Você pode baixá-lo gratuitamente usando o link abaixo, e eu encorajo você a fazer isso! Dessa forma, você vai se beneficiar ao máximo com este artigo, pois vai experimentar o que aprender na hora que estiver aprendendo.

[![Obtenha este laboratório!  Pratique o que você aprendeu e ganhe experiência com nossos laboratórios de rede e demonstrações - faça o download agora](https://www.ictshore.com/wp-content/uploads/2017/01/get-this-lab.jpg)](https://www-ictshore-com.translate.goog/download/lab-ccna-course-008-static-routes-configuration/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)

Depois de fazer o download, basta abrir o laboratório Cisco Packet Tracer e seguir as instruções que encontrar neste artigo.

## Introdução ao laboratório de rotas estáticas

### A Topologia

Neste artigo, trabalharemos com a topologia a seguir.

![Topologia do Static Routes Lab no Cisco Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/02/1030-01-Lab_topology.png)A topologia para este laboratório.

A topologia para este laboratório é bastante simples, mas interessante. Para isso, temos um roteador no site principal - HQ, e uma rota remota - Filial. A filial está conectada apenas ao HQ, mas o HQ tem dois provedores de Internet diferentes conectados à Internet. Nesse cenário, queremos estabelecer a comunicação e o roteamento da melhor maneira possível.



### Os requisitos

Este laboratório vem com o roteamento do provedor já configurado. No entanto, o lado do cliente da rede não tem roteamento. Como resultado, você precisará criar novas rotas estáticas nos roteadores Branch e HQ. Para acelerar as coisas, nós pré-configuramos os endereços IP nas interfaces, de modo que você precise *configurar apenas as rotas* .

Para este laboratório, estamos *emulando duas LANs* : Branch LAN e HQ LAN. Para fazer isso, aproveitamos a interface `Loopback 0`nos roteadores Branch e HQ. Consideraremos isso como a rede de escritórios na Agência e na HQ, respectivamente.

Como um requisito de uma perspectiva de roteamento, tudo deve ser capaz de se comunicar com tudo. Especificamente, a Filial deve ser capaz de se comunicar com a Internet e a LAN HQ. Além disso, queremos adicionar alguma redundância: o HQ deve se conectar à Internet usando o Provedor 1, a menos que o link esteja inativo. Se for esse o caso, ele deve recorrer *automaticamente* ao segundo provedor. Devemos conseguir tudo isso com rotas estáticas.

Verifique a tabela a seguir para entender o plano de endereçamento.

| Sub-rede        | Descrição                                                    |
| --------------- | ------------------------------------------------------------ |
| `10.0.1.0/24`   | Link entre HQ e Provedor 1, onde HQ é `.1`e Provedor é`.2`   |
| `10.0.2.0/24`   | Link entre HQ e Provider 2, onde HQ é `.1`e Provider é`.2`   |
| `10.0.3.0/24`   | Link entre Filial e HQ \, onde Filial está `.1`e Provedor está`.2` |
| `10.10.0.0/24`  | Emulado HQ LAN (Use `.1`endereço para testes)                |
| `10.11.0.0/24`  | Filial LAN emulada (usar `.1`endereço para testes)           |
| `94.11.68.0/24` | Internet emulada (usar `.1`endereço para testes)             |

Plano de Endereçamento

## Compreendendo as fontes de roteamento

Antes de mergulharmos na configuração de rotas estáticas, precisamos entender como a tabela de roteamento é criada. Para fazer isso, precisamos voltar para onde a tabela de roteamento leva seu conhecimento. Estamos falando sobre fontes de roteamento.

### As fontes

A tabela de roteamento tem um único propósito: *encaminhar o tráfego para o destino certo* . Por si só, não implementa nenhuma estratégia de fallback em caso de falha de link, nem a troca de atualizações com outros roteadores. Em vez disso, a tabela de roteamento fica em cima disso. Os roteadores mantêm sua tabela de roteamento sempre atualizada, de forma que o tráfego vá para o destino correto a cada momento. Para fazer isso, eles modificam a tabela de roteamento de acordo com as atualizações das fontes de roteamento.

*Então, quais são as fontes de roteamento?* Uma fonte de roteamento é **qualquer coisa que pode injetar uma rota** na tabela de roteamento. Por exemplo, pode ser um protocolo de roteamento dinâmico (como EIGRP, BGP, OSPF, RIP e assim por diante). Outro tipo de fonte de roteamento são as rotas estáticas, que você deve configurar manualmente. O último tipo de fonte de roteamento são as rotas conectadas, que abordaremos em breve.

![A tabela de roteamento obtém suas rotas de várias fontes de roteamento, como protocolos dinâmicos, rotas estáticas ou rotas conectadas](https://www.ictshore.com/wp-content/uploads/2017/02/1030-02-Routing_sources.png)Fontes de roteamento diferentes recebem informações diferentes como entrada e, em seguida, enviam algumas rotas para a tabela de roteamento.

A imagem acima mostra o processo que coloca as rotas nas tabelas de roteamento. Usando protocolos de roteamento dinâmico, os roteadores trocam informações de roteamento. Cada protocolo de roteamento mantém algumas informações em cada roteador e, em seguida, algumas dessas informações são convertidas em rotas para a tabela de roteamento. Como não precisamos considerar como os protocolos de roteamento funcionam, isso é bastante simples por enquanto.

#### Rotas conectadas e locais

Devemos falar mais algumas palavras sobre rotas conectadas e locais. O roteador descobre automaticamente essas rotas e mantém a tabela de roteamento atualizada de acordo. Além disso, *você não pode fazer nada a respeito* : você não pode alterar esse comportamento, nem influenciá-lo de forma alguma.

Para cada interface com um endereço IP no estado up / up, o roteador injeta uma **rota conectada** na tabela de roteamento. Ele usa o endereço de sub-rede como o endereço de destino e a interface com esse IP como a interface de saída. Por exemplo, se você configurar o endereço IP `192.168.1.1`com uma máscara de `255.255.255.0`sobre `GigabitEthernet 0/0`, a rota conectado relacionado será `192.168.1.0/24 via GigabitEthernet 0/0`. Essas rotas permitem a comunicação com os vizinhos.

Para cada rota conectada, os roteadores geram também uma **rota local** . Esta rota aponta para o endereço IP do próprio roteador nessa sub-rede e sempre tem uma máscara de host ( `/32`). Com as rotas locais, o roteador sabe que o tráfego para um endereço IP específico é para ele mesmo. Considerando o exemplo anterior, o roteador irá gerar uma rota local de `192.168.1.1/32 via GigabitEthernet 0/0`. A interface de saída, na realidade, não é usada porque o tráfego permanece dentro do roteador.

As rotas conectadas e locais são **atualizadas dinamicamente** . Cada vez que um link cai, o roteador remove sua rota conectada e local da tabela de roteamento. Assim que voltar, o roteador colocará as rotas de volta. Este é um comportamento automático que você não pode configurar, pois a mudança pode interromper a lógica de roteamento.

### Processo de Seleção de Rota

Com tantas fontes de roteamento, é extremamente provável que surjam alguns **conflitos** . Felizmente, os roteadores Cisco estão equipados com várias estratégias para determinar qual rota é a melhor, em qualquer condição. Lembre-se de que duas rotas para o mesmo destino não podem viver juntas na tabela de roteamento. Apenas para esclarecer que, duas rotas são para o mesmo destino se forem idênticas na rede de destino e na máscara.

Primeiro, cada protocolo de roteamento faz uma seleção interna. Isso acontece de maneiras diferentes, dependendo do protocolo de roteamento. De qualquer forma, o objetivo disso é apresentar apenas as melhores rotas para a tabela de roteamento. O mesmo protocolo não apresentará duas rotas conflitantes, mas podem surgir conflitos entre protocolos diferentes.

#### A Distância Administrativa

Caso dois protocolos tentem injetar rotas para o mesmo destino, o roteador precisa saber o que fazer. Em suma, o roteador deve escolher um protocolo em vez do outro. Para fazer isso, os roteadores verificam um valor específico: a distância administrativa. Quando ocorre um conflito, a **distância administrativa mais baixa** é preferida. Cada protocolo de roteamento tem seu próprio valor de distância administrativa, mas você pode alterá-lo. Além disso, você também pode configurar rotas estáticas com distância administrativa personalizada. A tabela a seguir relata as distâncias administrativas padrão para dispositivos Cisco (que você precisa lembrar).

| DE ANÚNCIOS | Origem / protocolo de roteamento                             |
| ----------- | ------------------------------------------------------------ |
| 0           | Rotas conectadas (não podem ser modificadas)                 |
| 1           | Rotas estáticas                                              |
| 5           | Resumo EIGRP                                                 |
| 20          | BGP externo                                                  |
| 90          | EIGRP                                                        |
| 100         | IGRP (um protocolo legado)                                   |
| 110         | OSPF                                                         |
| 115         | IS-IS                                                        |
| 120         | RASGAR                                                       |
| 140         | EGP (um protocolo legado)                                    |
| 160         | ODR                                                          |
| 170         | EIGRP externo                                                |
| 200         | BGP interno                                                  |
| 255         | Origem de roteamento desconhecida. Este é o valor máximo, e se uma rota possuir este AD ela não poderá entrar na tabela de roteamento, descartando efetivamente a rota. |

Valores de distância administrativa em dispositivos Cisco

Se houver um conflito, o roteador selecionará a rota com o menor AD. Porém, se o protocolo retirar a rota posteriormente, será utilizado o outro (desde que não haja conflito, apenas um protocolo permaneceu ativo).

#### A métrica

Antes que um protocolo de roteamento possa propor uma rota para a tabela de roteamento, ele deve fazer suas verificações. O valor usado para isso é **a métrica** , um valor usado no protocolo de roteamento, mas também relatado na tabela de roteamento. Esse valor indica simplesmente o quão conveniente é essa rota; quanto menor, melhor. A figura a seguir mostra o processo de seleção da rota, com distância métrica e administrativa.

![Processo de seleção de rota em dispositivos Cisco, incluindo distância administrativa e métrica](https://www.ictshore.com/wp-content/uploads/2017/02/1030-03-Route_Selection.png)Cada protocolo de roteamento filtra as informações para mostrar à tabela de roteamento, que então aplica um filtro global.

Protocolos de roteamento diferentes calculam a métrica de maneira diferente, considerando itens diferentes (como largura de banda ou latência do link). Por causa disso, as métricas de diferentes protocolos de roteamento geralmente *não* são *consistentes* entre si.

## Configuração de rotas estáticas

Para este laboratório, precisamos configurar a comunicação entre HQ, Filial e a Internet usando rotas estáticas. No momento, não há rota no dispositivo HQ e Branch (exceto rotas conectadas e locais), então precisamos de tudo.

### Rotas estáticas simples

Sabemos que uma rota tem três partes principais: rede de destino, máscara e interface de próximo salto / saída. Esses são exatamente os itens que precisamos configurar ao inserir uma rota estática. Fazemos isso nesta mesma ordem, usando o comando de configuração `ip route`.

Para simplificar o processo, podemos começar pelo roteador da filial. Ele está conectado apenas ao HQ e precisa passar pelo HQ para acessar qualquer outra coisa. Portanto, o tipo de rota que podemos usar é uma rota padrão. Como próximo salto, precisamos usar o endereço IP de HQ no link com Branch. Para fazer isso, usamos o comando `ip route 0.0.0.0 0.0.0.0 10.0.3.1`. Dessa forma, informamos ao roteador que a rede `0.0.0.0/0`está atrasada `10.0.3.1`(o próximo salto). Em vez do endereço IP, podemos usar a interface de saída. No entanto, como este é um segmento Ethernet, isso não é recomendado. O resultado está na foto abaixo.

![Use o comando ip route para criar uma rota padrão, rotas estáticas no Cisco IOS](https://www.ictshore.com/wp-content/uploads/2017/02/1030-03-default_static_route.png)Criando uma rota padrão.

Em roxo claro, criamos a rota padrão. Então, quando emitimos `show ip route`, vemos essa rota bem no fundo. Isso ocorre porque é a rota padrão. Se você fez isso corretamente, sua pontuação de atividade do Packet Tracer será de 25%.

#### Lendo a Tabela de Roteamento

Neste ponto, podemos apresentar algumas outras informações úteis contidas na tabela de roteamento. Para isso, podemos analisar a entrada (rota) que acabamos de criar no Branch, conforme relatado a seguir.

```
S*      0.0.0.0/0 [1/0] via 10.0.3.1
```

Na lista a seguir, explicamos todos os componentes dessa rota estática.

- `S` - Rota Estática
- `*` - Esta é a rota padrão
- `0.0.0.0/0` - Rede de destino (neste caso, a Internet)
- `[1/0]`- Entre colchetes, encontramos a **distância administrativa** à esquerda (1) e a **métrica** à direita (0)
- `via 10.0.3.1` - Próximo salto

Lembre-se de onde você pode encontrar distância administrativa e métrica, é sempre útil!

### Testando Rotas com Ping Estendido

Neste ponto, podemos pensar que configuramos a comunicação entre Filial e HQ. Para verificar isso, podemos usar um ping padrão. No entanto, neste caso, é melhor usar um **ping estendido** . Um ping estendido permite que você ajuste alguns parâmetros, como tempo limite, contagens, sinalização de não fragmentação e muito mais. Além disso, com o ping estendido, podemos selecionar qual endereço IP queremos usar como endereço IP de origem (entre os do roteador). Para emitir um ping estendido, basta digitar ping e apertar enter. Em seguida, o software irá guiá-lo através do ajuste dos parâmetros. Esteja ciente de que a interface de origem faz parte dos *comandos estendidos* .

![Use o ping estendido para verificar as rotas de retorno](https://www.ictshore.com/wp-content/uploads/2017/02/1030-05-Extended_ping.png)O ping padrão foi bem-sucedido, o ping estendido falhou.

Como você pode ver na imagem, emitimos um ping padrão com sucesso. Em seguida, usamos o ping estendido (observe o comando estendido, onde dissemos *“sim”* ). Infelizmente, esse ping falha. Porque? Como o endereço IP de *origem* pode influenciar o sucesso de um ping? A razão para isso é simples: a resposta desaparece.

#### Detectando rotas de retorno ausentes

Os dispositivos Cisco sempre usam o **endereço IP mais próximo** de um destino ao fazer um ping. Portanto, quando emitimos o ping, `10.0.3.1`o dispositivo verificou como chegar a esse destino. Como a interface de saída para isso é GigabitEthernet 0/0, o roteador usou o endereço IP dessa interface como fonte (que é `10.0.3.2`). A solicitação atingiu o destino e os roteadores no caminho (neste caso apenas HQ) puderam rotear de volta a resposta para `10.0.3.2`. Aparentemente, eles não conseguem encaminhar a resposta para `10.11.0.1`.

A partir disso, sabemos que podemos usar o ping estendido para testar as **rotas de retorno** . Se o ping normal for bem-sucedido, mas o ping estendido falhar, então nossas rotas para outros dispositivos estão OK. No entanto, as rotas de outros dispositivos para nós não são! Precisamos consertar isso conectando no roteador HQ.

#### Adicionando mais rotas

HQ precisa saber que `10.11.0.0/24`está por trás de Branch. Além disso, ele precisa saber que a Internet está por trás do Provedor 1 ou do Provedor 2 se o primeiro não estiver disponível. Por enquanto, podemos esquecer o fallback no Provedor 2. Podemos apenas configurar duas rotas estáticas, conforme mostrado a seguir.

ip route 10.11 . 0 . 0 255,255 . 255 . 0 10,0 . 3 . 2   

ip route 0 . 0 . 0 . 0 0 . 0 . 0 . 0 10,0 . 1 . 2  

Se você enviar esses dois comandos para o roteador HQ, deverá ver sua pontuação subindo para 50%. Excelente! Mas agora precisamos nos concentrar na última tarefa deste laboratório, o fallback.

### Adicionando uma rota flutuante estática

Podemos configurar um sistema de fallback muito fácil usando uma rota flutuante. Uma rota flutuante estática é uma rota estática que você configura, mas não injeta na tabela de roteamento. Em vez disso, ele está apenas *“flutuando” na configuração,* pronto para entrar na tabela de roteamento.

Para criar uma rota flutuante, precisamos já ter uma rota para o mesmo destino com uma distância administrativa melhor. Dessa forma, essa outra rota terá preferência enquanto estiver disponível. Já temos uma rota para `0.0.0.0/0`, então precisamos adicionar uma nova com uma distância administrativa maior. Para este laboratório, usamos uma distância administrativa de 2.

A sintaxe para isso é simples, basta usar o `ip`` route`comando como já fizemos, e adicionar um quarto parâmetro no final: a **distância administrativa** . Então, vamos digitar o comando abaixo.

```
ip route 0.0.0.0 0.0.0.0 10.0.2.2 2
```

Logo após digitar este comando, você verá que sua pontuação alcançará 100%. Parabéns! No entanto, você não verá nenhuma mudança na tabela de roteamento. Para vê-los, você precisa desligar o GigabitEthernet 0/1 no roteador HQ. Se você fizer isso, verá a seguinte tabela de roteamento (em HQ).

![Rotas estáticas: a rota flutuante é configurada com maior distância administrativa](https://www.ictshore.com/wp-content/uploads/2017/02/1030-06-Floating_route.png)

A rota flutuante é destacada.

Se você olhar atentamente para a rota destacada, verá que ela tem uma distância administrativa de dois. Portanto, é uma rota flutuante.