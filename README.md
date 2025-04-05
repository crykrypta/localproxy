# Squid Proxy Service

Простой HTTP/HTTPS прокси-сервер с аутентификацией, развернутый в Docker.

## Requirements
- Docker

## Структура

```
squid_proxy_service/
├── Dockerfile          # Конфигурация Docker-образа
├── docker-compose.yml  # Конфигурация Docker Compose
├── squid.conf          # Конфигурация Squid
├── init.sh             # Скрипт инициализации
└── README.md           # Документация
```

## Быстрый старт

1. Перенос файлов
```
scp -r username@host:/home/username/some_folder ./external_codedestination
```

2. Запустите контейнер:
```bash
docker-compose up -d
```

3. Создайте первого пользователя:
```bash
docker-compose exec squid htpasswd -c /etc/squid/passwords admin
# Введите пароль при запросе
# Повторите пароль при запросе
```
- `-c` - означает "создать новый файл"

4. Добавьте дополнительных пользователей (если необходимо):
```bash
docker-compose exec squid htpasswd /etc/squid/passwords user1
# Введите пароль при запросе
# Повторите пароль при запросе
```

## Использование прокси

### Через curl
```bash
curl -x http://username:password@localhost:3128 https://ipinfo.io
```

### В браузере
- Адрес прокси: localhost
- Порт: 3128
- Логин: ваш_логин
- Пароль: ваш_пароль

### В других приложениях
```
http://username:password@localhost:3128
```

## Управление пользователями

### Добавление нового пользователя
```bash
docker-compose exec squid htpasswd /etc/squid/passwords новый_пользователь
```

### Изменение пароля пользователя
```bash
docker-compose exec squid htpasswd /etc/squid/passwords существующий_пользователь
```

### Удаление пользователя
```bash
docker-compose exec squid nano /etc/squid/passwords
# Удалите строку с пользователем и сохраните файл
```

## Управление сервисом

### Запуск
```bash
docker-compose up -d
```
- `-d` - "detached" mode, чтобы запустить контейнер "фоном"

### Остановка
```bash
docker-compose down
```

### Перезапуск
```bash
docker-compose restart
```

### Просмотр логов
```bash
docker-compose logs -f
```
- `-f` - "follow" для слежения за логами в реальном времени

## Конфигурация

Основные настройки прокси находятся в файле `squid.conf`:

- Порт прокси: 3128
- Поддерживаемые протоколы: HTTP, HTTPS
- Аутентификация: Basic Auth
- Разрешенные сети: localhost, Docker network, указанные IP-адреса

## Безопасность

- Все пароли хранятся в захешированном виде
- Доступ к прокси возможен только после аутентификации
- По умолчанию разрешен доступ только с localhost и указанных IP-адресов

## Устранение неполадок

1. Проверьте статус контейнера:
```bash
docker-compose ps
```

2. Проверьте логи:
```bash
docker-compose logs
```

3. Проверьте конфигурацию:
```bash
docker-compose exec squid squid -k parse
```
