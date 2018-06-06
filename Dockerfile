FROM centos:7.2.1511

RUN yum install -y git \
&& yum install -y epel-release \
&& yum install -y nodejs \
&& yum install -y git nginx \
&& yum install -y initscripts \
&& line=$(cat /etc/nginx/mime.types | grep -n text/x-component | grep -o '^[0-9]*') \
&& sed -i "$line"'i\    text/cache-manifest appcache;' /etc/nginx/mime.types

COPY ./nginx.conf /etc/nginx/

CMD service nginx start && tail -F /var/log/nginx/error.log

RUN cd / \
&& git clone https://github.com/person896/snapdrop.git

RUN cd /snapdrop && npm install -g gulp bower
RUN cd /snapdrop && npm install && bower install --allow-root

EXPOSE 3002

WORKDIR /snapdrop

CMD [ "bash", "start.sh" ]