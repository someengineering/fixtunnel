FROM zerotier/zerotier:1.12.2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        locales \
        dumb-init \
        iptables \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY bootstrap /usr/local/sbin/bootstrap

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/sbin/bootstrap", "/entrypoint.sh"]
