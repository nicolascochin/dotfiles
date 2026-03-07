#!/bin/sh

# exit immediately if pass-cli is already in $PATH
type pass-cli >/dev/null 2>&1 && exit

echo "Install ProtonPass CLI"
curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
pass-cli login
