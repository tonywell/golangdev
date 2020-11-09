FROM golang:alpine

MAINTAINER tonywell <tongwei1985@gmail.com>

RUN true \
    #设置apk服务加速器
    && echo http://mirrors.aliyun.com/alpine/v3.12/main/ > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.12/community/ >> /etc/apk/repositories 

RUN	apk update && apk upgrade \
    #安装zsh git vim wget curl等工具
	&& apk add --no-cache zsh git vim curl \
	&& rm -rf /tmp/* /etc/apk/cache/*

ENV SHELL /bin/zsh

EXPOSE 8000
