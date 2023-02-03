#!/bin/bash -ex
python /monitor-docker-discord.py  --check_interval "$CHECK_INTERVAL" \
       --discord_webhook_url "$DISCORD_WEBHOOK_URL" --whitelist "$WHITE_LIST" \
       --msg_prefix "$MSG_PREFIX"
## File : monitor-docker-discord.sh ends
