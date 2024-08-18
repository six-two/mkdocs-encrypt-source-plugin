#!/bin/bash
# This script is used to build the documentation (for the vercel hosted website)

# Switch to the directory of this file
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Use venv if defined. Not needed on vercel (would only slow down builds), so I do not create a new one if none exists
if [[ -f venv/bin/activate ]]; then
    echo "[*] Using venv"
    source venv/bin/activate
fi

# install the dependencies
python3 -m pip install -r requirements.txt
# also install the latest (dev) version of this package
python3 -m pip install .

# Vercel prefers outputs to be in public/
python3 -m mkdocs build -d public

