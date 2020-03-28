FROM ubuntu:18.04
LABEL maintainer="lixianfa.official@gmail.com"
ENV REFRESHED_AT 2020-03-24
RUN wget -O /etc/apt/sources.list https://mirrors.huaweicloud.com/repository/conf/Ubuntu-Ports-bionic.listapt \
    apt update && \
    apt install -y dialog apt-utils ruby ruby-dev gcc g++ make nodejs
RUN gem install --no-rdoc --no-ri jekyll

VOLUME /data
VOLUME /var/www/html
WORKDIR /data

ENTRYPOINT [ "jekyll", "build", "--destination=/var/www/html" ]
