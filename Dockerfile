## debconf: delaying package configuration, since apt-utils is not installed
#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
FROM debian:stable-slim

COPY *.sh ./
RUN chmod +x *.sh && sh insdeb.sh
    #apt-get -y --no-install-recommends install software-properties-common

WORKDIR /app
CMD ["R"]
