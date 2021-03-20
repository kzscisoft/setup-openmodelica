FROM ubuntu:focal
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y build-essential wget cmake curl lsb-release
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add - 
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
RUN apt update -y
RUN for PKG in `apt-cache search "omlib-.*" | cut -d" " -f1`; do apt-get install -y "$PKG"
ENTRYPOINT [ "/entrypoint.sh" ]