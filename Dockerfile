FROM alpine:3.13

# This makes it easy to build tagged images with different `kubectl` versions.
ARG KUBECTL_VERSION="v1.19.11"

# Set by docker automatically
ARG TARGETOS
ARG TARGETARCH

RUN apk upgrade --update-cache --available  && apk add openssl  && \
    wget "http://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"  && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

WORKDIR /app
USER 1000

COPY --chmod=755 ./generate_certificate.sh /app/generate_certificate.sh

CMD ["./generate_certificate.sh"]
