FROM ubuntu:focal
RUN apt update -y
RUN apt install -y build-essential wget cmake curl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]