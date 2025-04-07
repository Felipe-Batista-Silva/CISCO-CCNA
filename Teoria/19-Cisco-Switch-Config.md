# Fundamentos de configuração de switch para dispositivos Cisco



Simplificando, os switches conectam dispositivos finais. Você pode encontrá-los no Enterprise Campus, no Data-Center e até mesmo no provedor de serviços. Cada engenheiro de rede deve ser capaz de trabalhar neles, e é para isso que estamos aqui. Neste artigo, veremos como preparar uma configuração básica de switch Cisco com um laboratório de Packet Tracer guiado passo a passo.

[![Obtenha este laboratório!  Pratique o que você aprendeu e ganhe experiência com nossos laboratórios de rede e demonstrações - faça o download agora](https://www.ictshore.com/wp-content/uploads/2017/01/get-this-lab.jpg)](https://www-ictshore-com.translate.goog/download/lab-ccna-course-001-switch-configuration-fundamentals/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)

Use o link acima para baixar a Atividade do Packet Tracer, abra-a e trabalhe nela enquanto lê o artigo.

## Introdução ao laboratório

### A Topologia

Aqui está uma foto dos dispositivos contidos em nosso laboratório.

![Topologia de laboratório para fundamentos de configuração de switch](https://www.ictshore.com/wp-content/uploads/2017/01/1023-01-Lab_setup.png)

Nesta topologia, encontramos dois computadores desktop conectados a um **switch 2960** . Esse switch é então conectado à nuvem da Rede Corporativa por meio de um roteador. Na outra ponta da nuvem, encontramos outro roteador com um computador conectado a ele. Nesta topologia, o único item de configuração que vamos trabalhar é “LabSwitch”. Também usaremos os três PCs para fazer alguns testes e verificar se configuramos tudo corretamente.



### Os requisitos

O switch que você encontra nesta topologia é completamente novo. Portanto, precisaremos preparar toda a configuração inicial do switch. Especificamente, vamos definir o nome do host e a mensagem do banner, configurar o switch para acessibilidade remota e adicionar alguns itens básicos de segurança. A tabela a seguir resume os requisitos por tópico.

| Item                     | Requerimento                                                 |
| ------------------------ | ------------------------------------------------------------ |
| **Configuração de IP**   | O dispositivo deve estar acessível `192.168.1.2/24`em Vlan1, onde está o gateway padrão `.1`. |
| **Configurações Gerais** | O dispositivo deve ser denominado *“LabSwitch”* e *exibir “* *My first switch”* toda vez que um usuário fizer login. |
| **Segurança**            | Acesso no modo seguro privilegiado com a senha *“ictshore”* e acesso à linha com a senha *“cisco”* . Criptografe todas as senhas. |
| **Gerenciamento remoto** | Todas as linhas VTY devem aceitar conexões telnet            |

### Lista de etapas

Nesta configuração de switch, vamos seguir estas etapas:

1. Apresente os comandos úteis para navegar entre os prompts da Cisco
2. Definir configurações de endereço IP
3. Configure o gateway padrão
4. Configure o nome do host e o banner
5. Configurando habilitar segredo, senha VTY e criptografia de senha
6. Habilitando o acesso telnet em VTYs

## Configuração passo a passo do switch

### Dicas rápidas da Cisco

Antes de mergulhar na configuração, podemos gastar um pouco para melhorar a proficiência. A Cisco oferece muitos comandos para fazer muitas coisas, então pode ser difícil lembrar de todos eles. A Cisco sabe disso, então eles nos oferecem algumas dicas embutidas no sistema operacional. Em primeiro lugar, o componente mais útil é a **ajuda contextual** . Em qualquer ponto da configuração, você pode digitar um *ponto de interrogação* para ver quais são os comandos disponíveis. Além disso, você pode fazer isso enquanto digita um comando! Como resultado, você pode usar a ajuda contextual para ver como completar um comando. Principalmente da primeira vez, será um recurso precioso.

![Usando a ajuda contextual da Cisco para realizar uma configuração básica do switch](https://www.ictshore.com/wp-content/uploads/2017/01/1023-02-Contextual_help.png)Este é um exemplo de como usar a Ajuda Contextual da Cisco

Como na foto, se você usar `?`em uma palavra sem espaço, o aparelho mostrará como completar aquele comando. Em vez disso, se você usá-lo após um comando, verá quais são as próximas palavras que pode digitar.

Além disso, a Cisco oferece vários comandos para navegar dentro dos prompts. Visto que você não pode usar o mouse dentro do prompt, precisamos encontrar maneiras alternativas.

- Use a **seta para** a **esquerda** e a **seta** para a **direita** para mover o cursor para o caractere anterior ou seguinte na linha.
- Use a **seta** para **cima** para recuperar toda a linha anterior inserida. Observe que se você já digitou algo na linha atual, isso será perdido. Você pode recuperar vários comandos anteriores pressionando a seta superior várias vezes.
- Use a **seta** para **baixo** para chamar o próximo comando, caso você tenha voltado "muito para trás" com a seta para cima
- Pressione `Ctrl+a`para mover o cursor para o início da linha
- Pressione `Ctrl+e`para mover o cursor para o final da linha

### Endereços IP: uma recapitulação rápida

Cada switch tem o mesmo objetivo principal: permitir a comunicação da camada 2 entre os dispositivos conectados. Portanto, ele não precisa de um endereço IP para funcionar corretamente. No entanto, configurar um endereço IP em um switch pode estender seus recursos. Além disso, estamos procurando é a possibilidade de gerenciar o dispositivo. Fora da caixa, podemos gerenciar nosso switch apenas via *console* , mas isso não é tão flexível. Como gerenciaremos vários switches em toda a empresa, é melhor encontrar uma maneira de controlá-los remotamente. Antes disso, precisamos de uma maneira de nos comunicarmos com esses dispositivos remotamente, e é aí que entra o endereço IP.

Cada dispositivo configurado corretamente com um *endereço IP* , *máscara de sub-rede* e *gateway padrão* pode se comunicar com dispositivos remotos. Como resultado, podemos gerenciar o dispositivo remotamente com telnet ou SSH. Além disso, podemos monitorar seu estado de saúde com ping ou SNMP e gerar alertas em caso de falha do dispositivo. Antes de mergulharmos na configuração, vamos atualizar esses conceitos.

- O **endereço IP** de um dispositivo é o endereço da Camada 3 usado na comunicação.
- Com o endereço IP, devemos configurar uma **máscara de sub-rede** . O dispositivo o usará para determinar quais hosts estão na mesma sub-rede e quais hosts são remotos.
- O **gateway padrão** é para onde enviaremos todo o tráfego para destinos remotos.

### Configurando IP

A primeira coisa que você deseja fazer é clicar no dispositivo LabSwitch e ir para a guia CLI. Então, quando o processo de inicialização terminar, devemos chegar ao prompt de configuração. Podemos fazer isso simplesmente inserindo esses comandos.

Mudar >

Alternar > ativar

Switc h #

Switc h # configure terminal

Switch ( config ) #

O primeiro comando que vamos digitar é `enable`. Isso nos levará do modo de usuário para o modo de privilégio, então usamos `configure terminal`para entrar no modo de configuração.

Ao contrário de um PC ou um roteador, todas as portas em um switch funcionam na camada de enlace em vez de na camada de rede. Conseqüentemente, você não pode atribuir um endereço IP a eles. No entanto, podemos atribuir um endereço IP ao próprio switch, com esse endereço IP não relacionado a nenhuma porta física. Como parte da configuração do switch, podemos atribuir um endereço IP a uma interface lógica. Como queremos apenas acessibilidade remota, usaremos a **interface lógica** padrão , embora essa não seja a prática recomendada. A interface lógica padrão em cada switch Cisco é chamada de *VLAN 1* . Aqui estão os comandos.

Switch ( config ) #

Switch ( config ) #interface vlan 1

Switch ( config- **if** ) #ip address 192.168.1.2 255.255.255.0

Switch ( config- **if** ) #no shutdown

Switch ( config- **if** ) #

Em primeiro lugar, estamos entrando no prompt de configuração da interface para a VLAN 1 com o `interface vlan 1`comando. Em seguida, definimos o endereço IP e a máscara de sub-rede para essa interface com o `ip address`comando. Finalmente, habilitamos a interface lógica com o `no shutdown`comando. Observe que, com a sintaxe Cisco, para remover um comando da configuração basta digitar `no`seguido por esse comando.

### Configurando o gateway padrão

Agora, nosso switch pode se comunicar com outros dispositivos na mesma sub-rede. Tente fazer isso emitindo `ping 192.168.1.2`no prompt de comando PC1 (observe que a primeira solicitação pode expirar).

![Faça ping em um switch com um endereço IP na VLAN 1](https://www.ictshore.com/wp-content/uploads/2017/01/1023-03-Ping_the_switch.png)Agora podemos fazer ping no switch dos PCs locais.

No entanto, se você repetir o mesmo teste do *PC remoto* , verá que todas as solicitações expiram. Isso ocorre porque nosso switch ainda não tem um **gateway padrão** . Quando o PC remoto tenta fazer ping no switch, o tráfego chega ao switch corretamente, mas nosso switch não sabe como enviar uma resposta. Ele verifica se o destino é remoto usando o endereço IP e a máscara de sub-rede e, em seguida, descarta o pacote porque não há gateway padrão. Mudar é fácil.

Switch ( config- **if** ) #exit

Switch ( config ) #

Switch ( config ) #ip gateway padrão 192.168.1.1

Switch ( config ) #

Usamos o `exit`comando para voltar da configuração da interface para a configuração global e, em seguida, usamos o `ip default-gateway`comando para especificar o endereço IP do nosso gateway. Nesse caso, nosso gateway será o *Roteador 0* . Assim que o gateway estiver configurado, tente novamente o ping do PC remoto. Desta vez, a solicitação será bem-sucedida.

## Definição das configurações gerais

Cada configuração de switch inclui estas configurações gerais: um *nome* para o dispositivo e um *banner* . Como você trabalhará com vários switches juntos, devemos encontrar uma maneira de identificar rapidamente em qual switch você está trabalhando. Para fazer isso, definimos o **nome** do **host** do dispositivo. Nesta configuração de switch, vamos defini-lo como *“LabSwitch”* .

Switch ( config ) #

Switch ( config ) #hostname LabSwitch

LabSwitch ( config ) #

Basicamente, o `hostname`comando espera um nome sem espaços como parâmetro. Depois de digitar esse comando, **o prompt mudará** para refletir o novo nome do host. Portanto, sabemos que o nome de host padrão para switches é simplesmente *“Switch”* .

A próxima etapa é configurar a **Mensagem de Banner do Dia (MOTD)** . Esta é simplesmente uma mensagem exibida sempre que você se conecta ao dispositivo. Por causa disso, geralmente é usado para informar a localização do dispositivo e alguns avisos contra acesso não autorizado. Uma configuração de switch do mundo real terá um banner contendo o site onde o dispositivo está e desencoraja o acesso não autorizado. Para este laboratório, use o seguinte comando.

LabSwitch ( config ) #

LabSwitch ( config ) #banner motd $ Meu primeiro switch $

LabSwitch ( config ) #

Como o banner pode ter várias linhas, precisamos usar um separador de texto. Em outras palavras, o primeiro caractere que você digitar após “motd” será usado para fechar o banner. Nesse caso, usamos o *cifrão* como separador, de modo que o dispositivo considerará qualquer coisa que digitarmos como parte do banner até que digitemos outro cifrão.

### Protegendo o Modo Privilegiado

Com a configuração básica do switch, devemos aprender como proteger o gerenciamento do dispositivo. Como o modo de privilégio permite ver dados confidenciais e entrar no modo de configuração, queremos conceder acesso a eles apenas para usuários autorizados. Podemos fazer isso definindo uma senha para acessá-lo. Para fazer isso, temos duas alternativas: `enable secret`e `enable password`. Esses dois comandos definem uma senha para obter acesso ao modo privilegiado, mas eles diferem na *maneira como a senha é armazenada* . Com `secret`, a senha é armazenada como texto criptografado, enquanto com `password`é armazenada como texto simples. Como resultado, `enable secret`é a alternativa mais segura e devemos sempre usá-la.

LabSwitch ( config ) #

LabSwitch ( config ) #enable secret ictshore

LabSwitch ( config ) #

Agora, para cada usuário que tentar entrar no modo privilegiado terá que inserir *“ictshore”* como senha. Mas isso não é suficiente como medida de segurança. Até mesmo o modo de usuário pode expor alguns dados que não queremos mostrar a todos e pode até mesmo expor você a alguns ataques, se não os protegermos. Portanto, devemos pedir uma senha toda vez que alguém tentar se conectar remotamente ao switch. Com remotamente, pretendemos qualquer meio diferente de acesso ao console. Para fazer isso, devemos proteger as linhas VTY.

### Protegendo o modo de usuário

Uma linha VTY é um “canal” ao qual o usuário pode se conectar para gerenciar o dispositivo. Cada conexão telnet ou SSH com o dispositivo ocupará uma linha VTY e, se todas as linhas estiverem ocupadas, nenhuma outra conexão poderá ser feita com esse dispositivo. Como usuário, você começa a “ocupar” uma linha assim que efetua login. Isso significa que um invasor pode saturar todas as linhas e impedir que você gerencie seu próprio switch! Devemos colocar uma senha nisso, e isso é extremamente simples.

LabSwitch ( config ) #

LabSwitch ( config ) #line vty 0 15

LabSwitch ( config-line ) #password cisco

LabSwitch ( config-line ) #exit

LabSwitch ( config ) #

Desta forma, apenas definimos uma senha (que é *“cisco”* ) em todas as linhas VTY, de 0 a 15. Porém, esta senha é armazenada em texto simples. Se quisermos que todas as senhas sejam criptografadas na configuração, devemos ativar um serviço específico. Não se preocupe, esta é uma tarefa de comando único. O serviço a ser habilitado é chamado de *“criptografia de senha”* e você pode ativá-lo da seguinte maneira.

LabSwitch ( config ) #

LabSwitch ( config ) #service senha-criptografia

LabSwitch ( config ) #

Isso criptografará todas as senhas já na configuração e cada nova senha que você adicionar.

### Habilitando o acesso VTY

Agora que garantimos o acesso VTY, devemos ativá-lo. Para isso, devemos selecionar o tipo de conexão que vamos aceitar: telnet, SSH ou ambos. Em um ambiente de produção, você deseja usar apenas SSH, uma vez que todo o tráfego é criptografado. No entanto, nesta configuração de switch, vamos apenas para **telnet** . O motivo para isso é que a configuração do dispositivo para conexões SSH requer mais configuração e está fora do escopo deste artigo. Em vez disso, ativar a conexão telnet para as linhas VTY é muito simples.

LabSwitch ( config ) #

LabSwitch ( config ) #line vty 0 15

LabSwitch ( config-line ) #transport input telnet

LabSwitch ( config-line ) #exit

O comando que usamos para especificar qual protocolo é aceito é `transport input`. Como você pode ver no código acima, usamos apenas telnet.

### Salvando a configuração

Depois de terminar de configurar um dispositivo, você deve salvar a configuração. Mesmo se as alterações entrarem em vigor imediatamente, você usará todo o seu trabalho para reinicializar o dispositivo, a menos que salve. Cisco trabalha com duas cópias da configuração, chamados **correndo-configuração** e **inicialização-configuração** . Quando o dispositivo é inicializado, ele copia todo o conteúdo da configuração de inicialização para a configuração em execução. Em seguida, o dispositivo usa a configuração de execução e qualquer alteração feita é aplicada a essa configuração. Uma vez que você dispositivo para salvar, você emite um comando específico e o dispositivo copia todo o conteúdo da configuração de execução para a configuração de inicialização.

Para salvar a configuração, você pode emitir dois comandos que fazem a mesma coisa. A versão clássica é `copy running-configuration startup-configuration`, enquanto a versão curta é `write`. Você pode emitir esses comandos apenas no prompt Privileged Exec.

Agora, aqui vai uma **dica** : você pode passar do modo de configuração para o modo exec privilegiado digitando end. No entanto, você pode digitar qualquer comando exec privilegiado de qualquer modo de configuração se adicionar `do`antes dele. Por exemplo, se você estiver na configuração global, poderá digitar `do write`.

Para visualizar o conteúdo da configuração, use `show running-configuration`e `show startup-configuration`. Já que o conteúdo vai ser bem longo, você terá que apertar enter ou barra de espaço várias vezes para ver tudo. Observe que as configurações padrão são omitidas.

### Verifique seu laboratório

Como essa tarefa de configuração de switch era uma atividade do Packet Tracer, você pode ver a porcentagem de conclusão no painel de atividades. No entanto, apenas para ver se você configurou tudo corretamente, vá no prompt de comando do PC remoto e digite `telnet 192.168.1.2`. Deverá ser solicitada uma senha, que deve ser *“cisco”* , e ver o seu *banner motd* .

![Configuração do switch: acesso telnet](https://www.ictshore.com/wp-content/uploads/2017/01/1023-04-Telnet_access.png)Aqui estamos nos conectando via telnet ao switch.

## Conclusão

*Parabéns!* Você concluiu sua primeira configuração de switch. Antes de passar para outro tópico, podemos aproveitar este laboratório já construído para ver como o encaminhamento da Camada 2 funciona. Entender como um switch funciona será extremamente útil na solução de problemas e é uma habilidade obrigatória para todo engenheiro de rede. Siga nosso curso CCNA com os links abaixo para saber mais!