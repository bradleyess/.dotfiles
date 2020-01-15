#!/usr/bin/env bash

getEC2InstanceIdsByName() {
    instanceName=$1
    aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --filters Name=instance-state-name,Values=running --filters "Name=tag:Name,Values=$instanceName" --output text
}

terminateEC2ById() {
    instanceName=$1
    aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --filters Name=instance-state-name,Values=running --filters "Name=tag:Name,Values=$instanceName" --output text)
}
