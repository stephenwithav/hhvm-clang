FROM centos:centos7
MAINTAINER Steven Edwards <cureadvocate@gmail.com>

RUN yum -y install epel-release

RUN yum -y install cpp clang clang-devel cmake git psmisc {binutils,boost,jemalloc}-devel \
    {sqlite,tbb,bzip2,openldap,readline,elfutils-libelf,gmp,lz4,pcre}-devel \
    lib{xslt,event,yaml,vpx,png,zip,icu,mcrypt,memcached,cap,dwarf}-devel \
    {unixODBC,expat,mariadb}-devel lib{edit,curl,xml2,xslt}-devel \
    glog-devel oniguruma-devel ocaml gperf enca libjpeg-turbo-devel make && \
    cd /tmp &&  git clone https://github.com/facebook/hhvm -b HHVM-3.7 hhvm --recursive && \
    cd /tmp/hhvm && cmake . -DMYSQL_UNIX_SOCK_ADDR=/dev/null -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DCMAKE_{C,ASM}_COMPILER=/usr/bin/clang && \
    make -j2 && make install && yum clean all && rm -rf /tmp/*
