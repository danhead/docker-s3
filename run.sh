#!/bin/ash

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  if [ -n "$CRON_TIME" ]; then
    echo "${CRON_TIME} /backup.sh >> /docker-s3.log 2>&1" > /crontab.conf
    /usr/bin/crontab /crontab.conf
    echo "=> Running docker-s3 backups as a cronjob for ${CRON_TIME}"
    exec /usr/sbin/crond -f
  else
    ./backup.sh
  fi
fi
