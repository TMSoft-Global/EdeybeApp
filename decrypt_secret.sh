#!/bin/sh
gpg --quiet --batch --yes --decrypt --passphrase="$APPSTORE_AUTHKEY" --output fastlane/app-store-connect-auth.json fastlane/app-store-connect-auth.json.gpg