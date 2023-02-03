########## How To Use Docker Image ###############
##
##  Image Name: codyfp/monitor-docker-discord:latest
##  Git link: https://github.com/DennyZhang/monitor-docker-slack/blob/master/Dockerfile
##  Docker hub link:
##  Build docker image: docker build --no-cache -t denny/monitor-docker-discord:latest --rm=true .
##  How to use:
##      https://github.com/DennyZhang/monitor-docker-slack/blob/master/README.md
##
##  Description: Send slack alerts, if any containers run into unhealthy
##
##  Read more: https://www.dennyzhang.com/docker_monitor
##################################################
# Base Docker image: https://hub.docker.com/_/python/

FROM python:latest

ENV DISCORD_WEBHOOK_URL ""
ENV MSG_PREFIX ""
ENV WHITE_LIST ""

# seconds
ENV CHECK_INTERVAL "300"

LABEL maintainer="Cody<cody@gecko.rent>"

USER root
WORKDIR /

ADD requirements.txt /requirements.txt

RUN pip install -r requirements.txt && \
# Verify docker image
    pip show requests-unixsocket | grep "0.1.5"

ADD monitor-docker-discord.py /monitor-docker-discord.py
ADD monitor-docker-discord.sh /monitor-docker-discord.sh

RUN chmod o+x /*.sh && chmod o+x /*.py

ENTRYPOINT ["/monitor-docker-discord.sh"]
