#!/bin/sh
echo "Downloading CloudWatch Configuration"
if [[ -z $CLOUDWATCH_CONFIG_S3 ]]
then
    echo "CloudWatch S3 Bucket Not Set"
    echo "Exiting"
    exit 1
else
    aws s3 cp $CLOUDWATCH_CONFIG_S3 /opt/aws/amazon-cloudwatch-agent/bin/default_linux_config.json    
fi


echo "Starting CloudWatch Agent"
/opt/aws/amazon-cloudwatch-agent/bin/start-amazon-cloudwatch-agent > /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.out 2>&1 &

sleep 10
tail -F /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.out