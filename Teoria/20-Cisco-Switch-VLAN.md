# Tutorial de configuração de VLANs em um switch Cisco



Você sabe que os switches podem funcionar sem qualquer configuração. No entanto, você sabe que pode configurar interruptores para gerenciamento remoto e ajustar algumas configurações (como o banner). No entanto, ainda não falamos sobre as maneiras como podemos alterar o funcionamento de um switch. Neste artigo, abordamos a *configuração de VLANs em um switch Cisco* . Aprenderemos como segmentar um switch em vários domínios de broadcast e como estender o mesmo domínio de broadcast para vários switches.

Como qualquer artigo prático, este guia aproveita um laboratório onde você pode praticar o que aprende. Use o link abaixo para baixá-lo gratuitamente no laboratório Cisco Packet Tracer.

[![Obtenha este laboratório!  Pratique o que você aprendeu e ganhe experiência com nossos laboratórios de rede e demonstrações - faça o download agora](https://www.ictshore.com/wp-content/uploads/2017/01/get-this-lab.jpg)](https://www-ictshore-com.translate.goog/download/lab-ccna-course-002-vlans-configuration-cisco-switch/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)

Depois de fazer o download do laboratório, abra-o com o Cisco Packet Tracer. Em seguida, trabalhe nisso enquanto lê as instruções que você encontra nesta postagem.

## Introdução ao laboratório de configuração de VLANs

### A topologia

A imagem a seguir mostra todos os dispositivos usados naquele laboratório, bem como as conexões entre eles.

![Topologia de laboratório de configuração de VLANs no Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1024-01-Lab_topology.png)Esta é a topologia para este laboratório

Não se assuste com essa topologia enorme, é mais simples do que você imagina. Bem no topo, temos um dispositivo chamado “TopSwitch” que interconecta três outros switches: esquerdo, centro e direito. Cada uma dessas chaves periféricas conecta dispositivos finais. Temos quatro tipos diferentes de dispositivos: computadores desktop, laptops, servidores e impressoras. Para este laboratório, configuraremos apenas os switches. No entanto, usaremos os dispositivos finais para realizar alguns testes de conectividade.



### Os requisitos

Como no título, faremos a configuração de VLANs para todos os switches da topologia. Isso inclui a criação das VLANs, as configurações das portas de acesso e a configuração do tronco. Antes de revelar partes da configuração, apresentaremos a teoria por trás (como o protocolo 802.1q). A tabela a seguir apresenta a configuração de VLANs que pretendemos alcançar.

| EU IRIA | Nome         | Sub-rede        | Faixa de porta em dispositivos periféricos |
| ------- | ------------ | --------------- | ------------------------------------------ |
| 99      | Buraco Negro | Nenhum          | Nenhum                                     |
| 101     | PCs desktop  | `10.100.1.0/24` | FastEthernet0 / 1 a FastEthernet0 / 9      |
| 102     | Laptop-PCs   | `10.100.2.0/24` | FastEthernet0710 a FastEthernet0 / 19      |
| 201     | Servidores   | `10.200.0.0/25` | FastEthernet0 / 20 a FastEthernet0 / 22    |
| 301     | Impressoras  | `10.105.0.0/24` | FastEthernet0 / 23 e FastEthernet0 / 24    |

Configuração de VLANs

### Lista de Passos

Para atender aos requisitos deste laboratório, estamos passando por várias etapas. Aqui está uma lista rápida para ajudá-lo a folhear o artigo.

1. Introdução a VLANs e troncos (aqui temos a teoria)
2. Criação de VLANs (para todos os switches)
3. Configuração de portas de acesso em switches periféricos
4. Configurando portas de tronco em switches periféricos
5. Configuração de portas de tronco no TopSwitch
6. Testes de conectividade

É hora de começar!

## Alguma teoria sobre VLANs e troncos

### O que são VLANs?

VLAN significa **Rede Local Virtual** , e é uma tecnologia para dividir sua rede em segmentos. Especificamente, cada VLAN é um domínio de broadcast independente. Como resultado, dois dispositivos em duas VLANs diferentes precisam de um roteador para se comunicarem, pois não podem fazer isso diretamente. Contanto que, o que é poderoso sobre as VLANs é que elas estão sob controle total do administrador. Em outras palavras, você pode criar ou excluir VLANs à vontade. No entanto, as VLANs sozinhas são inúteis: *você precisa atribuí-las às portas* . Você pode configurar o switch para ter algumas portas em uma VLAN e algumas portas em outra. Consequentemente, os dispositivos conectados a portas nas mesmas VLANs podem falar diretamente, enquanto a comunicação entre VLANs requer um roteador.

![As VLANs permitem isolar dinamicamente os domínios de transmissão](https://www.ictshore.com/wp-content/uploads/2017/01/1024-02-VLANs.png)Nesta imagem, os dois PCs do lado verde compartilham o mesmo domínio de transmissão, que difere daquele compartilhado pelos dois PCs do lado azul claro

### Os detalhes

Você pode identificar VLANs por seu **ID de VLAN** , um número que varia de *1 a 4094* . Isso significa que você poderá usar até 4094 VLANs em um switch. No entanto, as VLANs após 1005 fazem parte do “intervalo estendido” e não as usaremos, pelo menos neste artigo. Em vez disso, usaremos a faixa normal, VLANs de 1 a 1005 (observe que a VLAN 0 não está disponível). Por padrão, um switch tem 5 VLANs: 1, 1002, 1003, 1004, 1005. VLANs 1002-1005 são usadas para emular um token ring, um recurso legado. Você não pode removê-los nem editá-los e (quase) nunca precisará deles. Em vez disso, a VLAN 1 é a **VLAN padrão** : todas as portas de um switch estão nessa VLAN por padrão.

Você também pode configurar as mesmas VLANs em vários switches, conectá-los entre si e ter a mesma VLAN para se propagar em vários switches. Para fazer isso, você precisa ter certeza de que a porta de um switch usada para se conectar a outro switch tem a mesma VLAN em ambos os switches. Dessa forma, você propagará essa VLAN.

![As VLANs podem ser propagadas por portas de acesso (1 VLAN) ou portas de tronco (várias VLANs)](https://www.ictshore.com/wp-content/uploads/2017/01/1024-03-VLAN_propagation.png)O switch à esquerda tem a VLAN azul na interface em direção ao switch no centro. O switch no centro deve usar a mesma VLAN nesse link. Em vez disso, o switch central usa um tronco com switch direito para transportar várias VLANs em um único link.

No entanto, temos uma maneira melhor de propagar VLANs entre switches: troncos.

### O que é um tronco?

Ao falar sobre VLAN, um tronco é um link (uma porta) que transporta tráfego para várias VLANs. Você pode configurar uma porta de duas maneiras, como uma porta de acesso ou uma porta de tronco. Cada **porta de acesso** encaminhará o tráfego para uma *única* VLAN usando frames Ethernet. Em vez disso, uma **porta de tronco** encaminhará o tráfego para *várias* VLANs (mesmo todas). Enquanto um dispositivo conectado a uma porta de acesso não precisa saber sobre VLANs, um dispositivo conectado a uma porta de tronco precisa saber sobre elas. Isso ocorre porque precisamos enviar algumas informações para distinguir entre VLANs em um tronco e ambos os dispositivos precisam entendê-lo. No entanto, para este propósito, o protocolo Ethernet não é adequado.

Em links de tronco, podemos usar o protocolo *Inter-Switch Link (ISL)* ou **IEEE 802.1q** . ISL é uma solução proprietária da Cisco, embora legada, enquanto 802.1q (ou *dot1q* ) é uma tecnologia padrão. Já que dot1q também é o mais eficiente, é esse o escolhido. Além disso, a maioria dos switches oferece suporte apenas a este. Um quadro dot1q é muito simples: é um quadro ethernet com o ID de VLAN compactado. No quadro, o ID de VLAN é chamado de **tag** .

![O quadro 802.1q estende o quadro Ethernet para adicionar marcação](https://www.ictshore.com/wp-content/uploads/2017/01/1024-04-dot1q_tagging.png)Isso é o que a tag 802.1q adiciona ao quadro Ethernet. FCS é reescrito.

Dessa forma, o dispositivo do outro lado verifica o ID da VLAN no quadro e sabe para qual VLAN enviar esse quadro. Lembre-se de que os troncos são usados para abranger várias VLANs entre os switches, mas eles *mantêm o isolamento* entre as VLANs.

### Algumas considerações sobre troncos e portas de acesso

Os dispositivos finais geralmente não se comunicam com 802.1q, mas apenas com Ethernet. Eles não têm concepção de VLANs, portanto, nem mesmo estão cientes de estar em uma VLAN em vez de outra. Quando um switch recebe um quadro em uma porta de acesso, a primeira coisa que ele faz é consultar a tabela de endereços MAC. Dessa forma, o switch determina a interface de saída (ou interfaces). Se a interface de saída for uma porta de acesso, o quadro Ethernet será enviado sem alteração. Em vez disso, se a interface de saída for uma porta de tronco, o quadro será marcado com o ID de VLAN da porta de acesso de origem.

![Switches usam IDs de VLAN para marcar frames](https://www.ictshore.com/wp-content/uploads/2017/01/1024-05-Tagging_process.png)Os switches adicionam e removem tags de VLAN com base na interface de saída e entrada de cada quadro.

Obviamente, o mesmo conceito se aplica também a frames de portas de tronco para portas de acesso. Desta vez, o quadro é desmarcado do quadro Ethernet original. Isso é completamente transparente para os dispositivos finais: você *não pode descobrir* quantos interruptores o separam do seu dispositivo de destino.

Antes de começar, precisamos fazer outra consideração sobre os troncos. Estamos falando sobre a **VLAN nativa** . Esta é uma configuração da porta para identificar a VLAN de quadros não marcados. Em outras palavras, é possível que você receba um quadro Ethernet padrão em uma porta de tronco. Quando isso acontecer, o switch o considerará parte da VLAN nativa. Por padrão, *VLAN 1* é a VLAN nativa em todos os troncos. Ele foi originalmente projetado para migrar de redes com hubs, permitindo a **interoperabilidade** . No entanto, em redes modernas, esperamos *apenas frames marcados* .

## Configuração de VLANs passo a passo

### Criação de VLANs

Para uma configuração de Switch VLANs, a primeira coisa que devemos fazer é *criar as VLANs* . A configuração de VLANs deve ser consistente entre todos os switches para os quais você deseja propagar as VLANs. Neste laboratório, temos quatro switches e queremos que todos eles funcionem com as mesmas VLANs. Portanto, teremos que replicar a configuração em todos os quatro switches.

Para criar uma VLAN, usamos o `vlan`comando seguido do ID da VLAN que queremos usar. Isso criará a VLAN se ela ainda não existir e nos colocará no prompt de configuração da VLAN. A partir daí, podemos definir uma descrição para esclarecer o propósito desta VLAN (usando o `name`comando). Aqui está o que temos que digitar.

```
Switch(config)#
Switch(config)#vlan 99
Switch(config-vlan)#name Black-Hole
Switch(config-vlan)#exit
Switch(config)#vlan 101
Switch(config-vlan)#name Desktop-PCs
Switch(config-vlan)#exit
Switch(config)#
Switch(config)#vlan 102
Switch(config-vlan)#name Laptop-PCs
Switch(config-vlan)#exit
Switch(config)#
Switch(config)#vlan 201
Switch(config-vlan)#name Servers
Switch(config-vlan)#exit
Switch(config)#
Switch(config)#vlan 301
Switch(config-vlan)#name Printers
Switch(config-vlan)#exit
Switch(config)#
```

Criamos uma VLAN com o ID definido como 101, definimos o nome como “Desktop-PCs” e repetimos o processo para as VLANs 101, 102, 201 e 301. Observe que você não precisa digitar o `exit`comando todas as vezes . Agora podemos vê-los na `show vlan brief`saída do comando.

![Comando Cisco IOS show vlan brief para um exemplo de configuração de VLANs](https://www.ictshore.com/wp-content/uploads/2017/01/1024-06-Command_show_vlan_brief.png)Aqui podemos ver as VLANs que criamos (em destaque).

*Nota: Explicaremos a finalidade da VLAN “Black-Hole” mais tarde, quando falarmos sobre troncos.*

A saída desse comando é muito direta. Ele mostra uma tabela com quatro colunas, o *ID* da *VLAN* , o *nome* da *VLAN* , o *status* e a lista de *portas* de *acesso* nessa VLAN. Observe que nesta lista de portas você encontrará apenas portas de acesso, não troncos.

Nossas VLANs recém-criadas *não* têm *portas de acesso associadas* . Precisamos associar portas manualmente e faremos isso na próxima seção. No entanto, antes de fazermos isso, certifique-se de criar as VLANs em todos os switches.

### Configurando portas de acesso

Agora, precisamos informar a cada porta a qual VLAN ela pertence. Fazemos isso no prompt de configuração da interface que podemos acessar por meio do `interface`comando. No entanto, precisamos fazer exatamente a mesma configuração em várias portas. Nesse caso, podemos usar o `interface range`comando. Com este comando, você ainda entra no prompt da interface *(tecnicamente intervalo de interface)* , mas o que você digita é aplicado a várias interfaces. Aqui estão dois exemplos.

- `interface FastEthernet 0/9` entra no prompt de configuração da interface e aplica tudo da interface FastEthernet 0/9 apenas
- `interface range FastEthernet 0/12, FastEthernet 0/15 - 17` entra no prompt de configuração de intervalo de interface e aplica tudo o que você digita às interfaces FastEthernet 0/12, 0/15, 0/16 e 0/17

Independentemente do método escolhido, precisamos fazer duas coisas. Primeiro, usando o `switchport mode access`comando, codificamos as interfaces como portas de acesso. Depois disso, usamos `switchport access vlan`, seguido de VLAN ID, para especificar a qual VLAN a porta pertence. Se você se lembrar da tabela de requisitos iniciais, todos os switches periféricos têm a mesma configuração de porta. Aqui está o que precisamos digitar para fazer a configuração descrita nos requisitos.

```
Switch(config)#
Switch(config)#interface range fa0/1 - 9
Switch(config-if-range)#switchport mode access
Switch(config-if-range)#switchport access vlan 101
Switch(config-if-range)#exit
Switch(config)#
Switch(config)#interface range fa0/10 - 19
Switch(config-if-range)#switchport mode access
Switch(config-if-range)#switchport access vlan 102
Switch(config-if-range)#exit
Switch(config)#
Switch(config)#
Switch(config)#interface range fa0/20 - 22
Switch(config-if-range)#switchport mode access
Switch(config-if-range)#switchport access vlan 201
Switch(config-if-range)#exit
Switch(config)#
Switch(config)#interface range fa0/23 - 24
Switch(config-if-range)#switchport mode access
Switch(config-if-range)#switchport access vlan 301
Switch(config-if-range)#exit
Switch(config)#
```

Como dica, o `exit`comando não é necessário para fins de configuração. Estamos usando aqui apenas para dar uma ideia mais clara do que estamos configurando. Repita esta etapa da configuração de VLANs em *LeftSwitch* , *CenterSwitch* e *RightSwitch* . Depois disso, poderemos ver essas mudanças na `show vlan brief`saída do comando.

![Comando Cisco IOS show vlan brief com portas destacadas](https://www.ictshore.com/wp-content/uploads/2017/01/1024-07-Command_show_vlan_brief_with_ports.png)A configuração das portas produziu essa saída como resultado.

### Configurando troncos - os comandos

Como concluímos todas as configurações de VLANs em cada switch, precisamos apenas *propagar essas VLANs de forma consistente* . Todos os switches periféricos se conectam ao TopSwitch usando sua porta GigabitEthernet 0/1. No entanto, essa porta está atualmente na VLAN 1, portanto a configuração das VLANs não é consistente. Isso ocorre porque os dados de qualquer VLAN diferente de 1 não podem passar de um switch para o outro, então a VLAN 101 no LeftSwitch não faz parte do *mesmo domínio* de *broadcast* da VLAN 101 no TopSwitch. Portanto, precisamos **configurar os troncos** .

Você pode fazer toda a configuração de um tronco no prompt de configuração da interface. Portanto, vamos inseri-lo com o `interface`comando. Neste ponto, precisamos digitar vários comandos. Primeiro, forçamos a interface a ser um tronco usando o `switchport mode trunk`comando. Basicamente, isso é tudo que você precisa digitar se quiser que seu baú funcione. Um tronco criado dessa forma carregará todas as VLANs e usará a VLAN 1 como nativa.

Apesar da simplicidade, vamos adicionar mais três comandos para aumentar a segurança. Os switches Cisco podem detectar quando estão conectados um ao outro e formar um tronco automaticamente. Isso se deve ao **Dynamic Trunking Protocol (DTP)** , uma tecnologia da Cisco. Mesmo que isso torne as coisas mais fáceis, não queremos isso. Qualquer pessoa pode usar este protocolo para tentar formar um tronco com nosso switch ou para obter informações confidenciais. Portanto, nós o desabilitamos usando `switchport nonegotiate`. Neste laboratório, vamos fazer isso apenas para troncos, mas você deve fazer isso para todas as portas da vida real. *Observe que este comando está disponível apenas se você forçou anteriormente a porta a ser tronco ou acesso.*

Lembra quando criamos a *VLAN Black-Hole* ? Vamos usá-lo lá como a VLAN nativa para nossos troncos. Isso nos ajudará a evitar **ataques de salto de VLAN** , onde um hacker poderia alcançar outra VLAN aproveitando o nativo nos troncos. Portanto, criamos uma VLAN que não contém nenhuma porta de acesso. Dessa forma, ao atribuí-lo como nativo ao tronco com `switchport trunk native vlan`comando, estamos praticamente desabilitando a VLAN nativa. Portanto, se alguém puder intervir e inserir o tráfego não marcado no tronco, o switch o descartará porque será recebido na VLAN 99.

Como dissemos antes, nossos troncos transportarão todas as VLANs ativas, até 4094. Em vez disso, queremos que transportem apenas as VLANs que criamos. Definimos isso usando `switchport trunk allowed vlan`seguido por uma lista de VLANs. Como esses comandos se referem apenas às VLANs que realmente são marcadas, você não precisa incluir a VLAN nativa. Você pode usar este comando com várias palavras-chave:

- `switchport trunk allowed vlan` seguida por uma lista, esta lista de VLANs substituirá a anterior
- `switchport trunk allowed vlan add` seguido por um ID de VLAN, que VLAN será adicionado à lista já existente
- `switchport trunk allowed vlan none` remove todas as VLANs, bloqueando efetivamente o tronco
- `switchport trunk allowed vlan remove` seguido por um ID de VLAN, que VLAN será removido da lista já existente
- `switchport trunk allowed vlan except` seguido por um ID de VLAN, substitui as configurações atuais com todas as VLANs, exceto a especificada

### Configurando troncos em interruptores periféricos

Agora que já sabemos os comandos a serem digitados, podemos ir bem rápido nesta etapa. Desde que a porta para fazer o tronco seja GigabitEthernet 0/1, aqui está o que precisamos digitar.

Switch ( config ) #

Switch ( config ) #interface GigabitEthernet 0/1

Switch ( config- **if** ) #switchport mode trunk

Switch ( config- **if** ) #switchport nonegotiate

Switch ( config- **if** ) #switchport trunk nativo vlan 99

Switch ( config- **if** ) #switchport tronco permitido vlan 101-102.201.301

Switch ( config- **if** ) #exit

Switch ( config ) #

Faça isso para todos os interruptores periféricos (LeftSwitch, CenterSwitch e RightSwitch). Para verificar se a configuração do tronco está correta, emita o `show interfaces trunk`comando exec privilegiado.

![Exemplo de tronco de interfaces de show de comando Cisco IOS no Packet Tracer](https://www.ictshore.com/wp-content/uploads/2017/01/1024-08-Command_show_interfaces_trunk.png)Com este comando, você pode ver as informações básicas sobre troncos no switch.

O `show interfaces trunk`comando apresenta a lista de troncos em sua central quatro vezes, cada vez mostrando diferentes informações.

- Na primeira tabela, você vê o modo (on significa que o tronco está codificado com `switchport mode trunk`), o protocolo de encapsulamento, o status e a VLAN nativa
- Abaixo disso, você vê as VLANs permitidas para cada tronco que você definiu com o `switchport trunk allowed vlans`comando
- Então, logo abaixo, você vê a lista de VLANs permitidas atualmente ativas
- Finalmente, você vê as VLANs que estão efetivamente passando no tronco (falaremos sobre a poda mais tarde)

*Lembre-se: sempre verifique a última tabela se estiver procurando pelas VLANs efetivamente em uso no tronco!*

### Configurando troncos no “TopSwitch”

Para a última parte desta configuração de VLANs, vamos configurar os troncos no TopSwitch. Este dispositivo atua como um ponto central porque toda a comunicação entre outros switches deve fluir através dele. TopSwitch está conectado com LeftSwitch em FastEthernet 0/1, com CenterSwitch em FastEthernet 0/2 e com RightSwitch em FastEthernet 0/3. Além disso, os comandos de configuração são os mesmos dos switches periféricos - e os mesmos para todas as três interfaces. Como resultado, podemos usar o `interface range`comando para acelerar as coisas.

Switch ( config ) #

Switch ( config ) #interface range FastEthernet 0/1 - 3

Switch ( config- **if** -range ) #switchport mode trunk

Switch ( config- **if** -range ) #switchport nonegotiate

Switch ( config- **if** -range ) #switchport trunk nativo vlan 99

Switch ( config- **if** -range ) #switchport tronco permitido vlan 101-102.201.301

Switch ( config- **if** -range ) #exit

Switch ( config ) #

**Tudo feito!** Sua pontuação na atividade do Packet Tracer deve ser de 100% agora. Caso contrário, tente revisar os comandos que usamos e tente o botão “Verificar resultados” para ver o que você perdeu.

### Testes de Conectividade

O objetivo da configuração de VLANs é dividir os terminais em sub-redes logicamente. Como a mesma VLAN pode abranger vários switches, você não precisa agrupar dispositivos por locais físicos, você pode agrupá-los por função lógica. Além disso, com uma configuração de VLANs, você pode forçar o tráfego entre VLANs a passar por um dispositivo central, onde você pode aplicar políticas e restrições (quem pode acessar o quê). Como ainda não temos esse dispositivo, neste laboratório o tráfego entre VLANs será descartado.

Para testar isso, experimente alguns pings de PCs, laptops ou servidores. O esquema de endereçamento completo é relatado abaixo.

| Dispositivo | Endereço IP / CIDR |
| ----------- | ------------------ |
| PC0         | `10.100.1.0/24`    |
| PC1         | `10.100.1.11/24`   |
| PC2         | `10.100.1.12/24`   |
| PC3         | `10.100.1.13/24`   |
| PC4         | `10.100.1.14/24`   |
| Laptop0     | `10.100.2.10/24`   |
| Laptop1     | `10.100.2.11/24`   |
| Laptop2     | `10.100.2.12/24`   |
| Server0     | `10.200.0.10/25`   |
| Servidor1   | `10.200.0.11/25`   |
| Server2     | `10.200.0.12/25`   |
| Printer0    | `10.105.0.10/24`   |

Esquema de Endereçamento

Por design, você será capaz de executar ping apenas em dispositivos do mesmo tipo. Os PCs farão ping apenas em PCs, os laptops farão ping apenas em laptops e os servidores farão ping apenas em servidores. Observe que a aplicação desse esquema de endereçamento sem uma configuração de VLANs teria o mesmo resultado. No entanto, o tráfego teria se misturado nos switches, tendo desempenho inferior e sendo mais vulnerável a ataques. A regra de ouro é esta: sempre mapeie uma única sub-rede em uma única VLAN e vice-versa.

## Conclusão

Neste artigo, aprendemos como as VLANs funcionam e como os switches se comunicam usando troncos. Depois de divulgar a teoria sobre esses conceitos, passamos imediatamente para as partes de configuração. Aqui está uma recapitulação dos comandos de configuração que vimos.

- `vlan`para criar uma nova VLAN *- então*
- `name` para dar um nome a uma VLAN (no prompt de configuração da VLAN)
- `interface range`para configurar várias interfaces em massa *- então*
- `switchport mode` para definir o modo da porta (acesso ou tronco)
- *quando a porta está no modo de acesso* - `switchport access vlan`para especificar a VLAN de acesso
- *quando a porta está no modo tronco* - `switchport trunk native vlan`para definir a VLAN nativa
- *quando a porta está no modo tronco* - `switchport trunk allowed vlan`para especificar as VLANs permitidas
- *em qualquer modo de porta* - `switchport nonegotiate`para desligar o Dynamic Trunking Protocol (DTP)

Em vez disso, os comandos show são os seguintes.

- `show vlan brief` para verificar a configuração de VLANs e portas de acesso
- `show interfaces trunk` para ver informações rápidas sobre interfaces de tronco

Com esse conhecimento sobre a configuração de VLANs, você está pronto para avançar para a solução de problemas de switch. Mas vamos manter o próximo artigo do curso CCNA.