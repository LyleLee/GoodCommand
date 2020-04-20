FROM ubuntu:18.04
ENV REFRESHED_AT 2020-04-18

COPY sources.list /etc/apt/sources.list
RUN apt update && \
    apt install -y dialog apt-utils && \
    apt install -y ca-certificates && \
    apt install -y build-essential ocl-icd-libopencl1 cmake git pkg-config libclang-dev clang llvm make ninja-build ocl-icd-libopencl1 ocl-icd-dev ocl-icd-opencl-dev libhwloc-dev zlib1g zlib1g-dev clinfo dialog apt-utils wget && \
    apt install -y pocl-opencl-icd
RUN wget -O /root/v5.1.0.tar.gz https://github.com/hashcat/hashcat/archive/v5.1.0.tar.gz && cd /root/ && tar -xf v5.1.0.tar.gz && cd hashcat-5.1.0/ && make

WORKDIR /root/

ENTRYPOINT [ "/bin/bash" ]
