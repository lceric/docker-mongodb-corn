FROM mongo:3.3
RUN apt-get update && \
    apt-get install -y cron

# VOLUME /data/db
# WORKDIR /
ENV BACKDBNAME yapi

ADD run.sh /run.sh
ADD mongodb_back.sh /home/mongodb_back.sh
ADD crontabfile /home/crontab

RUN chmod -R 777 /data/db && \
  chmod +x /run.sh && \
  chmod +x /entrypoint.sh && \
  chmod +x /home/mongodb_back.sh && \
  mkdir /home/backup && \
  chmod 777 /home/backup && \
  crontab /home/crontab
  #  && \
  # cron -f

# EXPOSE 27017

ENTRYPOINT [ "/run.sh" ]
# ENTRYPOINT [ "mongod" ]
# CMD [ "mongod", "--smallfiles" ]
