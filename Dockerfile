FROM alpine:3.10

ENV KUBECTL_VERSION=v1.16.0
ENV KUBECTL_SHA256=4fc8a7024ef17b907820890f11ba7e59a6a578fa91ea593ce8e58b3260f7fb88

RUN \
    set -ex; \
    apk add --no-cache bash curl jq tini; \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
    [ "$KUBECTL_SHA256  kubectl" = "$(sha256sum kubectl)" ] || exit 1; \
    chmod +x ./kubectl; \
    mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT [ "tini", "--" ]
