# Camada de rede: o guia definitivo para sub-redes IPv4



No [artigo anterior](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-addressing/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) da série de cursos CCNA, falamos sobre o *endereçamento IPv4* . Sabemos como funcionam os endereços IP e sabemos que se um dispositivo tiver um endereço IP em vez de outro é provavelmente porque alguém decidiu isso. Neste artigo, falaremos sobre a criação de sub-redes com IPv4, a disciplina de rede que define o tamanho das sub-redes, quantos hosts podem suportar e como devem ser posicionados na rede global. Após este artigo, você estará pronto para preparar seu próprio plano de endereçamento IP para sua própria rede. Portanto, vamos começar a mergulhar nas sub-redes IPv4.

## Máscaras de rede e CIDRs

Já sabemos do artigo anterior sobre IPv4 que o esquema de endereçamento classful agora é considerado legado e que foi substituído pelo endereçamento classless, que depende de máscaras de sub-rede. Uma *máscara de sub-rede* , também conhecida como **máscara de rede** , é apenas uma série de uns e zeros que define onde a parte do *ID de rede* dos endereços IP relacionados termina em favor da parte do *ID* do *host* . Para ser ainda mais específico, a máscara de rede tem 32 bits, assim como o endereço IP, e sempre vem com um endereço IP relacionado. Se você sobrepor esse endereço IP com a máscara de sub-rede, a parte do ID da rede corresponderá à `1`parte da máscara de sub-rede, enquanto a parte do ID do host corresponde à `0`parte.



Para representar uma máscara de sub-rede, geralmente usamos a mesma notação pontilhada que o endereço IP, mas isso não só leva tempo para escrever, mas também é difícil de ler (você precisa folhear 4 bits de endereço IP mais 4 bytes de máscaras de rede ) Como a máscara de rede é apenas uma série de `1`seguido por uma série de `0`, não poderia ser mais fácil dizer quantos temos na máscara de sub-rede? Felizmente, para representar a combinação de endereço IP mais máscara de sub-rede de uma forma mais legível por humanos, temos a **notação CIDR** . CIDR significa **Classless Inter-Domain Routing** , e com esta notação, não representamos a máscara de sub-rede com a notação pontilhada, mas simplesmente dizemos *quantos 1s estão contidos nela*. Então, colocamos logo após o endereço IP, com uma barra fazendo a divisão. É por isso que esse sistema também é conhecido como *“notação de barra”* .

