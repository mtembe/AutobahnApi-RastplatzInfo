
FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN go mod download

RUN go build -o main .

FROM gcr.io/distroless/static-debian12:latest

WORKDIR /app

COPY --from=builder /app/main .

EXPOSE 6379

ENTRYPOINT ["./main"]

