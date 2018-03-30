#Download base image of iib (dev version)
FROM ibmcom/iib

ENV LICENSE accept
ENV NODE_NAME=iibNode
ENV SERVER_NAME=iibServer

COPY TEST_TEST.bar /home/iibuser/
COPY iib_start_deploy.sh /home/iibuser/
COPY iib_manage.sh /usr/local/bin/

#remove default integration node coming with dev docker image
#RUN ["/bin/bash", "-c", "/opt/ibm/iib-10.0.0.11/server/bin/mqsideletebroker IIBV10NODE"]

#on build of new iib docker image, create new node, start it and deploy any bars
USER iibuser

RUN chmod +x /home/iibuser/iib_start_deploy.sh
RUN /home/iibuser/iib_start_deploy.sh

CMD ["/bin/sh", "-c"]



#on start of docker container, execute script to start integration node
ENTRYPOINT /usr/local/bin/iib_manage.sh
