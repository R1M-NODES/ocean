#!/bin/bash

# Підключення загальних функцій та змінних з репозиторію
source <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/common.sh)

# Відображення логотипу
printLogo

# Встановлення Docker та Docker Compose
printGreen "Install Docker and Docker Compose"
bash <(curl -s https://raw.githubusercontent.com/R1M-NODES/utils/master/docker-install.sh)

# Додавання правил для UFW
printGreen "Configuring UFW rules"
sudo ufw allow 8004/tcp
sudo ufw allow 9004/tcp
sudo ufw allow 9005/tcp
sudo ufw allow 9006/tcp
sudo ufw allow 9007/tcp

# Оновлення системи та встановлення curl
printGreen "Updating system and installing curl"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install curl -y

# Створення директорії та завантаження скрипта для Ocean Node
printGreen "Setting up Ocean Node"
mkdir ocean && cd ocean
curl -O https://raw.githubusercontent.com/oceanprotocol/ocean-node/main/scripts/ocean-node-quickstart.sh && chmod +x ocean-node-quickstart.sh && ./ocean-node-quickstart.sh

# Запуск контейнерів через Docker Compose
printGreen "Starting Docker containers"
docker-compose up -d

# Перегляд логів контейнерів
printGreen "Displaying Docker logs"
docker-compose logs -f
