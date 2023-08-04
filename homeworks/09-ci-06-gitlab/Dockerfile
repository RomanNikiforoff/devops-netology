FROM centos:7

#RUN yum install python3 python3-pip -y

ENV PYTHON_VERSION=3.7.5
EXPOSE 5290 5290

RUN yum install -y gcc openssl-devel bzip2-devel libffi libffi-devel curl wget make && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz  && \
    tar -xzf Python-${PYTHON_VERSION}.tgz && rm Python-${PYTHON_VERSION}.tgz && \
    yum clean all && rm -rf /var/cache/yum/*

WORKDIR /Python-${PYTHON_VERSION}

RUN ./configure --enable-optimizations && \
    make altinstall && \
    ln -sf /usr/local/bin/python3.7 /usr/bin/python3 && \
    cd / && rm -rf /Python-${PYTHON_VERSION}

COPY requirements.txt requirements.txt
RUN  python3 -m pip install -r requirements.txt
COPY python-api.py python-api.py
CMD ["python3", "python-api.py"]