![Notação CIDR](https://www.ictshore.com/wp-content/uploads/2016/11/1014-01-CIDR_notation.png)Com a notação CIDR, temos uma maneira fácil de representar máscaras de sub-rede em um formato legível por humanos.

A notação CIDR é possível porque aqueles em uma máscara de sub-rede são *sempre consecutivos* , então você pode apenas contá-los: você nunca terá um `1`depois de `0`em uma máscara de sub-rede. Por causa dessa regra, cada byte de uma máscara de sub-rede pode ter apenas alguns valores específicos, e nem todos os 256 valores possíveis (de 0 a 255) que um byte pode normalmente ter. Por exemplo, o número decimal 93 é escrito em binário como `0101 1101`, que contém uns após zeros, portanto *, não será permitido* em uma máscara de sub-rede. Em vez disso, em uma máscara de sub-rede, podemos ter de 0 a 8 unidades *consecutivas* , trazendo para a tabela **nove** diferentes valores possíveis: 0, 128, 192, 224, 248, 252, 254 e 255. A imagem a seguir explica exatamente isso.

![A montanha da sub-rede](https://www.ictshore.com/wp-content/uploads/2016/11/1014-02-Subnet_Mountain-1.png)Um aumenta nas máscaras de sub-rede, que podem ter apenas nove valores diferentes. Os bits de alto valor estão na parte inferior.

Agora que conhecemos essa maneira diferente (e mais rápida) de representar máscaras de sub-rede, antes de nos aprofundarmos na criação de sub-redes, é hora de entender qual é o seu propósito. Em suma, a criação de sub-redes nos permite otimizar o tamanho de nossa rede, reduzindo o tamanho do domínio de broadcast para realmente se ajustar à dimensão de nossa rede. Basicamente, você começa com a ideia *“Eu tenho que conectar um certo número de dispositivos juntos”* , e então com a sub-rede, você define como eles devem ser **agrupados logicamente** . Você define seu *espaço de endereço* : lembre-se de que o membro do grupo (o dispositivo) é chamado de **host** , enquanto o próprio grupo é a **sub** - **rede** .

![Espaço de endereçamento](https://www.ictshore.com/wp-content/uploads/2016/11/1014-03-Address_space.png)Um espaço de endereço (sub-rede) deve ser reservado para dispositivos contíguos.

Com a sub-rede, você realmente executa esse agrupamento lógico e vai fazer isso para criar um número específico de grupos ou um grupo que pode conter um número específico de dispositivos (ou você ainda terá esses dois requisitos ao mesmo tempo ) No entanto, lembre-se que o membro do grupo é denominado **host** , e é apenas um dispositivo de rede, enquanto o grupo de dispositivos é a **própria** sub **-** rede . Na próxima seção, começaremos a apresentar algumas habilidades práticas para criação de sub-redes e, em seguida, veremos como satisfazer o primeiro requisito.

## Do host para a sub-rede

Antes de explicar como criar a sub-rede ou sub-redes corretas, é obrigatório entender **como recuperar a sub-rede da qual** seu computador faz parte, dados o endereço IP e a máscara de sub-rede. Felizmente, isso é muito fácil. Digamos que conheçamos o *endereço IP* e a *notação CIDR* , a primeira coisa que temos que fazer é escrever a máscara de sub-rede em notação pontilhada. Então, temos que converter o endereço IP e a máscara de sub-rede em notação binária. Agora vem a parte divertida, nós os escrevemos (em binário) um acima do outro como em uma operação matemática, e então realizamos a **operação AND bit** a **bit** , anotando o resultado. Só para refrescar sua memória, `1 AND 0 = 0`, `0 AND 1 = 0`, `0 AND 0 = 0`,`1 AND 1 = 1`. Caso você precise de mais ajuda com matemática binária, verifique [nosso artigo introdutório à matemática binária](https://www-ictshore-com.translate.goog/free-ccna-course/binary-math-introduction/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui) .

Depois de obter um resultado binário, podemos convertê-lo de volta para a *notação pontilhada* e teremos o **endereço** da **sub-rede** , que é um endereço IP especial que indica a própria sub-rede em vez de um host.

![Do host para a sub-rede](https://www.ictshore.com/wp-content/uploads/2016/11/1014-04-From_host_to_subnet.png)Esta imagem explica passo a passo como obter o endereço de sub-rede começando com um endereço IP e notação CIDR. Você tem que escrever todos eles em binário e fazer uma operação AND bit a bit entre IP e máscara.

Agora, aqui vai uma **dica rápida** . Como você pode ver na imagem, há uma linha tracejada azul na operação binária que divide todos os números em duas partes. Colocamos essa linha lá porque este é o lugar onde os consecutivos na máscara de sub-rede terminam: se você olhar para o resultado (sempre binário), verá que antes da linha azul ele é **idêntico ao endereço IP** , e depois da linha , são **apenas zeros** . Essa é a natureza da operação AND, então você pode apenas saber quantos uns estão contidos na máscara de sub-rede, colocar uma divisão virtual lá e apenas escrever o endereço IP como está até aquela linha, então preencher o resto com zeros. Isso vai *te poupar muito tempo*, especificamente com máscaras que correspondem à divisão entre dois bytes (no ponto da notação pontilhada: / 8, / 16 e / 24), porque você pode escrever o endereço IP como está até o ponto e, em seguida, escrever 0 para os bytes após o ponto. Lembre-se disso, será muito útil *criar sub-redes* , como explica a próxima seção.

## Criação de sub-redes

Antes de criarmos sub-redes, precisamos realmente saber o que está dentro de um endereço IP. Ao trabalhar com sub-redes personalizadas, um endereço IP é composto por três partes diferentes: a *principal* , a *ID* da *sub* - *rede* e a *ID* do *host* . Essa é apenas uma maneira lógica de dividir os bits dentro do endereço IP, mas são importantes porque identificam a função dos bits no endereço IP.

Começando com o primeiro bit no endereço IP, temos o identificador **principal** , que é a parte do endereço IP que vem da rede principal e que não pode ser modificada com a criação de sub-redes. Em outras palavras, você recebe uma *rede classful* e pode criar *sub-redes* (fazer *sub-redes* ) a partir dela, mas *não pode modificar a principal* . Imagine que você tem que renovar o interior de uma casa: você pode usar o espaço interno para criar cômodos do tamanho que quiser, mas neste caso, você não pode modificar o perímetro nem o volume da casa. Nesse caso, a rede principal pode ser comparada ao volume da casa que você não pode modificar. O tamanho desta porção *varia dependendo da classe* da rede original (A, B, C).

Então, temos o campo **Subnet ID** . Este campo identifica a sub-rede entre todas as sub-redes que você cria a partir da principal (se convertida para inteiro), e seu comprimento varia de acordo com suas necessidades: você é quem decide o tamanho desse campo. Um campo de ID de sub-rede maior roubará espaço da parte de ID do host e vice-versa. Quanto maior o campo de ID da sub-rede, *mais sub-redes você pode criar* .

Finalmente, temos o campo **Host ID** . O valor desse campo identifica o host em uma sub-rede. O tamanho deste campo é sua escolha, mas lembre-se (como dito acima) de que se você quiser um campo de ID de host maior, terá que sacrificar algum espaço do ID de sub-rede. Quanto maior o ID do host, *mais hosts você pode ter na sub-rede* (portanto, no mesmo grupo). Vale a pena mencionar que um endereço que tem zero no campo Host ID é um *endereço de sub-rede* (ele identifica a sub-rede), e um endereço que tem todos os uns no campo Host ID é o *endereço de transmissão direcionado* para essa sub-rede (don ' lembro o que é uma transmissão direcionada? [Nosso artigo sobre endereçamento IPv4](https://www-ictshore-com.translate.goog/free-ccna-course/network-layer-ipv4-addressing/?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=nl&_x_tr_pto=nui)irá esclarecê-lo). O endereço de sub-rede e o endereço de broadcast direcionado não podem ser atribuídos a um host.

![Principal, ID de sub-rede e ID de host para endereços IP de classe A, B e C](https://www.ictshore.com/wp-content/uploads/2016/11/1014-05-Subnet_ID.png)O principal varia de acordo com as classes de IP, enquanto o ID da sub-rede e o ID do host variam de acordo com as necessidades do engenheiro de rede no espaço restante.

Agora, a maior parte nem sempre é uma rede com classe. Em vez disso, é apenas a *rede-mãe* que você vai dividir em *sub-redes* menores . É o espaço que você recebe e que você deve usar com cuidado para atender às suas necessidades. Agora que sabemos disso, podemos dizer que a criação de *sub-* **redes** é o processo de *dimensionar as partes do ID da sub-rede e do ID do host* para criar um certo número de *sub-redes* que podem conter um certo número de *hosts* cada.

Então, vamos começar com a parte fácil: *criar sub-redes que podem conter um número específico de hosts* . Se isso é o que você precisa fazer, você deve dimensionar cuidadosamente a parte do ID do host de sua rede. Como requisito, você será informado de quantos dispositivos serão conectados a essa sub-rede, e essa é a única coisa de que você precisa para fazer seu trabalho. Geralmente, seu requisito é o número de dispositivos que serão conectados, não o número de endereços. Pode parecer o mesmo, mas não é. Lembre-se de que você deve contar o *endereço de sub-rede* e o *endereço de broadcast direcionado* , que não pode ser atribuído a nenhum dispositivo. Portanto, o número de endereços necessários será o número de hosts, **mais dois**. Obtido o número de endereços, é preciso descobrir qual é **a potência de dois** que resulta em um número *igual ou maior* *que* esse número de endereços. Então, essa potência será *a quantidade de bits* necessários no campo ID do host, a ID da sub-rede ocupará o espaço restante. Dê uma olhada nos exemplos a seguir para esclarecer esse conceito.

![Exemplos de como dimensionar a parte do ID do host de um endereço IP](https://www.ictshore.com/wp-content/uploads/2016/11/1014-06-Sizing_host-ID.png)A parte da ID do host é dimensionada de acordo com quantos hosts ou endereços você precisará para essa sub-rede.

O conceito é idêntico quando *você deseja criar um número específico de sub* - *redes* e não se importa com o número de hosts contido em cada uma. Neste caso, você vê quantas sub-redes deseja e encontra a potência de duas que é *igual ou maior do* que o número de sub-redes que deseja e, então, esse número é **o número de bits que** você terá em seu campo de ID de sub-rede . Para passar para a próxima sub-rede, basta aumentar o valor (não o tamanho) do *campo ID da sub-rede* .

Por exemplo, se você precisar criar quatro sub-redes diferentes de um */ 24 principal* , elas terão uma máscara de *sub-* rede */ 26* , porque 24 bits - 26 bits resultam em 2 bits, e 2 2 = 4, tendo o número de sub-redes você precisava. O ID da sub-rede está logo após o campo principal, portanto, ocupará (neste caso), os dois bits mais altos do último *octeto* (byte). Portanto, a primeira sub-rede terá 0 no último byte, a segunda terá 64 (o último bit do ID da sub-rede foi de 0 para 1, o valor do ID da sub-rede é `01`), 128 (o ID da sub-rede é `10`) e então 192 ( o ID da sub-rede é `11`). Dividir uma rede principal em sub-redes do mesmo tamanho (cada uma com a mesma máscara de sub-rede e contendo o mesmo número de hosts) é chamado**Mascaramento de sub-rede de comprimento fixo (FLSM)** , pois você cria várias sub-redes e todas com a mesma máscara de sub-rede, como na figura abaixo.

![Exemplo de máscara de sub-rede de comprimento fixo (FLSM)](https://www.ictshore.com/wp-content/uploads/2016/11/1014-08-FLSM.png)Com o Fixed-Length Subnet Masking, todas as sub-redes que você cria são do mesmo tamanho. Nesse caso, criamos quatro sub-redes / 26 de tamanho igual.

*FLSM impõe limites sérios*à flexibilidade do design da rede porque todas as sub-redes devem ter o mesmo tamanho. Certamente, é simples, sempre porque as sub-redes devem ter o mesmo tamanho: você sabe que o campo ID da sub-rede tem um tamanho específico, então pode incrementá-lo facilmente para alternar para a próxima sub-rede. Mas, como na imagem abaixo, não precisamos realmente que todas as redes tenham o mesmo tamanho. Em vez disso, há lugares onde precisamos de muitos hosts, mas algumas sub-redes e outros lugares onde muitas sub-redes são necessárias, mas não tantos hosts. Por exemplo, em um ambiente corporativo, edifícios maiores terão mais funcionários e exigirão mais hosts, enquanto edifícios com poucos usuários (como fábricas) exigirão menos endereços. O data center (o local onde você tem todos os servidores), em vez disso, pode conter toneladas de hosts, mas também toneladas de sub-redes, dependendo de seu design.O mundo moderno requer flexibilidade e o FLSM não pode fornecê-la. É por isso que realmente usamos**Mascaramento de sub-rede de comprimento variável (VLSM)** , o tópico principal da próxima seção.

![Plano de endereçamento com Data Center, dois escritórios e uma planta](https://www.ictshore.com/wp-content/uploads/2016/11/1014-07-Addressing_plan.png)Diferentes partes da infraestrutura de TIC em uma empresa requerem diferentes espaços de endereçamento. Todos eles, juntos, criam o plano de endereçamento daquela empresa.

## Máscara de sub-rede de comprimento variável

Todas as sub-redes usadas em uma empresa criam o **plano de endereçamento** para essa empresa. Isso é apenas o que o nome diz, ele define onde estão localizadas as sub-redes dentro da empresa, quais são essas sub-redes e qual o seu tamanho. Para fazer um ótimo plano de endereçamento, o uso do *VLSM* é obrigatório. Com ele, você poderá atender da melhor forma possível a todos os requisitos. Como já sabemos, o *VLSM* permite criar sub-redes de tamanhos diferentes na mesma rede principal, mas, ao fazer isso, você deve ter muito cuidado. Aqui está um exemplo prático.

![O que é VLSM?  Criação de sub-redes de tamanhos diferentes na mesma rede principal](https://www.ictshore.com/wp-content/uploads/2016/11/1014-09-What_is_VLSM.png)Com o VLSM, criamos cinco sub-redes de um único principal, com quatro tamanhos diferentes no total.

À primeira vista pode parecer muito trivial: você coloca uma rede / 25, depois duas / 27 e assim por diante, mas não é. Por exemplo, você não pode colocar uma rede / 25 após uma rede / 27, pelo menos não em nenhum caso. Isso ocorre porque as *sub-redes de um determinado tamanho podem iniciar apenas em bits específicos* : a causa raiz disso está na anatomia da máscara de sub-rede, que pode ter apenas *bits* consecutivos. Os bits específicos onde uma sub-rede pode começar são os que vêm do *FLSM* , por isso pode ser extremamente útil criar algumas **diretrizes** : você sabe que vai precisar de sub-redes de tamanhos específicos, então você faz FLSM de seu principal para cada um desses diferentes tamanhos, mas em vez de reservar o espaço de endereço, você apenas escreve algo como um marco, um ponto de verificação. Então, você pode fazer**VLSM visualmente** , sabendo que uma sub-rede de um determinado tamanho pode começar apenas em seus pontos de verificação na diretriz.

![Etapas e diretrizes de VLSM usando a técnica FLSM](https://www.ictshore.com/wp-content/uploads/2016/11/1014-10-VLSM_steps.png)Para fazer o VLSM adequado, imagine que você tenha que fazer o FLSM, mas em vez de criar sub-redes, apenas crie pontos de verificação que o ajudarão a navegar no mundo do VLSM.

Pode parecer um pouco complexo pela primeira vez, mas com a prática, virá naturalmente para você. Você começará a se lembrar de onde estão os *pontos de verificação* e será capaz de criar sub-redes **mentalmente** . Porém, apenas para ajudá-lo a engolir esses conceitos, preparamos dois exemplos de VLSM: o primeiro está errado e o segundo está OK. Vamos começar com o errado.

A seguir, partimos da `10.1.0.0/16`rede principal e nossa tarefa é criar uma rede / 18 para alguns servidores do Data Center. Tarefa simples, usamos apenas a primeira parte da nossa rede para criar a `10.1.0.0/18`sub - rede, e até isso está tudo ok. Mais tarde, nosso chefe nos pede para criar mais sub-redes: a / 17 e a / 18. Se tentarmos fazer isso nesta ordem, não conseguiremos, porque a rede / 17 não pode simplesmente iniciar após a `10.1.0.0/18`que criamos. Se tentarmos criar algo como `10.1.64.0/17`faremos algo terrivelmente errado, porque se colocarmos o bit a bit AND entre o endereço IP e a máscara de sub-rede ( `255.255.128.0`), obteremos`10.1.0.0/17`, estamos usando a parte do ID do host! Como você pode ver, não há ponto de verificação na linha / 17 na posição em que estamos tentando criar essas sub-redes. Criar a outra sub-rede / 18 e esta sub-rede / 17 funcionará em seu lugar.

![Espaçamento VLSM errado, exemplo de um erro](https://www.ictshore.com/wp-content/uploads/2016/11/1014-11-VLSM_spacing_wrong.png)Com o VLSM, você precisa ter cuidado ao colocar uma sub-rede onde ela possa realmente começar. A sub-rede vermelha / 17 não pode ser colocada lá, não há ponto de verificação para ela na diretriz!

Agora, para o bem de seus olhos, é hora de dar um exemplo de VLSM feito da maneira certa. Nesse caso, começamos a partir da `10.1.0.0/16`rede principal como antes, mas somos orientados a criar cinco sub-redes com 2.048 endereços cada. Começamos isso desde o início da rede principal, criando as sub `10.1.0.0/21`- redes `10.1.32.0/21`. Então, alguns meses depois, nosso chefe entra pela porta para nos pedir uma nova sub-rede / 19. O problema é que não podemos colocá-lo logo após a última sub-rede que criamos. Portanto, temos que deixar algum espaço de endereçamento sem uso para alcançar o próximo ponto de verificação na linha / 19: aqui podemos colocar nossa nova sub-rede, que é`10.1.64.0/19`. Depois de algum tempo, somos instruídos a criar duas novas sub-redes / 18 e, desta vez, ainda temos que deixar algum espaço não utilizado para chegar ao próximo ponto de verificação disponível na linha / 18. Poderemos usar o espaço não utilizado posteriormente, para sub-redes menores.

![Espaçamento VLSM feito da maneira certa](https://www.ictshore.com/wp-content/uploads/2016/11/1014-12-VLSM_spacing_ok.png)Para fazer VLSM, siga as orientações e caso não consiga colocar uma rede onde termina a última rede, basta pular um pouco de espaço e reservá-lo para uso futuro em sub-redes menores.

## Dicas rápidas para criar sub-redes como um profissional

A criação de sub-redes é complexa e crucial ao mesmo tempo. Particularmente nas primeiras vezes que você faz isso, a criação de sub-redes pode levar muito tempo. Portanto, esta seção contém alguns truques úteis para fazer isso muito mais rápido, parecendo um *verdadeiro especialista* .

Uma das ferramentas mais úteis que você pode usar para criar sub-redes mais rapidamente é o **número mágico** . É o número no endereço IP (em notação pontilhada) que muda entre duas sub-redes consecutivas do mesmo tamanho. É extremamente útil quando você precisa *criar várias sub* - *redes contíguas* com a mesma máscara de sub-rede: desta forma, você pode obter todos os endereços de sub-rede sem fazer todos os cálculos binários todas as vezes. Para obter o número mágico, obtenha o endereço IP e o CIDR e, a seguir, obtenha a máscara de sub-rede em notação pontilhada. A partir daí, encontre o octeto (byte) que não é nem 255 nem 0. Este byte vai ser o **octeto interessante**. É aqui que o número vai mudar entre uma sub-rede e a outra (o terceiro byte na sub-rede significa que o octeto interessante é o terceiro byte do endereço IP). Para obter o número mágico, pegamos o valor do octeto interessante na máscara de sub-rede e o subtraímos de 256, como na imagem. Este é o número mágico e você terá que adicionar esse valor ao octeto interessante no endereço de sub-rede para obter o endereço de sub-rede da próxima sub-rede, como na imagem abaixo.

![Sub-rede rápida, o número mágico](https://www.ictshore.com/wp-content/uploads/2016/11/1014-13-Quick-subentting.png)Siga esta imagem para recuperar o octeto interessante e o número mágico em seu endereço IP e, em seguida, crie todas as sub-redes contíguas facilmente.

Se você está trabalhando muito com VLSM, aqui está uma **regra de ouro** : você sempre pode criar uma sub-rede de tamanho igual ou menor que a anterior e anexá-la logo após. Talvez isso nem sempre seja possível, dependendo dos requisitos que você deve atender, mas como regra geral, lembre-se de começar a fazer VLSM a partir das sub-redes maiores (aquelas que contêm mais hosts) para as menores.

E se você realmente não consegue suportar a criação de sub-redes mentalmente, pode usar a tabela a seguir, que contém todas as informações de que precisa para cada sub-rede / CIDR. As linhas em negrito indicam onde a sub-rede é colocada no limite entre dois octetos no endereço IP.

| CIDR     | mascarar            | Bits de ID de host | Endereços      | Hosts          |
| -------- | ------------------- | ------------------ | -------------- | -------------- |
| **/ 8**  | **255.0.0.0**       | **24**             | **16.777.216** | **16.777.214** |
| / 9      | 255.128.0.0         | 23                 | 8.388.608      | 8.388.606      |
| / 10     | 255.192.0.0         | 22                 | 4.194.304      | 4.194.302      |
| / 11     | 255.224.0.0         | 21                 | 2.097.152      | 2.097.150      |
| / 12     | 255.240.0.0         | 20                 | 1.048.576      | 1.048.574      |
| / 13     | 255.248.0.0         | 19                 | 524.288        | 524.286        |
| / 14     | 255.252.0.0         | 18                 | 262.144        | 262.142        |
| / 15     | 255.254.0.0         | 17                 | 131.072        | 131.070        |
| **/ 16** | **255.255.0.0**     | 16                 | **65.536**     | **65.534**     |
| / 17     | 255.255.128.0       | 15                 | 32.768         | 32.766         |
| / 18     | 255.255.192.0       | 14                 | 16.384         | 16.382         |
| / 19     | 255.255.224.0       | 13                 | 8.192          | 8.190          |
| / 20     | 255.255.240.0       | 12                 | 4.096          | 4.094          |
| / 21     | 255.255.248.0       | 11                 | 2.048          | 2.046          |
| / 22     | 255.255.252.0       | 10                 | 1.024          | 1.022          |
| / 23     | 255.255.254.0       | 9                  | 512            | 510            |
| **/ 24** | **255.255.255.0**   | **8**              | **256**        | **254**        |
| / 25     | 255.255.255.128     | 7                  | 128            | 126            |
| / 26     | 255.255.255.192     | 6                  | 64             | 62             |
| / 27     | 255.255.255.224     | 5                  | 32             | 30             |
| / 28     | 255.255.255.240     | 3                  | 16             | 14             |
| / 29     | 255.255.255.248     | 2                  | 8              | 6              |
| / 30     | 255.255.255.252     | 2                  | 4              | 2              |
| / 31     | 255.255.255.254     | 1                  | 2              | 2              |
| **/ 32** | **255.255.255.255** | **0**              | **1**          | **1**          |

Observe que as máscaras de rede / 31 e / 32 têm usos especiais, com / 31 quase não usado. Você deve dedicar algum tempo para ler a tabela e tentar se lembrar de tudo de / 16 a / 32, porque esses são os que você usará na maior parte do tempo.

## Endereços IP privados e públicos

Agora que conhecemos as sub-redes, é hora de dar uma olhada mais detalhada nos endereços IP. Até agora, sabíamos apenas que existem endereços IP, no entanto, com o IPv4 eles podem ser categorizados em endereços públicos e privados. **Os** endereços **públicos** - a maioria deles - são endereços conhecidos na Internet, atribuídos a partir dos **Registros Regionais da Internet (RIRs)** , que os recebem da [**Autoridade para Atribuição de Números**](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.iana.org/) da [**Internet (IANA)**](https://translate.google.com/website?sl=en&tl=pt&nui=1&u=https://www.iana.org/) .

**Os** endereços **privados** , em vez disso, são gerenciados internamente nas empresas e não são conhecidos publicamente na Internet. Uma empresa usará esses endereços para o tráfego interno e outra empresa usará os mesmos endereços para o tráfego interno, sem conflito, porque eles são significativos apenas dentro de uma única empresa e nunca são vistos na Internet. Um mecanismo chamado **Network Address Translation (NAT)** é usado para mapear endereços públicos para endereços privados, veremos isso mais tarde no curso CCNA. Os endereços IPv4 privados disponíveis estão listados na tabela a seguir.

| Sub-rede         | Classe                 | Usar                                                         |
| ---------------- | ---------------------- | ------------------------------------------------------------ |
| `10.0.0.0/8`     | Classe A               | Usado principalmente em empresas.                            |
| `172.16.0.0/12`  | 16 classe B contígua   | Raramente usado em empresas (às vezes, uso de gerenciamento de dispositivo). |
| `192.168.0.0/16` | 256 contíguos Classe C | Usado em redes domésticas e roteadores de prateleira.        |
| `169.254.0.0/16` | Classe B               | Este é o intervalo APIPA (Automatic Private IP Addressing), ou link-local. Um PC que não consegue obter um endereço IP “real” de um servidor DHCP obterá autonomamente um endereço dessa sub-rede. Basicamente, não permite comunicação. |

Endereços IPv4

Há também outra sub-rede que não pode ser usada como endereço público e é `127.0.0.0/8`, esse é o **endereço** do **host local** . Este intervalo de endereços, `127.0.0.1`especificamente, representa *“este mesmo dispositivo”* . Assim, se um dispositivo originar tráfego destinado a esse endereço, ele nem tocará na NIC, permanecerá dentro da CPU. Às vezes, é usado para permitir a comunicação IP entre aplicativos no mesmo dispositivo.

## A importância da sub-rede IPv4

Criar sub-redes é ótimo e ter uma ideia precisa sobre como é usado e por que o ajudará a aprendê-lo. Mais do que isso, você terá um entendimento mais completo do “quadro geral”. Existem duas razões principais para criar sub-redes nas principais redes: *segmentação* e *otimização do* espaço de endereçamento IP. A sub-rede é usada quando planejamos a infraestrutura de uma rede e, como você pode ver, **não envolve a configuração** de dispositivos. Mais tarde, no processo de implantação, alguém configurará a sub-rede decidida durante a criação de sub-redes nos dispositivos.

![A importância da criação de sub-redes, planejamento, design e otimização da rede](https://www.ictshore.com/wp-content/uploads/2016/11/1014-14-The_importance_of_subnetting.png)A sub-rede é usada no plano e design para fazer algumas otimizações na rede.

**Segmentar** a rede é importante porque você pode agrupar dispositivos de acordo com a localização ou funções lógicas. Um agrupamento adequado ( *segmentação* ) será muito útil quando quisermos restringir algum tráfego (dispositivos de um grupo não podem falar com outro grupo ou algo parecido). Também permitirá que você tenha uma infraestrutura limpa e de *fácil manutenção* .

**Otimizar** o espaço de endereçamento também é crucial porque os endereços são limitados e você não quer desperdiçá-los. Com a sub-rede, você pode usar sua rede principal da melhor maneira, criando redes que podem conter apenas o número de hosts necessários, usando o espaço extra em outras sub-redes.

Com esses conceitos em mente, agora você está começando a se tornar um verdadeiro engenheiro de rede. E agora que divulgamos todos os segredos do IPv4, estamos prontos para olhar para o futuro explicando *como funciona o IPv6* . Esse é o propósito do próximo artigo.