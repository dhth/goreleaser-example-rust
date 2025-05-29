A sample project to test releasing rust binaries using [goreleaser][1].

[1]: https://github.com/goreleaser/goreleaser

🔐 Verifying release artifacts
---

1. Download the following files from the release:

   ```text
   - goreleaser-example-rust_A.B.C_checksums.txt
   - goreleaser-example-rust_A.B.C_checksums.txt.pem
   - goreleaser-example-rust_A.B.C_checksums.txt.sig
   ```

2. Verify the signature:

   ```shell
   cosign verify-blob goreleaser-example-rust_A.B.C_checksums.txt \
       --certificate goreleaser-example-rust_A.B.C_checksums.txt.pem \
       --signature goreleaser-example-rust_A.B.C_checksums.txt.sig \
       --certificate-identity-regexp 'https://github\.com/dhth/goreleaser-example-rust/\.github/workflows/.+' \
       --certificate-oidc-issuer "https://token.actions.githubusercontent.com"
   ```

3. Download the compressed archive you want, and validate its checksum:

   ```shell
   curl -sSLO https://github.com/dhth/goreleaser-example-rust/releases/download/vA.B.C/goreleaser-example-rust_A.B.C_linux_amd64.tar.gz
   sha256sum --ignore-missing -c goreleaser-example-rust_A.B.C_checksums.txt
   ```

3. If checksum validation goes through, uncompress the archive:

   ```shell
   tar -xzf goreleaser-example-rust_A.B.C_linux_amd64.tar.gz
   ./goreleaser-example-rust
   ```
