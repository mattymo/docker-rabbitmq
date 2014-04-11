FROM centos

MAINTAINER Aleksandr Didenko adidenko@mirantis.com

WORKDIR /root

RUN rm -rf /etc/yum.repos.d/*
RUN echo -e "[nailgun]\nname=Nailgun Local Repo\nbaseurl=http://$(/sbin/ip route | awk '/default/ { print $3 }'):8080/centos/fuelweb/x86_64/\ngpgcheck=0" > /etc/yum.repos.d/nailgun.repo
RUN yum clean all
RUN yum --quiet install -y puppet

ADD etc /etc
ADD start.sh /usr/local/bin/start.sh
ADD astute.yaml /etc/astute.yaml
ADD site.pp /root/site.pp

RUN touch /var/lib/hiera/common.yaml
RUN chmod +x /usr/local/bin/start.sh
RUN /usr/bin/puppet apply -d -v /root/site.pp

EXPOSE 4369
EXPOSE 5672
EXPOSE 15672
EXPOSE 61613

CMD ["/usr/local/bin/start.sh"]
