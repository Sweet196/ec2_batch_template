#!/bin/bash

# Specify the path to the private key file
PRIVATE_KEY="chris-ec2.pem"

# Initialize an index variable
index=0

# Loop through each line in hosts.txt
while IFS= read -r host; do
  scp -i "$PRIVATE_KEY" "ubuntu@$host:/home/ubuntu/script/main_$index.log" ./logs/log_$index.log
  # Increment the index
  index=$((index+1))
done < hosts.txt

# 连接以及查看日志
# scp -i "chris-ec2.pem" ubuntu@ec2-52-88-77-80.us-west-2.compute.amazonaws.com:/home/ubuntu/script/main_0.log ./log
# ssh -i "chris-ec2.pem" ubuntu@ec2-35-160-55-51.us-west-2.compute.amazonaws.com
