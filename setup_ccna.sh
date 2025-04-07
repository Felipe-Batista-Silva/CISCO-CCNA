#!/bin/bash

# Criar a estrutura principal
mkdir -p CISCO-CCNA/{Teoria/{Conceitos-Básicos,Protocolos,Subredes,Segurança},Laboratórios/{Packet-Tracer,GNS3,Configurações},Exercícios/{Resolvidos,Propostos},Exames/{Simulados,Dumps},Cheat-Sheets}

# Criar arquivo README.md
touch CISCO-CCNA/README.md

# Criar um arquivo .gitkeep em diretórios vazios (opcional, para versionar diretórios vazios no Git)
find CISCO-CCNA -type d -exec touch {}/.gitkeep \;

# Mensagem de conclusão
echo "Estrutura de diretórios para CCNA criada com sucesso!"