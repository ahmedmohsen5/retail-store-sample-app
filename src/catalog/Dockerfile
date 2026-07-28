FROM golang:1.25-alpine AS build

RUN apk add --no-cache \
    git \
    ca-certificates \
    gcc \
    musl-dev

WORKDIR /build 

ENV GOPROXY=https://proxy.golang.org,direct

COPY go.mod go.sum ./

RUN go mod download \
    && go mod verify

COPY . .

RUN CGO_ENABLED=1 \
    GOOS=linux \
    go build \
    -trimpath \
    -ldflags="-s -w" \
    -o /out/main .
FROM alpine:3.22 AS runtime

ARG BUILD_VERSION=dev
ARG BUILD_REVISION=unknown
ARG BUILD_DATE=unknown

LABEL org.opencontainers.image.title="retail-catalog" \
      org.opencontainers.image.description="Catalog microservice for the retail store application" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.revision="${BUILD_REVISION}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.source="https://github.com/ahmedmohsen5/retail-store-sample-app"

RUN apk add --no-cache ca-certificates curl

ARG APP_UID=1000
ARG APP_GID=1000

RUN addgroup \
        -S \
        -g "${APP_GID}" \
        appgroup \
    && adduser \
        -S \
        -D \
        -H \
        -u "${APP_UID}" \
        -G appgroup \
        appuser
WORKDIR /app

COPY --from=build \
    --chown=appuser:appgroup \
    /out/main /app/main

USER appuser

EXPOSE 8080

ENTRYPOINT ["/app/main"]