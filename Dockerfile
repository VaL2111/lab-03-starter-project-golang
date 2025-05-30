FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o server .

FROM gcr.io/distroless/static:nonroot

WORKDIR /app

COPY --from=builder /app/server .
COPY --from=builder /app/templates ./templates

USER nonroot

CMD ["/app/server"]
