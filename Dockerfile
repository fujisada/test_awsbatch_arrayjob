FROM centos:7

RUN yum install -y groff && rm -rf /var/cache/yum/* && yum clean all
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py
RUN pip install awscli

COPY bin /opt/bin/
