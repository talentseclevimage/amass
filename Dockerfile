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

COPY ./default_cn.txt /tmp/default_cn.txt
COPY ./default_en.txt /tmp/default_en.txt
COPY ./subnames_big_cn.txt /tmp/subnames_big_cn.txt
COPY ./subnames_cn.txt /tmp/subnames_cn.txt
COPY ./subnames_medium_cn.txt /tmp/subnames_medium_cn.txt
COPY ./subnames_big_en.txt /tmp/subnames_big_en.txt
COPY ./subnames_en.txt /tmp/subnames_en.txt
COPY ./subnames_medium_en.txt /tmp/subnames_medium_en.txt
