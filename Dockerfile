FROM ubuntu:latest

LABEL \
maintainer="dennis.newel@newelcorp.com" \
version="1.0" \
description="This is a basic docker image that uses latest ubuntu to \
create a service that can send slack messages. To send the messages, `slack-cli` \
 (https://github.com/rockymadden/slack-cli) is used"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get upgrade -y

RUN apt-get install curl -y

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# the slack cli depends on jq
ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 jq
RUN chmod +x jq

# get and install the slack cli
RUN curl -O https://raw.githubusercontent.com/rockymadden/slack-cli/master/src/slack
RUN chmod +x slack

ENV PATH=$PATH:/usr/src/app
ENV SLACK_CLI_TOKEN=xoxp-2151229761-2151229763-136851378339-abb286ef2c7944de3fa460575c3d3951

#CMD [ "slack" "chat" "send"]

CMD [ "slack chat send", "message", "channel" ]
