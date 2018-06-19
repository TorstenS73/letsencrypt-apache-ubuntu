FROM ubuntu:18.04
MAINTAINER Torsten Schlabach <tschlabach@gmx.net>

# avoid timeouts waiting for user input,
# especially when it comes to tzdata
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /data

RUN apt-get update && apt-get install -y \
	tzdata \
        apache2 \
        git

RUN echo "" > /var/www/html/index.html
RUN git clone https://github.com/letsencrypt/letsencrypt
RUN /data/letsencrypt/letsencrypt-auto --help

RUN apache2ctl -D BACKGROUND

EXPOSE 80 443

CMD ["apache2ctl", "-D", "FOREGROUND"]
