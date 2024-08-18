# Intro

I|github|six-two/mkdocs-encrypt-source-plugin|
I|pypi|mkdocs-encrypt-source-plugin|
L|Documentation|https://mkdocs-encrypt-source-plugin.six-two.dev/|

This plugin allows you to store sensitive information in encrypted form it the source code.
When you build the site, it is decrypted using a key you pass as an enviroment variable.
This means only people with the key or access to the deployed website can access the information.
It also prevents code scanning tools from checking the data you store encrypted.

I personally use it to hide certain offensive tooling (modified AMSI bypasses, Cobalt Strike C2 profiles, etc) in my private notes from GitHub (who are owned by Microsoft, which also develop Windows Defender and other security products).
Since the deployed website is protected using [authentication](https://github.com/six-two/mkdocs-vercel-pw-plugin), the data should be only accessible to Vercel and anyone with the password.
