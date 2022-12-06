#!/usr/bin/env bash

if [ "$VERSION" != "" ] && [ "$TAG" != "" ]
then
  echo "ERROR: specify only 'version' or 'latest', not both."
  exit 1
fi

CMD_VERSION="--latest"
[ "$VERSION" != "" ] && CMD_VERSION="--version $VERSION"
[ "$TAG" != "" ] && CMD_VERSION="--latest $TAG"

MISSING=()
[ ! "$PACT_BROKER_BASE_URL" ] && MISSING+=("PACT_BROKER_BASE_URL")
[ ! "$PACT_BROKER_USERNAME" ] && MISSING+=("PACT_BROKER_USERNAME")
[ ! "$PACT_BROKER_PASSWORD" ] && MISSING+=("PACT_BROKER_PASSWORD")

if [ ${#MISSING[@]} -gt 0 ]; then
  echo "ERROR: The following environment variables are not set:"
  printf '\t%s\n' "${MISSING[@]}"
  exit 1
fi

MISSING=()
[ ! "$PACTICIPANT" ] && MISSING+=("PACTICIPANT")

if [ ${#MISSING[@]} -gt 0 ]; then
  echo "ERROR: The following required inputs are not set:"
  printf '\t%s\n' "${MISSING[@]}"
  exit 1
fi

echo "
  PACT_BROKER_BASE_URL: '$PACT_BROKER_BASE_URL'
  pacticipant: '$PACTICIPANT'
  version/tag: '$VERSION'
  to: $TO
"

docker run --rm \
    -e PACT_BROKER_USERNAME \
    -e PACT_BROKER_PASSWORD \
    pactfoundation/pact-cli:latest \
    broker can-i-deploy \
    --broker-base-url=${PACT_BROKER_BASE_URL} \
    --pacticipant=${PACTICIPANT} \
    --to=${TO} \
    ${CMD_VERSION}
