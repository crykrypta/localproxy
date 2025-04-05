#!/bin/bash

# Создаем директорию для логов, если её нет
mkdir -p /var/log/squid
chown -R proxy:proxy /var/log/squid

# Создаем файл с паролями, если его нет
if [ ! -f /etc/squid/passwords ]; then
    touch /etc/squid/passwords
    chown proxy:proxy /etc/squid/passwords
    chmod 640 /etc/squid/passwords
fi

# Запускаем Squid
exec squid -N -d 1