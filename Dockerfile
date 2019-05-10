FROM golang:1.12.5-stretch as builder

WORKDIR /app

# Modules
COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./ ./

# Build
RUN go build -o issue-196 ./...

FROM ubuntu:18.04
COPY --from=builder /app/issue-196 /usr/local/bin

RUN apt-get update && \
    apt-get install -y strace

CMD ["bash", "-c", "strace issue-196 2>&1 | grep newfstatat | wc -l"]
