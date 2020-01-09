FROM ubuntu:14.04

MAINTAINER Tutum Labs <support@tutum.co>

RUN apt-get update && apt-key update && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y --force-yes pwgen mongodb-org && \
    apt-get install -y cron

VOLUME /data/db

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes
ENV BACKDBNAME yapi

# ADD entrypoint.sh /entrypoint.sh
ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
ADD mongodb_back.sh /home/mongodb_back.sh
ADD crontabfile /home/crontab
# ADD ./etc/crontab /etc/cron.d/crontab

RUN chmod +x /run.sh && \
  chmod +x /home/mongodb_back.sh && \
  mkdir /home/backup && \
  chmod 777 /home/backup && \
  crontab /home/crontab

EXPOSE 27017 28017

ENTRYPOINT [ "/run.sh" ]

# tail 可以防止容器自动退出运行
# CMD cron && tail -f /var/log/cron.log
