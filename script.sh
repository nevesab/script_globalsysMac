#!/bin/bash
# Declarando os sites como strings no formato 'id:name'
sites=("1:Matriz" "2:DBA/RPA" "3:Fábrica" "4:Infraestrutura" "5:Marketing" 
"6:Estoque" "7:RH" "8:Adm/Finan" "9:Box027" "10:Analytics" 
"11:Outsourcing" "12:Manutenção" "13:Produtos Digitais" "14:Atento")

# Listando os sites
echo "Lista de Sites:"
for site in "${sites[@]}"; do
    IFS=':' read -ra ADDR <<< "$site"
    echo "ID: ${ADDR[0]}, Nome: ${ADDR[1]}"
done

# Solicitando ao usuário para inserir o ID do site
read -p "Insira o ID do site desejado: " site_id

# Verificando a arquitetura
echo "Selecione a arquitetura:"
echo "1) amd64"
echo "2) arm64"
read -p "Escolha uma opção (1 ou 2): " arch_choice

# Definindo as URLs e tokens com base na arquitetura
if [ "$arch_choice" == "1" ]; then
    
url='https://agents.tacticalrmm.com/api/v2/agents/?version=2.6.1&arch=arm64&token=dfd43613-e70b-4d03-8259-fc5e0809d7fa&plat=darwin&api=apitactical.globalsys.com.br'
    
token='eccb7b60084f5855c343fca5a8b3d55908e7f18a43a500597fd1de226e67ebea'
    file='tacticalagent-v2.5.0-darwin-amd64'
elif [ "$arch_choice" == "2" ]; then
    
url='https://agents.tacticalrmm.com/api/v2/agents/?version=2.6.1&arch=arm64&token=dfd43613-e70b-4d03-8259-fc5e0809d7fa&plat=darwin&api=apitactical.globalsys.com.br'
    
token='1655e54124c4ba1f5f8d66b86dc45980235015740715447f2a91b3d799e7a903'
    file='tacticalagent-v2.5.0-darwin-arm64'
else
    echo "Opção inválida."
    exit 1
fi

# Executando o comando de instalação
if curl -L -o "$file" "$url"; then
    sudo chmod +x "$file"
    sudo ./"$file" -m install \
    --api "https://apitactical.globalsys.com.br" \
    --client-id 1 \
    --site-id "$site_id" \
    --agent-type workstation \
    --auth "$token"
else
    echo "Erro ao baixar o arquivo."
fi
