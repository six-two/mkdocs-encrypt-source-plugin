---
encrypt-source-plugin-skip-file: true
---

# Usage

First generate a new key by encrypting your first text:
```bash
$ echo MySecretIs... | mkdocs-encrypt-source-cli -e 
[*] Encrypted with key: WCFY7FJ2TlpXIG0nEqpSltXTAYB9gO3Ob6tS-psY9-s=
{ENCRYPTED:gAAAAABmwc09oIZGo9JwK3G8CEVoeNiHrgePZGy2S3cp2033oLZvBsulFnMpZXk5MJWCi7JVDHtplWoKSNLS1MsaU2CrYaEwQQ==}
```

Take the key from the output and export it to the `MKDOCS_ENCRYPT_SOURCE_KEY` environment variable:
```bash
export MKDOCS_ENCRYPT_SOURCE_KEY='WCFY7FJ2TlpXIG0nEqpSltXTAYB9gO3Ob6tS-psY9-s='
```

Now for any further texts you encrypt, the same key will be reused:
```bash
$ echo '__import__("subprocess").call("bash")' | mkdocs-encrypt-source-cli -e
{ENCRYPTED:gAAAAABmwc41Y07vVg17WThIso9QDt7SMn_EqgxPCKE4Uxy-Abp26kLRAviHDa-wL5J80F_Fp9anaNVJQoSD_QeljL_br_Npu-eYPN6xUu9pZ4SmDuwW113SfWP0nzzIX1WMNwc8Muej}
```

If you are unsure what is in a snipped, but do not want to build the whole site, you can use the CLI to decrypt it for you. You can also pass a whole Markdown page containing multiple encrypted blobs as input, the tool will find and decrypt them all:
```bash
echo 'First generate ...: {ENCRYPTED:gAAAAABmwc09oIZGo9JwK3G8CEVoeNiHrgePZGy2S3cp2033oLZvBsulFnMpZXk5MJWCi7JVDHtplWoKSNLS1MsaU2CrYaEwQQ==} ... Now any further ... {ENCRYPTED:gAAAAABmwc41Y07vVg17WThIso9QDt7SMn_EqgxPCKE4Uxy-Abp26kLRAviHDa-wL5J80F_Fp9anaNVJQoSD_QeljL_br_Npu-eYPN6xUu9pZ4SmDuwW113SfWP0nzzIX1WMNwc8Muej}' | mkdocs-encrypt-source-cli -d
First generate ...: MySecretIs...
 ... Now any further ... __import__("subprocess").call("bash")
```
