FROM centos:7.2.1511

RUN yum install -y git \
&& yum install -y epel-release \
&& yum install -y nodejs

RUN cd / \
&& git clone https://github.com/RobinLinus/snapdrop.git

RUN cd /snapdrop && rm -rf /usr/local/lib/node_modules
RUN cd /snapdrop && rm -rf ~/.npm
RUN cd /snapdrop && brew uninstall --force node
RUN cd /snapdrop && brew install node
RUN cd /snapdrop && npm install -g npm
RUN cd /snapdrop && npm install -g gulp bower
RUN cd /snapdrop && npm install && bower install --allow-root

EXPOSE 3002

WORKDIR /snapdrop

CMD [ "bash", "start.sh" ]