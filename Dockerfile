FROM golang:1.12.6-alpine3.9 as builder

RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/DirectXMan12/prom-load-tool.git /go/src/github.com/directxman12/prom-load-tool
WORKDIR /go/src/github.com/directxman12/prom-load-tool
RUN go build

FROM alpine:3.9.4

ENV NUM_FAMILIES 2
ENV NUM_SERIES 3
EXPOSE 8080

COPY --from=builder /go/src/github.com/directxman12/prom-load-tool/prom-load-tool /
COPY run.sh /

CMD ["/run.sh"]


