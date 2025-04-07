

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

📁 **CISCO-CCNA**  
│  
├── 📂 **1-Certification-Guide**  
│   ├── 📄 Exam-Topics.md  
│   └── 📄 Study-Plan.pdf  
│  
├── 📂 **2-Network-Fundamentals**  
│   ├── 📂 OSI-TCPIP-Models  
│   ├── 📂 IPv4-IPv6-Subnetting  
│   └── 📂 Network-Topologies  
│  
├── 📂 **3-Infrastructure**  
│   ├── 📂 Routing-Protocols  
│   │   ├── 🧪 OSPF-Labs.pkt  
│   │   └── 📝 OSPF-CheatSheet.md  
│   ├── 📂 Switching  
│   └── 📂 Wireless  
│  
├── 📂 **4-Security**  
│   ├── 🔒 ACLs  
│   └── 🔐 VPNs  
│  
├── 📂 **5-Labs**  
│   ├── 🖥️ Packet-Tracer  
│   └️── ⚙️ GNS3  
│  
├── 📂 **Resources**  
│   ├── 📋 Cheat-Sheets  
│   └── 🎥 Video-Tutorial


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
1. Faça um fork do projeto
2. Crie sua branch:
bash
git checkout -b feature/nova-funcionalidade

3. Commit suas mudanças:
bash
git commit -m "Adiciona laboratório de VLANs"

4. Envie para o repositório:
bash
git push origin feature/nova-funcionalidade

5. Abra um Pull Request detalhando suas alterações.

📌 Requisitos:
Mantenha a estrutura de pastas
Documente novos laboratórios em /notes
Teste scripts antes de enviar
_______________________________________________________________________________________
📜 Licença

Distribuído sob licença MIT. Consulte o arquivo LICENSE para detalhes.
Cisco®, CCNA® são marcas registradas da Cisco Systems, Inc.
________________________________________________________________________________________
📞 Contato

    Autor: Felipe Silva

    LinkedIn: https://www.linkedin.com/in/felipe-batista-da-silva-analista-de-suporte/


Visite o Repositório
