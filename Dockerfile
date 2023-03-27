FROM alpine
COPY entrypoint.sh /
RUN apk add gcompat
RUN mkdir -p /opt
RUN wget $(wget https://api.github.com/repos/xmrig/xmrig/releases/latest -q -O - | grep browser_download_url | grep -oE "https://github.com/.*linux-x64.tar.gz") -O /tmp/xmrig-linux-x64.tar.gz
RUN tar -xf /tmp/xmrig-linux-x64.tar.gz -C /opt
RUN chmod +x entrypoint.sh
CMD ["sh", "/entrypoint.sh"]