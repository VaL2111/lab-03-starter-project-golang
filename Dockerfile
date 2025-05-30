FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

FROM scratch

WORKDIR /app

COPY --from=builder /app/server .
COPY --from=builder /app/templates ./templates

CMD ["/app/server"]
