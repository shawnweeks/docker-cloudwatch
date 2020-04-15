FROM amazonlinux:latest

ENV CLOUDWATCH_URL="https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"

COPY ["aws-config","startup.sh","/tmp/"]

RUN yum install -y awscli && \
    yum install -y $CLOUDWATCH_URL && \
    mkdir -p ~/.aws && \
    mv /tmp/aws-config ~/.aws && \
    mv /tmp/startup.sh ~/ && \
    chmod 755 ~/*.sh && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rm -rf /tmp/* && \
    rm -rf /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard && \
    rm -rf /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl && \
    rm -rf /opt/aws/amazon-cloudwatch-agent/bin/config-downloader

ENV RUN_IN_CONTAINER="True"

ENTRYPOINT ["/root/startup.sh"]