
source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1grbnd43egs57caqic6"
  image_description   = "my custom debian with docker"
  image_name          = "debian-11-docker"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "e9b0jrtedvmepp55pohc"
  token               = "y0__xDVs5..."
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = ["echo 'Starting provisioning...'"]
  }

  provisioner "shell" {
    inline = [
      # Отключаем проблемный репозиторий bullseye-backports
      "sudo sed -i '/bullseye-backports/d' /etc/apt/sources.list",
      "sudo sed -i '/bullseye-backports/d' /etc/apt/sources.list.d/*.list 2>/dev/null || true",
      
      # Обновление пакетного менеджера (игнорируя ошибки backports)
      "sudo apt-get update -y --allow-releaseinfo-change 2>/dev/null | grep -v 'Failed'",
      
      # Установка зависимостей для apt HTTPS
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
      
      # Добавление GPG-ключа Docker
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      
      # Добавление репозитория Docker
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      
      # Обновление пакетов после добавления репозитория
      "sudo apt-get update -y",
      
      # Установка Docker Engine
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      
      # Установка htop и tmux с автоматическим подтверждением
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y htop tmux",
      
      # Добавление пользователя debian в группу docker (чтобы не использовать sudo)
      "sudo usermod -aG docker debian",
      
      # Включение автозапуска Docker (опционально)
      "sudo systemctl enable docker",
      
      # Проверка установки
      "docker --version",
      "htop --version",
      "tmux -V"
    ]
  }

  provisioner "shell" {
    inline = ["echo 'Provisioning completed successfully!'"]
  }
}
