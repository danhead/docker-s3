#!/bin/ash

if [[ "$RESTORE" == "true" ]]; then
  ./restore.sh
else
  if [ -n "$CRON_TIME" ]; then
    env | grep -v 'affinity:container' | sed -e 's/^\([^=]*\)=\(.*\)/export \1="\2"/' > /env.sh # Save current environment
    chmod 755 /env.sh
    echo "${CRON_TIME} /env.sh && /backup.sh >> /docker-s3.log 2>&1" > /crontab.conf
    /usr/bin/crontab /crontab.conf
    echo "=> Running docker-s3 backups as a cronjob for ${CRON_TIME}"
    exec /usr/sbin/crond -f
  else
    ./backup.sh
  fi
fi
