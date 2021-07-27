FROM alpine

RUN apk add --no-cache bash curl openssl \
  && mkdir -p /opt/dehydrated \
  && curl -s \
    "https://raw.githubusercontent.com/dehydrated-io/dehydrated/master/dehydrated" \
    -o /opt/dehydrated/dehydrated \
  && chmod a+x /opt/dehydrated/dehydrated \
  && curl -s \
    "https://raw.githubusercontent.com/walcony/letsencrypt-DuckDNS-hook/master/hook.sh" \
    -o /opt/dehydrated/hook.sh \
  && chmod a+x /opt/dehydrated/hook.sh

ENV DUCKDNS_TOKEN=""
ENV ADDRESS=""

CMD /opt/dehydrated/dehydrated --accept-terms --cron --domain ${ADDRESS} --challenge dns-01 --hook '/opt/dehydrated/hook.sh' --out /ssl