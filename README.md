# Pact Can I Deploy Action

This action uses [pact-cli](https://github.com/pact-foundation/pact-ruby-cli) 
docker image to perform an opinionated "can I deploy" check:

```console
$ pact broker can-i-deploy --pacticipant <PACTICIPANT> --version <COMMIT_SHA> --to <ENVIRONMENT>
```