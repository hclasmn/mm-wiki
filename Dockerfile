FROM golang:1.14.1-alpine

ENV TZ=Asia/Shanghai

WORKDIR /app
RUN apk add --no-cache git && \
    git clone https://github.com/phachon/mm-wiki.git && \
    cd mm-wiki && \
    ./build.sh && \
    go build ./ && \
    cd install && \
    go build ./

FROM alpine:latest

COPY --from=0 /app/mm-wiki /app/mm-wiki

WORKDIR /app/mm-wiki
CMD ["/opt/mm-wiki/mm-wiki", "--conf", "/opt/mm-wiki/conf/mm-wiki.conf"]