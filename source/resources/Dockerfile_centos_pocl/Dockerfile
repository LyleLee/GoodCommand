FROM centos:7
ENV REFRESHED_AT 2020-04-18

COPY CentOS-Base.repo /etc/yum.repos.d/
RUN yum makecache && \
    yum install -y dialog apt-utils && \
    yum install -y ca-certificates && \
    yum install -y build-essential ocl-icd-libopencl1 cmake git pkg-config libclang-devel clang llvm make ninja-build ocl-icd-libopencl1 ocl-icd-devel ocl-icd-opencl-devel libhwloc-devel zlib1g zlib1g-devel clinfo dialog apt-utils wget gcc g++
RUN wget -e "http_proxy=http://192.168.1.201:9000"  -e "https_proxy=https://192.168.1.201:9000" -O /root/v1.1.tar.gz https://github.com/pocl/pocl/archive/v1.1.tar.gz && cd /root/ && tar -xf v1.1.tar.gz
RUN wget -e "http_proxy=http://192.168.1.201:9000"  -e "https_proxy=https://192.168.1.201:9000" -O /root/v5.1.0.tar.gz https://github.com/hashcat/hashcat/archive/v5.1.0.tar.gz && cd /root/ && tar -xf v5.1.0.tar.gz && cd hashcat-5.1.0/ && make

WORKDIR /root/

ENTRYPOINT [ "/bin/bash" ]
