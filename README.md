This is built from:
<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/fork_github.png" /></a>

[![Build Status](https://travis-ci.org/dennyzhang/monitor-docker-slack.svg?branch=master)](https://travis-ci.org/dennyzhang/monitor-docker-slack) [![Docker](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/docker.png)](https://hub.docker.com/r/denny/monitor-docker-slack/)

[![LinkedIn](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/linkedin_icon.png)](https://www.linkedin.com/in/dennyzhang001) [![Github](https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/github.png)](https://github.com/DennyZhang) <a href="https://www.dennyzhang.com/slack" target="_blank" rel="nofollow"><img src="http://slack.dennyzhang.com/badge.svg" alt="slack"/></a>

- File me [tickets](https://github.com/DennyZhang/monitor-docker-slack/issues) or star [the repo](https://github.com/DennyZhang/monitor-docker-slack)


But has been changed for use with discord webhooks.

# Introduction
Get Discord Notifications, When Containers Run Into Issues

Read more: https://www.dennyzhang.com/docker_monitor

# General Idea
1. Start a container in the target docker host.
2. This container will query status for all containers.

```curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/json```

3. Send discord notifications, we get matched of "unhealthy"

# How To Use: Plain Container
- Specify discord credentials via env

```
export DISCORD_WEBHOOK_URL="https://XXX"
export MSG_PREFIX="Monitoring On XX.XX.XX.XX"
```

- Start container to check
```
container_name="monitor-docker-discord"
# Stop and delete existing container
docker stop $container_name; docker rm "$container_name"

# Start container to monitor docker healthcheck status
docker run -v /var/run/docker.sock:/var/run/docker.sock \
   -t -d -h $container_name --name $container_name \
   -e DISCORD_WEBHOOK_URL="$DISCORD_WEBHOOK_URL" -e MSG_PREFIX="$MSG_PREFIX" \
   -e WHITE_LIST="$WHITE_LIST" --restart=always \
   codyfp/monitor-docker-discord:latest

# Check status
docker logs "$container_name"
```

# How To Use: Docker-compose
```
version: '2'
services:
  monitor-docker-slack:
    container_name: monitor-docker-slack
    image: codyfp/monitor-docker-discord:latest
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
    environment:
      DISCORD_WEBHOOK_URL: "xoxp-XXX-XXX-XXX-XXXXXXXX"
      MSG_PREFIX: "Monitoring On XX.XX.XX.XX"
      WHITELISTL: ""
    restart: always
```

# More customization
- Add message prefix for the slack notification
```
export MSG_PREFIX="Docker Env in Denny's env"
```
<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/monitor-docker-slack/master/images/slack_prefix.png"/> </a>

- Skip checking certain containers by customizing WHITE_LIST env.
```
export MSG_PREFIX="Docker Env in Denny's env"
export WHITE_LIST="nodeexporter,ngin.*"
```
<a href="https://www.dennyzhang.com"><img src="https://raw.githubusercontent.com/DennyZhang/monitor-docker-slack/master/images/slack_whitelist.png"/> </a>

Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).
