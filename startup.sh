#!/bin/sh
echo "Downloading CloudWatch Configuration"
aws s3 cp s3://weeksconsultingtestbucket/config.json /tmp/default_linux_config.json

echo "Starting CloudWatch Agent"
/opt/aws/amazon-cloudwatch-agent/bin/start-amazon-cloudwatch-agent > /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.out 2>&1 &

sleep 5
tail -F /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log /opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.out