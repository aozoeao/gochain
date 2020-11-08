FROM golang:latest AS builder
RUN go version
RUN mkdir app
COPY . app
WORKDIR app
RUN set -x && \
	go get github.com/julienschmidt/httprouter && \
	go get github.com/lib/pq 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main-app
EXPOSE 8000

FROM scratch
COPY --from=builder /main-app .
EXPOSE 8000
CMD ["/main-app"]
