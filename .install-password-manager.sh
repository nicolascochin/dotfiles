#!/bin/sh

# exit immediately if pass-cli is already in $PATH
type pass-cli >/dev/null 2>&1 && exit

echo "Install ProtonPass CLI"
curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
# log in only without a valid session (a kept session makes `pass-cli login` fail)
pass-cli info >/dev/null 2>&1 || pass-cli login
