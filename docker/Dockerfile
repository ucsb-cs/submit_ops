FROM centos:centos6

COPY build_scripts /build_scripts
COPY files /tmp
RUN chmod -R 755 /tmp && chmod -R 755 /build_scripts

# Source Postgres RPM
RUN curl -o /tmp/pgdg.rpm http://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-3.noarch.rpm && \
  rpm -ivh /tmp/pgdg.rpm

# Yum installed dependencies
RUN yum update -y && yum install -y epel-release && yum install -y \
  gcc-c++ \
  initscripts \
  logrotate \
  nginx \
  openldap-devel \
  postgresql94-devel \
  postgresql94-server \
  python-pip \
  socat \
  wget

# NGINX configuration
COPY files/nginx.conf /etc/nginx/nginx.conf
RUN chown root:root /etc/nginx/nginx.conf

# Install pip
RUN pip install --upgrade pip && pip install --upgrade virtualenv

RUN chkconfig postgresql-9.4 on
RUN chkconfig nginx on

# RabbitMQ
RUN cd /tmp && \
  wget https://github.com/rabbitmq/erlang-rpm/releases/download/v1.3.2/erlang-18.3.4-5.el6.x86_64.rpm && \
  rpm -i erlang-18.3.4-5.el6.x86_64.rpm && \
  wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_6/rabbitmq-server-3.6.6-1.el6.noarch.rpm && \
  rpm -i rabbitmq-server-3.6.6-1.el6.noarch.rpm && \
  rm -f *.rpm && \
  pip install docopt pika && \
  chkconfig rabbitmq-server on

# # 5672 rabbitmq-server - amqp port
# # 15672 rabbitmq-server - for management plugin
# # 4369 epmd - for clustering
# # 25672 rabbitmq-server - for clustering

# # EXPOSE 5672 15672 4369 25672

# #
# # entrypoint/cmd for container
# # we will set a random password and add one vhost for development
# # ENV DEVEL_VHOST_NAME develop

# CMD ["mv /tmp /home/ec2-user/files"]
CMD ["build_scripts/start_services.sh"]
CMD ["build_scripts/add_users.sh"]
CMD ["build_scripts/configure_rabbit_util.sh"]
CMD ["build_scripts/configure_application.sh"]
CMD ["/bin/bash"]
