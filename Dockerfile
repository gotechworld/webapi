# The stage at which the application is built
FROM --platform=linux/arm64 golang:1.19-alpine AS builder
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o main .

# The stage at which the application is deployed
FROM --platform=linux/arm64 alpine:3.16
COPY --from=builder /app/main .
EXPOSE 8080
ENTRYPOINT ["/main"]
