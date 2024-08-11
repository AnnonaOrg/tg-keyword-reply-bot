FROM golang:alpine3.18 as builder

RUN apk add --no-cache git build-base
WORKDIR /src
COPY . /src
RUN git checkout master && \
	go mod tidy && \
    go mod download && \
    make linux-amd64 && \
    mv ./bin/bot-linux-amd64 /bot

FROM alpine:3.18

COPY --from=builder /bot /
ENTRYPOINT ["/bot"]