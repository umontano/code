## debconf: delaying package configuration, since apt-utils is not installed
#custom-args: --platform=linux/arm64,linux/amd64 # multiple target architectures
#FROM debian:stable-slim
FROM debian:bookworm
LABEL maintainer="umontano"

COPY *.sh ./
#apt-get -y --no-install-recommends install software-properties-common
RUN chmod +x *.sh && sh insdeb.sh

ENV HOME=/app
WORKDIR /app
CMD ["R"]
