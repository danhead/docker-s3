FROM alpine:latest
MAINTAINER Daniel Head <me@danielhead.com>

RUN apk add --update-cache python py-pip ca-certificates tzdata &&\
  pip install awscli &&\
  rm -rf /etc/periodic &&\
  rm -rf /var/cache/apk/*

ADD backup.sh /backup.sh
ADD restore.sh /restore.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

ENV S3_BUCKET_NAME docker-backups.example.com
ENV AWS_ACCESS_KEY_ID **DefineMe**
ENV AWS_SECRET_ACCESS_KEY **DefineMe**
ENV AWS_DEFAULT_REGION us-east-1
ENV PATHS_TO_BACKUP /paths/to/backup
ENV BACKUP_NAME backup
ENV RESTORE false

CMD ["/run.sh"]
