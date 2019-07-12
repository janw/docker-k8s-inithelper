FROM alpine:3.10

RUN \
    apk add --no-cache bash curl jq tini && \
    kubectl_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
    echo "Downloading kubectl $kubectl_version" && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/${kubectl_version}/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT [ "tini", "--" ]
