FROM bash:5.2-alpine3.19
ARG HOST

COPY pusher.sh /
RUN apk add --no-cache curl
CMD ["bash", "/pusher.sh", "$HOST"]