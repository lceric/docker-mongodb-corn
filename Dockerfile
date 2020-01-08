FROM ubuntu:14.04
MAINTAINER Tutum Labs <support@tutum.co>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y --force-yes pwgen mongodb-org

VOLUME /data/db

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh

EXPOSE 27017 28017

# ADD ./etc/crontab /etc/cron.d/crontab
ADD test.sh /root/home/test.sh
RUN chmod +x /root/home/test.sh
# RUN sh './test.sh'

CMD ["/run.sh", "/root/home/test.sh"]

# tail 可以防止容器自动退出运行
# CMD cron && tail -f /var/log/cron.log
