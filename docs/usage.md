---
encrypt-source-plugin-skip-file: true
---

# Usage

## Installation

Install the plugin:
```bash
pip install mkdocs-encrypt-source-plugin
```

Then add the plugin in your `mkdocs.yml`. If you have not defined the `plugins` key you may also want to add the `search` plugin:
```yaml
plugins:
- search
- encrypt-source
```

## Encrypt contents

First generate a new key by encrypting your first text:
```bash
$ echo MySecretIs... | mkdocs-encrypt-source-cli -e 
[*] Encrypted with key: WCFY7FJ2TlpXIG0nEqpSltXTAYB9gO3Ob6tS-psY9-s=
{ENCRYPTED:gAAAAABmwc09oIZGo9JwK3G8CEVoeNiHrgePZGy2S3cp2033oLZvBsulFnMpZXk5MJWCi7JVDHtplWoKSNLS1MsaU2CrYaEwQQ==}
```

The `{ENCRYPTED:gAAAAA...}` value can be placed anywhere in your page's content.
It will be expanded during the Markdown parsing, so you can put it in listings, tables, etc.
Just make sure to not include newlines at the end (use `echo -n`), when you inject input to somewhere sensitive to newlines like a table.

Take the key from the output and export it to the `MKDOCS_ENCRYPT_SOURCE_KEY` environment variable:
```bash
export MKDOCS_ENCRYPT_SOURCE_KEY='WCFY7FJ2TlpXIG0nEqpSltXTAYB9gO3Ob6tS-psY9-s='
```

Now for any further texts you encrypt, the same key will be reused:
```bash
$ echo '__import__("subprocess").call("bash")' | mkdocs-encrypt-source-cli -e
{ENCRYPTED:gAAAAABmwc41Y07vVg17WThIso9QDt7SMn_EqgxPCKE4Uxy-Abp26kLRAviHDa-wL5J80F_Fp9anaNVJQoSD_QeljL_br_Npu-eYPN6xUu9pZ4SmDuwW113SfWP0nzzIX1WMNwc8Muej}
```

As long as all blobs are encrypted with the same key, you can add as many blobs as you want. If you edit the website on multiple machines, you need to declare the same value on them too. If you build the website using CI/CD pipelines, you need to add the same variable there too.

## Decrypt contents

If the `MKDOCS_ENCRYPT_SOURCE_KEY` environment variable is set up currectly, just running `mkdocs serve` or `mkdocs build` decrypts the encrypted values and builds the page.

If you are unsure what is in a snippet/encrypted blob, but do not want to build the whole site, you can use the CLI to decrypt it for you. You can also pass a whole Markdown page containing multiple encrypted blobs as input, the tool will find and decrypt them all:
```bash
echo 'First generate ...: {ENCRYPTED:gAAAAABmwc09oIZGo9JwK3G8CEVoeNiHrgePZGy2S3cp2033oLZvBsulFnMpZXk5MJWCi7JVDHtplWoKSNLS1MsaU2CrYaEwQQ==} ... Now any further ... {ENCRYPTED:gAAAAABmwc41Y07vVg17WThIso9QDt7SMn_EqgxPCKE4Uxy-Abp26kLRAviHDa-wL5J80F_Fp9anaNVJQoSD_QeljL_br_Npu-eYPN6xUu9pZ4SmDuwW113SfWP0nzzIX1WMNwc8Muej}' | mkdocs-encrypt-source-cli -d
First generate ...: MySecretIs...
 ... Now any further ... __import__("subprocess").call("bash")

[*] Decrypted 2 blobs
```
