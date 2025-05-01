FROM golang:1.24 as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
ARG APP="sdfsfsfs"
RUN CGO_ENABLED=0 GOOS=linux go build -o app -ldflags "-s -w" ./src/${APP}/main.go

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/app .
ENTRYPOINT ["/app/app"]

