#!/usr/bin/env bash
set -exo pipefail

TWINE_OPTS=""
if [[ "$INPUT_SKIP_EXISTING" == true ]]; then
  TWINE_OPTS="$TWINE_OPTS --skip-existing"
fi

if [[ -n "$INPUT_GPG_KEY" ]]; then
  gpg --import <(echo "$INPUT_GPG_KEY")
  TWINE_OPTS="$TWINE_OPTS --sign-with gpg"
fi

if [[ -n "$INPUT_URL" ]]; then
  export TWINE_REPOSITORY_URL="$INPUT_URL"
fi

if [[ "$INPUT_BUILD" == true ]]; then
  python setup.py check -mrs
  python setup.py sdist bdist_wheel
fi

TWINE_USERNAME="$INPUT_USER" TWINE_PASSWORD="$INPUT_PASSWORD" \
  exec twine upload $TWINE_OPTS "${INPUT_DIST_DIR%%/}"/*
