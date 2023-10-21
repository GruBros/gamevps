FROM ubuntu:latest

RUN apt update && \
    DEBIAN_FRONTEND="noninteractive" apt install -y wget bash curl ca-certificates nginx iproute2 zip unzip sudo openssh-server

RUN useradd -m -p $(openssl passwd -1 1234) defaultuser
RUN usermod -aG sudo liven

# Configure SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config

USER root

WORKDIR /
RUN git clone https://github.com/GruBros/gamevps.git

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
