FROM python:latest
ADD run.sh  /run.sh
RUN mkdir  /opt/api && \
    mkdir /opt/soap && \
    mkdir /opt/health  && \
    echo "rest"  > /opt/api/index.html && \
    echo "Soap"  > /opt/soap/index.html && \ 
    echo "health"  > /opt/health/index.html && \ 
    chmod +x /run.sh 

EXPOSE 4040
EXPOSE 5058
EXPOSE 6050


CMD /run.sh

#python3 -m http.server 4040  -d /opt/api
#python3 -m http.server 6050  -d /opt/soap
