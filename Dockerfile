FROM golang:1.22-alpine as builder

RUN set -x && apk add --update git musl-dev gcc && GOPATH=/tmp/gocode go install github.com/mailhog/MailHog@latest

FROM alpine:latest
WORKDIR /bin
COPY --from=builder tmp/gocode/bin/MailHog /bin/MailHog
EXPOSE 1025 8025
ENTRYPOINT ["MailHog"]
