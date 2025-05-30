FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN go build -o server .

FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /app/server .
COPY --from=builder /app/templates ./templates

CMD ["./server"]
