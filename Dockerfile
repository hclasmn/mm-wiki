FROM golang:1.14.1-alpine

ENV TZ=Asia/Shanghai

WORKDIR /app
RUN apk add --no-cache git && \
    git clone https://github.com/hclasmn/mm-wiki.git && \
    cd mm-wiki && \
    ./goinstall.sh && \
    go build ./ && \
    cd install && \
    go build ./

FROM alpine:latest

COPY --from=0 /app/mm-wiki /mm-wiki

WORKDIR /mm-wiki
CMD ["/mm-wiki/mm-wiki", "--conf", "/mm-wiki/conf/mm-wiki.conf"]