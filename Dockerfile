FROM centos:7.9.2009

MAINTAINER ichylinux@gmail.com

RUN yum -y install \
      curl \
      device-mapper-persistent-data \
      git \
      lvm2 \
      python3 \
      python3-pip \
      sudo \
      yum-utils && \
    yum-config-manager --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo && \
    yum -y install docker-ce docker-ce-cli containerd.io && \
    yum clean all

RUN pip3 install --upgrade pip && \
    pip3 install awscli

RUN cd /tmp && \
    curl -LO https://golang.org/dl/go1.16.5.linux-amd64.tar.gz && \
    tar -C /usr/local -zxf go1.16.5.linux-amd64.tar.gz && \
    rm -Rf go1.16.5.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

RUN go get -u github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login && \
    mv /root/go/bin/docker-credential-ecr-login /usr/local/bin/
