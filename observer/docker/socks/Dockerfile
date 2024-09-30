# Используем базовый образ
FROM alpine:latest
RUN apk add --no-cache dante-server
COPY sockd.conf /etc/sockd.conf
EXPOSE 1080
ENV PASS password
RUN printf "${PASS}\n${PASS}\n" | adduser logstashfilebeater
CMD sockd -f /etc/sockd.conf -N 2