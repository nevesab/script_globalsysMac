#!/bin/bash
# Declarando os sites como strings no formato 'id:name'
sites=("1:Adm/Finan" "2:Analytics" "3:Atento" "4:Box027" "5:DBA/RPA" 
"6:Estoque" "7:Fábrica" "8:Infraestrutura" "9:Manutenção" "10:Marketing" 
"11:Matriz" "12:Outsourcing" "13:Produtos Digitais" "14:RH")

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
    
url='https://agents.tacticalrmm.com/api/v2/agents/?version=2.5.0&arch=amd64&token=dfd43613-e70b-4d03-8259-fc5e0809d7fa&plat=darwin&api=apitactical.globalsys.com.br'
    
token='42cdcdb098131498615f75781a687a97433d1b8a42efc1d17218ede222237c22'
    file='tacticalagent-v2.5.0-darwin-amd64'
elif [ "$arch_choice" == "2" ]; then
    
url='https://agents.tacticalrmm.com/api/v2/agents/?version=2.5.0&arch=arm64&token=dfd43613-e70b-4d03-8259-fc5e0809d7fa&plat=darwin&api=apitactical.globalsys.com.br'
    
token='e0ec9158e848217ecdfc694f61789eff39fad8d367eaa86d59272739655394e2'
    file='tacticalagent-v2.5.0-darwin-arm64'
else
    echo "Opção inválida."
    exit 1
fi

# Executando o comando de instalação
if curl -L -o "$file" "$url"; then
    sudo chmod +x "$file"
    sudo ./"$file" -m install --api "https://apitactical.globalsys.com.br" --client-id 1 --site-id "$site_id" --agent-type workstation --auth "$token"
else
    echo "Erro ao baixar o arquivo."
fi
