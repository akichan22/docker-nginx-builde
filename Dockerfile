FROM centos:7

RUN yum update -y
RUN yum install -y epel-release;
RUN yum install -y \
    autoconf \
    automake \
    libtool \
    wget \
    git \
    make \
    vim \
    less \
    gcc \
    gcc-c++ \
    pkgconfig \
    pcre-devel \
    tcl-devel \
    expat-devel \
    openssl-devel \
    perl-devel \
    perl-ExtUtils-Embed \
    GeoIP-devel \
    libxslt-devel \
    gd-devel \
    rpm-build
RUN yum clean all

RUN mkdir /root/nginx-build
WORKDIR /root/nginx-build
ENV SRPMFILE nginx.src.rpm
RUN wget http://nginx.org/packages/rhel/7/SRPMS/nginx-1.10.1-1.el7.ngx.src.rpm -O $SRPMFILE
RUN rpmbuild --rebuild $SRPMFILE
RUN ls -lh /root/rpmbuild/RPMS/*
VOLUME ["/root/nginx-build/RPMS/"]
CMD ["/bin/bash"]
