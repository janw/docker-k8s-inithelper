FROM alpine:3

ENV KUBECTL_VERSION=v1.27.1
ENV KUBECTL_SHA512=98caa662a63d7f9ba36761caaf997be4d214ea2b921a4387965a67d168b52ea29ae9185de20192f7b4b9169a887beb19d22e5776ff0bb0b68907e177b11a8043

# hadolint ignore=DL3018
RUN \
    set -ex; \
    apk add --no-cache bash curl jq tini; \
    curl -SsL --fail https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-linux-amd64.tar.gz -o ktl.tar.gz; \
    [ "$KUBECTL_SHA512  ktl.tar.gz" = "$(sha512sum ktl.tar.gz)" ] || exit 1; \
    tar -xzvf ktl.tar.gz; \
    mv ./kubernetes/client/bin/kubectl /usr/local/bin/kubectl; \
    chmod +x /usr/local/bin/kubectl

ENTRYPOINT [ "tini", "--" ]
