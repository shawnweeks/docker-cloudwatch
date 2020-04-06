FROM amazonlinux:latest

COPY ["aws-config","startup.sh","/tmp/"]

RUN yum install -y https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm && \
    yum install -y awscli && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    mkdir -p ~/.aws && \
    mv /tmp/aws-config ~/.aws && \
    mv /tmp/startup.sh ~/ && \
    chmod 755 ~/*.sh && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

ENV RUN_IN_CONTAINER="True"
ENTRYPOINT ["/root/startup.sh"]