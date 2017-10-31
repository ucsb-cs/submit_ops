FROM centos:centos6

COPY build_scripts /build_scripts
COPY files /tmp

RUN /build_scripts/yum_update.sh

RUN yum -y install epel-release
RUN yum -y install openssh-clients 

RUN /build_scripts/install_pythontools.sh

#RUN /build_scripts/install_nginx.sh
#RUN /build_scripts/install_postgresql.sh
#RUN /build_scripts/install_rabbitmq.sh

# 5672 rabbitmq-server - amqp port
# 15672 rabbitmq-server - for management plugin
# 4369 epmd - for clustering
# 25672 rabbitmq-server - for clustering

# EXPOSE 5672 15672 4369 25672

#
# entrypoint/cmd for container
# we will set a random password and add one vhost for development
# ENV DEVEL_VHOST_NAME develop

CMD ["build_scripts/add_submit_user.sh"]
CMD ["build_scripts/add_worker_users.sh"]

CMD ["build_scripts/configure_application.sh"]
CMD ["build_scripts/configure_rabbit_util.sh"]
CMD ["/bin/bash"]
