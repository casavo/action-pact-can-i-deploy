#!/bin/sh

if [ "$VERSION" != "" ] && [ "$TAG" != "" ]
then
  echo "ERROR: specify only 'version' or 'latest', not both."
  exit 1
fi

CMD_VERSION="--latest"
[ "$VERSION" != "" ] && CMD_VERSION="--version $VERSION"
[ "$TAG" != "" ] && CMD_VERSION="--latest $TAG"

docker run --rm \
    -e PACT_BROKER_USERNAME \
    -e PACT_BROKER_PASSWORD \
    pactfoundation/pact-cli:latest \
    broker can-i-deploy \
    --broker-base-url=${PACT_BROKER_BASE_URL} \
    --pacticipant=${PACTICIPANT} \
    --to=${TO} \
    ${CMD_VERSION}