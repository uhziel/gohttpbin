# syntax=docker/dockerfile:1

FROM golang:1.22 AS builder
ARG TARGETOS
ARG TARGETARCH

RUN go env -w GOPROXY=https://goproxy.cn,direct

WORKDIR /workspace
COPY go.mod ./
RUN go mod download

COPY main.go main.go

RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} go build -a -o gohttpbin main.go

FROM cgr.dev/chainguard/static
WORKDIR /
COPY --from=builder /workspace/gohttpbin .
USER 65532:65532

ENTRYPOINT ["/gohttpbin"]

