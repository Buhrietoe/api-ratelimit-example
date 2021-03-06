FROM golang:1-alpine AS build
COPY . /go/src/github.com/Buhrietoe/api-ratelimit/
WORKDIR /go/src/github.com/Buhrietoe/api-ratelimit/
ENV CGO_ENABLED 0
RUN go build -v -ldflags "-s -w" -o arl .

FROM scratch
LABEL maintainer "Jason Gardner <buhrietoe@gmail.com>"
EXPOSE 8080
COPY --from=build /go/src/github.com/Buhrietoe/api-ratelimit/arl /arl
ENTRYPOINT ["/arl"]
CMD ["-config", "/conf/arl.json"]
