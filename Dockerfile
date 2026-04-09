FROM golang:1.26-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
COPY tls-local-cert.crt /tls-local-cert.crt
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /fiber-api
# For Mac build, use the following command:
# RUN CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -o /fiber-api

FROM alpine:3.23 AS release
WORKDIR /
RUN mkdir -p /certs

COPY --from=build /fiber-api /fiber-api
COPY --from=build /tls-local-cert.crt /certs/tls-local-cert.crt

RUN apk --no-cache add ca-certificates && update-ca-certificates

EXPOSE 3001
ENTRYPOINT ["/fiber-api"]