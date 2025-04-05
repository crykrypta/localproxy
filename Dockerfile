FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y squid apache2-utils

COPY squid.conf /etc/squid/squid.conf
COPY init.sh /init.sh

RUN chmod +x /init.sh

EXPOSE 3128

CMD ["/init.sh"]