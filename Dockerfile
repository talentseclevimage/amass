FROM python:3.10.4-bullseye

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update

RUN wget https://studygolang.com/dl/golang/go1.16.linux-amd64.tar.gz && \
tar xfz go1.16.linux-amd64.tar.gz -C /usr/local

COPY ./config.ini /usr/local

ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=$PATH:$GOROOT/bin
ENV GOPROXY=https://goproxy.cn
ENV AMASS_CONFIG=/usr/local/config.ini

RUN go install -v github.com/OWASP/Amass/v3/...@master

