FROM ubuntu:18.04
LABEL maintainer="lixianfa.official@gmail.com"
ENV REFRESHED_AT 2020-03-31

COPY sources.list /etc/apt/sources.list
RUN apt update && \
    apt install -y dialog apt-utils && \
    apt install -y ca-certificates ruby ruby-dev gcc g++ make nodejs
RUN gem install --no-rdoc --no-ri jekyll && apt clean

VOLUME /data
VOLUME /var/www/html
WORKDIR /data

ENTRYPOINT [ "jekyll", "build", "--destination=/var/www/html" ]
