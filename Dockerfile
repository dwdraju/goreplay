FROM alpine:3.18 as builder

ARG RELEASE_VERSION
ARG GITHUB_REPOSITORY_OWNER

RUN apk add --no-cache ca-certificates openssl
RUN wget https://github.com/${GITHUB_REPOSITORY_OWNER}/goreplay/releases/download/${RELEASE_VERSION}/gor_${RELEASE_VERSION}_x64.tar.gz -O gor.tar.gz
RUN tar xzf gor.tar.gz

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /gor .
ENTRYPOINT ["./gor"]
