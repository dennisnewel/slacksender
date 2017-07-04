# README #

This is a simple dockerfile that can be used as a helper service with [Codeship Pro](https://codeship.com/features/pro) to send slack messages.

# Setup #

## 1. Get a Slack API token ##

You'll need this to be able to push messages to your slack team. 

1. Go to the [Slack oauth test tokens](https://api.slack.com/docs/oauth-test-tokens) and generate a new token for your team. Unfortunately, there's no other simple way of getting a token without implementing full oauth in this slack sender app
2. Copy the generated token and add it to the slacksender.env file

Note that this is not their recommended way to integrate with slack, but that's what's used by the CLI used in the image.

## 2. encrypt the slacksender.env file ##

Since you shouldn't be checking in or storing secrets in plain text, we'll make use of the Codeship feature to encrypt variables. Follow the instructions on the great [Tutorial: Encrypting environemnt variables](https://documentation.codeship.com/pro/getting-started/encryption/) to do this.

## 3. configure the slacksender as a service ##

Download/copy the Dockerfile to e.g. `slacksender.Docker` and place it by your `codeship-services.yml` file.

Then configure your service like this:

```
version: '2'
services:
  slack:
    build:
      context: .
      dockerfile: slacksender.Dockerfile
    cached: true
    encrypted_env_file: slacksender.env.encrypted      
```

# Using Slacksender #

For a full list of parameters you can use, refer to the [slack-cli](https://github.com/rockymadden/slack-cli) readme page.

Here's an example of how slacksender could be used in your `codeship-steps.yml` file to send a green message to a channel called 'notifications':

```
- type: serial
  name: production
  tag: master
  steps:
    - service: api
      command: ./test.sh
    - service: slack
      name: slack notification
      command: slack chat send -tx "testing on master successful" -ch notifications --color good
```

# Testing #

* TBD
*
*


