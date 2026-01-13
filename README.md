# Домашнее задание к занятию "`Применение принципов IaaC в работе с виртуальными машинами`" - `Белов Михаил`

#### Цели задания

1. Научиться создвать виртуальные машины в Virtualbox с помощью Vagrant.
2. Научиться базовому использованию packer в yandex cloud.

### Задание 1

Установите на личный Linux-компьютер или учебную локальную ВМ с Linux следующие сервисы(желательно ОС ubuntu 20.04):

- [VirtualBox](https://www.virtualbox.org/)
![VBox](./img/vbox.png)

- [Vagrant](https://github.com/netology-code/devops-materials), рекомендуем версию 2.3.4
![Vagrant version](./img/vagrant_version.png)

- [Packer](https://github.com/netology-code/devops-materials/blob/master/README.md) версии 1.9.х + плагин от Яндекс Облако по [инструкции](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart)
```
mkdir packer && cd packer
export PATH="$PATH:/home/mike/packer"

# Перезапуск оболочки:
exec -l $SHELL

# Проверка версии packer:
packer --version
```
![Packer version](./img/packer_version.png)

##### Настройка плагина Yandex Compute Builder

Создать файл `config.pkr.hcl` следующего содержания:
```

packer {
  required_plugins {
    yandex = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/yandex"
    }
  }
}

```
Установить плагин:
```
packer init config.pkr.hcl
```
![Plugin installed](./img/plugin_installed.png)

- [yandex cloud cli](https://cloud.yandex.com/ru/docs/cli/quickstart) Так же инициализируйте профиль с помощью `yc init`.
![yc init](./img/yc_init.png)

---

### Задание 2

1. Убедитесь, что у вас есть ssh ключ в ОС или создайте его с помощью команды `ssh-keygen -t ed25519`
2. Создайте виртуальную машину Virtualbox с помощью Vagrant и [Vagrantfile](./src/Vagrantfile) в директории src.
3. Зайдите внутрь ВМ и убедитесь, что Docker установлен с помощью команды:
```
docker version && docker compose version
```
![vagrant ssh](/img/vagrant_ssh.png)
![docker & docker compose versions](/img/docker_and_docker_compose_vers.png)

---

### Задание 3

1. Отредактируйте файл [mydebian.json.pkr.hcl](/src/mydebian.json.pkr.hcl) или mydebian.jsonl в директории src (packer умеет и в json, и в hcl форматы):
- добавьте в скрипт установку docker. Возьмите скрипт установки для debian из [документации](https://docs.docker.com/engine/install/debian/) к docker,
- дополнительно установите в данном образе htop и tmux.(не забудьте про ключ автоматического подтверждения установки для apt)
2. Найдите свой образ в web консоли yandex_cloud
3. Необязательное задание(*): найдите в документации yandex cloud как найти свой образ с помощью утилиты командной строки "yc cli".
4. Создайте новую ВМ (минимальные параметры) в облаке, используя данный образ.
5. Подключитесь по ssh и убедитесь в наличии установленного docker.
6. Удалите ВМ и образ.
7. **ВНИМАНИЕ!** Никогда не выкладываете oauth token от облака в git-репозиторий! Утечка секретного токена может привести к финансовым потерям. После выполнения задания обязательно удалите секретные данные из файла mydebian.json и mydebian.json.pkr.hcl. (замените содержимое токена на "ххххх")

### Задание 4

`Приведите ответ в свободной форме........`

1. `Заполните здесь этапы выполнения, если требуется ....`
2. `Заполните здесь этапы выполнения, если требуется ....`
3. `Заполните здесь этапы выполнения, если требуется ....`
4. `Заполните здесь этапы выполнения, если требуется ....`
5. `Заполните здесь этапы выполнения, если требуется ....`
6. 

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота](ссылка на скриншот)`
