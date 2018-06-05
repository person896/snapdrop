FROM centos:7.2.1511

RUN yum install -y git \
&& yum install -y epel-release \
&& yum install -y nodejs \
&& yum install -y npm

RUN cd /
&& git clone https://github.com/RobinLinus/snapdrop.git

RUN cd /snapdrop
RUN npm install -g gulp bower
RUN npm install && bower install --root-allowed
RUN gulp serve
RUN node index.js

EXPOSE 3002

WORKDIR /snapdrop