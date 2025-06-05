# Stage1: Build the pvc-autoresizer binary
FROM golang:1.23 AS builder

WORKDIR /workspace
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# Copy the go source
COPY constants.go constants.go
COPY cmd/ cmd/
COPY internal/ internal/

# Build
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -a -o pvc-autoresizer cmd/*.go

# Stage2: setup runtime container
FROM alpine:latest
RUN apk add --no-cache bash curl
WORKDIR /
COPY --from=builder /workspace/pvc-autoresizer .
EXPOSE 8080
USER 10000:10000

CMD ["/pvc-autoresizer"]
