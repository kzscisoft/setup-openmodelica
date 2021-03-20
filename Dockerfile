FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y build-essential wget cmake curl lsb-release
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - 
ENTRYPOINT [ "/entrypoint.sh" ]