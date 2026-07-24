# Terraform Module: VM Deployment

Модуль для развёртывания виртуальных машин в Yandex Cloud с поддержкой нескольких окружений.

## Структура проекта

```
Task_1/
├── modules/
│ └── vm/
│ ├── variables.tf # Входные параметры модуля
│ ├── main.tf # Основная конфигурация ресурсов
│ ├── outputs.tf # Выходные значения модуля
│ └── versions.tf # Настройки провайдера и версии Terraform
├── envs/
│ ├── dev/
│ │ ├── main.tf # Конфигурация для dev‑окружения
│ │ └── dev.tfvars # Параметры для dev
│ ├── stage/
│ │ ├── main.tf # Конфигурация для stage‑окружения
│ │ └── stage.tfvars # Параметры для stage
│ └── prod/
│ ├── main.tf # Конфигурация для prod‑окружения
│ └── prod.tfvars # Параметры для prod
└── README.md # Эта документация
    ../Task_2/.github/workflows/terraform-deploy.yaml
```

## Назначение файлов модуля (`modules/vm/`)

### `variables.tf`
Определяет входные параметры модуля с валидацией:
* `cpu_cores` — количество ядер CPU (≥ 1);
* `memory_gb` — объём RAM в ГБ (≥ 1 ГБ);
* `disk_size_gb` — размер дополнительного диска в ГБ (по умолчанию 50 ГБ, ≥ 10 ГБ);
* `subnet_id` — ID подсети для размещения ВМ;
* `ssh_key` — открытый SSH‑ключ для доступа (помечен как `sensitive`).

### `main.tf`
Основная конфигурация ресурсов:
* создаёт виртуальную машину с заданными CPU и RAM;
* настраивает загрузочный диск (Ubuntu 22.04 LTS, 10 ГБ);
* подключает дополнительный диск заданного размера;
* размещает ВМ в указанной подсети с NAT;
* передаёт SSH‑ключ через метаданные.

### `outputs.tf`
Возвращает ключевые идентификаторы и адреса:
* `vm_id` — ID виртуальной машины;
* `vm_ip` — публичный IP‑адрес ВМ;
* `disk_id` — ID подключённого диска.

### `versions.tf`
Задаёт требования к окружению:
* версия Terraform ≥ 1.0.0;
* провайдер Yandex Cloud (версия ~> 0.90).

## Окружения и их параметры

Каждое окружение имеет:
* отдельный файл конфигурации (`main.tf`);
* файл переменных (`*.tfvars`) с уникальными параметрами;
* собственное состояние Terraform (изолировано от других окружений).

### Параметры окружений

| Параметр | Dev | Stage | Prod |
|--------|---------|-----------|---------|
| CPU cores | 2 | 4 | 8 |
| RAM (GB) | 4 | 8 | 16 |
| Disk size (GB) | 50 | 100 | 200 |
| Subnet ID | `e2ld6g3j9g6167644qad` | `e2ld6g3j9g6167644qae` | `e2ld6g3j9g6167644qaf` |

## Использование

### Предварительные требования

* Terraform версии 1.0.0 или выше;
* аккаунт в Yandex Cloud;
* настроенные credentials для провайдера Yandex Cloud;
* SSH‑ключ (для доступа к ВМ).

### Пошаговая инструкция

1. **Клонируйте репозиторий** или создайте структуру папок вручную.
2. **Настройте SSH‑ключ:** убедитесь, что файл `~/.ssh/id_rsa.pub` существует.
3. **Перейдите в папку нужного окружения** и выполните команды:

#### Для Dev‑окружения:
```bash
cd envs/dev
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```
#### Для Stage‑окружения:
```bash

cd envs/stage
terraform init
terraform plan -var-file="stage.tfvars"
terraform apply -var-file="stage.tfvars"
```

#### Для Prod‑окружения:
```bash

cd envs/prod
terraform init
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```
