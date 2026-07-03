FROM docker.io/mirakc/mirakc:debian
RUN set -eux \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl wget jq socat git unzip \
    cmake g++ gcc make build-essential autoconf automake pkg-config libpcsclite-dev pcscd pcsc-tools libccid \
    && git clone https://github.com/enprocode/recdvb-enable-b25-shell.git ~/recdvb-enable-b25-shell \
    && git -C ~/recdvb-enable-b25-shell checkout f92834104f45110981dcf598b082377df5f7a7f2 \
    && git clone https://github.com/enprocode/libaribb25.git ~/recdvb-enable-b25-shell/lib/libaribb25 \
    && git -C ~/recdvb-enable-b25-shell/lib/libaribb25 checkout c30cbd1357f08129da59c2fcd01a0b1be50220c5 \
    && git clone https://github.com/enprocode/recdvb.git ~/recdvb-enable-b25-shell/lib/recdvb \
    && git -C ~/recdvb-enable-b25-shell/lib/recdvb checkout 86b8e8cbca68a96927f8d9719a6ca641935cbf89 \
    && /bin/bash ~/recdvb-enable-b25-shell/shell/libaribb25_install.sh \
    && /bin/bash ~/recdvb-enable-b25-shell/shell/recdvb_install.sh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/tmp/* \
    && rm -rf /tmp/*
COPY mirakc/mirakc_init.sh /usr/local/bin/mirakc_init.sh
RUN chmod 775 /usr/local/bin/mirakc_init.sh
EXPOSE 40772
ENV MIRAKC_CONFIG=/etc/mirakc/config.yml
VOLUME ["/var/lib/mirakc/epg"]
ENTRYPOINT ["/usr/local/bin/mirakc_init.sh"]