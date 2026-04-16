FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# Installation des paquets
RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    iputils-ping \
    net-tools \
    nano \
    python3 \
    sudo \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# SSH setup
RUN mkdir -p /var/run/sshd && ssh-keygen -A

# Configuration SSH
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'Port 22' >> /etc/ssh/sshd_config
RUN echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config

# Mot de passe root
RUN echo "root:password" | chpasswd

# Ports
EXPOSE 80 22

# Lancer SSH + nginx
CMD service ssh start && nginx -g 'daemon off;'
