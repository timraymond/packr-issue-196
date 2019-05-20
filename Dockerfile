FROM golang:1.12.5-stretch as builder

RUN apt-get update && \
    apt-get install strace

WORKDIR /app

# Modules
COPY ./go.mod ./go.sum ./
RUN go mod download

COPY ./ ./

# Build
RUN go build -o issue-196 ./...
