

# 🚀 CISCO-CCNA - Preparação para Certificação CCNA 200-301

[![GitHub last commit](https://img.shields.io/github/last-commit/Felipe-Batista-Silva/CISCO-CCNA)](https://github.com/Felipe-Batista-Silva/CISCO-CCNA/commits/main)
[![GitHub license](https://img.shields.io/github/license/Felipe-Batista-Silva/CISCO-CCNA)](https://github.com/Felipe-Batista-Silva/CISCO-CCNA/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Felipe-Batista-Silva/CISCO-CCNA)](https://github.com/Felipe-Batista-Silva/CISCO-CCNA/stargazers)

Repositório oficial com laboratórios práticos, anotações estruturadas e recursos para a certificação **CCNA 200-301**.  
✨ **Destaques**:  
- Laboratórios com Packet Tracer e GNS3  
- Scripts Python para automação de redes  
- Resumos dos tópicos oficiais do exame  

---

## 📚 **Conteúdo Organizado**

### 📂 Estrutura do Projeto

/CISCO-CCNA
│
├── /0-Certification-Guide # Recursos oficiais para a prova
│ ├── Exam-Topics.md # Lista de tópicos do CCNA 200-301
│ └── Study-Plan.pdf # Cronograma de estudos sugerido
│
├── /1-Network-Fundamentals # Conceitos básicos
│ ├── OSI-TCPIP-Models/
│ ├── IPv4-IPv6-Subnetting/
│ └── Network-Topologies/
│
├── /2-Infrastructure # Infraestrutura de rede
│ ├── Routing-Protocols/ # OSPF, EIGRP, BGP
│ │ ├── OSPF-Labs.pkt
│ │ └── OSPF-CheatSheet.md
│ │
│ ├── Switching/ # VLANs, STP, EtherChannel
│ └── Wireless/
│
├── /3-Network-Security
│ ├── ACLs/
│ ├── VPNs/
│ └── Firewalls/
│
├── /4-Automation # Automação e programação
│ ├── Python-Scripts/ # Netmiko, Paramiko
│ └── Ansible-Playbooks/
│
├── /5-Labs # Laboratórios completos
│ ├── Packet-Tracer/ # .pkt files
│ ├── GNS3/ # .gns3 projects
│ └── Real-Equipment/ # Configs para hardware real
│
├── /6-Troubleshooting
│ ├── Common-Issues.md
│ └── Methodology.pdf
│
├── /Resources
│ ├── Cheat-Sheets/ # Comandos rápidos Cisco IOS
│ ├── Diagrams/ # .drawio, .png de topologias
│ └── Video-Tutorials/ # Links para demonstrações
│
└── /Tools # Ferramentas auxiliares
├── IP-Calculators/
└── Config-Generators/



### 📌 Progresso dos Módulos
| Tópico                | Status         | Arquivos Relacionados       |
|-----------------------|----------------|-----------------------------|
| Network Fundamentals  | ✅ 100%        | `/notes/network-basics.md`  |
| IPv4/IPv6 Subnetting  | ✅ 100%        | `/labs/subnetting.pkt`      |
| Routing Protocols     | ⏳ 80%         | `/labs/ospf-lab.gns3`       |
| Network Security      | 🚧 30%         | `/notes/security.md`        |

---

## 🛠️ **Ferramentas Recomendadas**
| Ferramenta            | Descrição                          | Link                          |
|-----------------------|------------------------------------|-------------------------------|
| Cisco Packet Tracer   | Simulação básica de redes          | [Download](https://www.netacad.com/) |
| GNS3                  | Laboratórios avançados             | [Site Oficial](https://www.gns3.com/) |
| Wireshark             | Análise de tráfego de rede         | [Download](https://www.wireshark.org/) |

---

## 💻 **Exemplo de Configuração Cisco**
```cisco
! Configuração básica de roteador
enable
configure terminal
hostname R1
!
interface GigabitEthernet0/0
 ip address 192.168.1.1 255.255.255.0
 no shutdown
!
router ospf 1
 network 192.168.1.0 0.0.0.255 area 0

🔄 Como Contribuir

    Faça um fork do projeto

    Crie sua branch:
    bash
    Copy

    git checkout -b feature/nova-funcionalidade

    Commit suas mudanças:
    bash
    Copy

    git commit -m "Adiciona laboratório de VLANs"

    Envie para o repositório:
    bash
    Copy

    git push origin feature/nova-funcionalidade

    Abra um Pull Request detalhando suas alterações.

📌 Requisitos:

    Mantenha a estrutura de pastas

    Documente novos laboratórios em /notes

    Teste scripts antes de enviar

📜 Licença

Distribuído sob licença MIT. Consulte o arquivo LICENSE para detalhes.
Cisco®, CCNA® são marcas registradas da Cisco Systems, Inc.
📞 Contato

    Autor: Felipe Batista Silva

    LinkedIn: Seu Perfil

    Email: seu-email@provedor.com

Visite o Repositório
