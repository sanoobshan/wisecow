FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/usr/games"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    fortune-mod \
    fortunes \
    cowsay \
    netcat-openbsd \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash appuser
WORKDIR /app

COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh \
 && chown -R appuser:appuser /app

USER appuser
ENV SRVPORT=4499
EXPOSE 4499
CMD ["/app/wisecow.sh"]
