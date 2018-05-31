FROM golang:1.10 as build

COPY . /go/src/github.com/improbable-eng/thanos

WORKDIR /go/src/github.com/improbable-eng/thanos

RUN go get -d ./...
RUN make
RUN strip thanos

FROM quay.io/prometheus/busybox:latest
LABEL maintainer="The Thanos Authors"

COPY --from=build /go/src/github.com/improbable-eng/thanos/thanos /bin/thanos

USER nobody

ENTRYPOINT [ "/bin/thanos" ]
