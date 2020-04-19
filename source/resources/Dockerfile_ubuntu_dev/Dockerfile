FROM ubuntu:18.04
LABEL maintainer="lixianfa.official@gmail.com"
ENV REFRESHED_AT 2020-04-18

COPY sources.list /etc/apt/sources.list
RUN apt update && \
    apt install -y dialog apt-utils && \
    apt install -y ca-certificates ruby ruby-dev gcc g++ make cmake openssh-server openssh-client openssh-sftp-server ssh-import-id vim git
RUN apt clean && mkdir -p /run/sshd && echo 'root:root' |chpasswd && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

VOLUME /root/user1
WORKDIR /root/user1/

EXPOSE 22
ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]
