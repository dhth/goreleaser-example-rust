#!/usr/bin/env bash

set -euxo pipefail

version="0.1.7"
os="linux"
arch="amd64"
url="https://github.com/dhth/goreleaser-example-rust/releases/download/v${version}"

curl -sSLO "${url}/goreleaser-example-rust_${version}_checksums.txt"
curl -sSLO "${url}/goreleaser-example-rust_${version}_checksums.txt.pem"
curl -sSLO "${url}/goreleaser-example-rust_${version}_checksums.txt.sig"

cosign verify-blob "goreleaser-example-rust_${version}_checksums.txt" \
    --certificate "goreleaser-example-rust_${version}_checksums.txt.pem" \
    --signature "goreleaser-example-rust_${version}_checksums.txt.sig" \
    --certificate-identity-regexp 'https://github\.com/dhth/goreleaser-example-rust/\.github/workflows/.+' \
    --certificate-oidc-issuer "https://token.actions.githubusercontent.com"

curl -sSLO "${url}/goreleaser-example-rust_${version}_${os}_${arch}.tar.gz"
sha256sum --ignore-missing -c "goreleaser-example-rust_${version}_checksums.txt"

tar -xzf "goreleaser-example-rust_${version}_${os}_${arch}.tar.gz"
