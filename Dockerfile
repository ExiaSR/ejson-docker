# Build stage
FROM golang:1.12.17-alpine3.11 as builder

ENV EJSON_NAME=ejson
ENV EJSON_PACKAGE=github.com/Shopify/ejson
ENV EJSON_VERSION=v1.2.1
ENV EJSON_REPO_URL=https://github.com/Shopify/ejson.git

ENV GO111MODULE=on

WORKDIR /build

RUN apk add --no-cache git

RUN git clone -b ${EJSON_VERSION} --single-branch --depth 1 ${EJSON_REPO_URL}

WORKDIR /build/ejson

RUN go mod download && \
    go mod tidy && \
    go build -o /bin/ejson ${EJSON_PACKAGE}/cmd/${EJSON_NAME}

# Copy binary to a empty base image
FROM scratch

WORKDIR /secretsdir

COPY --from=builder /bin/ejson /bin/ejson

ENTRYPOINT [ "/bin/ejson" ]
