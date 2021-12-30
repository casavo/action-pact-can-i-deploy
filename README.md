# Pact Can I Deploy Action

This action uses [pact-cli](https://github.com/pact-foundation/pact-ruby-cli) 
docker image to perform an opinionated "can I deploy" check:

```console
$ pact broker can-i-deploy --pacticipant <PACTICIPANT> --version <COMMIT_SHA> --to <ENVIRONMENT>
```

## Inputs

Action inputs are (hopefully) kept in sync with relation option of [`can-i-deploy` command](https://github.com/pact-foundation/pact_broker-client#can-i-deploy) from `pact-cli`
 
### `pacticipant`

**Required** The pacticipant name.

### `version`

**Required** The pacticipant version.

### `to`

**Required** The tag that represents the branch or environment of the integrated applications for which you want to check the verification result status.

## Environment Variables

Setup environment variable used by `pact-cli`.

### `PACT_BROKER_BASE_URL`

**Required** The base URL of the Pact Broker

### `PACT_BROKER_USERNAME`

**Required** Pact Broker basic auth username

### `PACT_BROKER_PASSWORD`

**Required** Pact Broker basic auth password

## Usage Example

```yml
steps:
  # ...
  - uses: casavo/pact-can-i-deploy-action@v2
    env:
      PACT_BROKER_BASE_URL: ${{ secrets.PACT_BROKER_BASE_URL }}
      PACT_BROKER_PASSWORD: ${{ secrets.PACT_BROKER_PASSWORD }}
      PACT_BROKER_USERNAME: ${{ secrets.PACT_BROKER_USERNAME }}
    with:
      pacticipant: my-application
      version: ${GITHUB_SHA}
      to: staging
  # ...
```
