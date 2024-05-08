#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
FROM debian:unstable-slim

COPY install_packs.sh ./
RUN chmod +x *.sh && sh install_packs.sh
    #apt-get -y --no-install-recommends install software-properties-common

WORKDIR /app
CMD ["R"]
