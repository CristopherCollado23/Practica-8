FROM ubuntu:22.04

# Evitar interacciones durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar servidor SSH, sudo y herramientas básicas
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configurar el directorio para el servicio SSH
RUN mkdir /var/run/sshd

# Crear el usuario 'ansible' con contraseña 'ansible'
RUN useradd -ms /bin/bash ansible && \
    echo 'ansible:ansible' | chpasswd

# Dar privilegios de sudo sin contraseña al usuario 'ansible'
RUN echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Exponer el puerto SSH
EXPOSE 22

# Iniciar el servidor SSH en primer plano
CMD ["/usr/sbin/sshd", "-D"]