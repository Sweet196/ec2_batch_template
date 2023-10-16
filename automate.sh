#!/bin/bash

# Specify the path to the private key file
PRIVATE_KEY="chris-ec2.pem"

# Initialize an index variable
index=0

# Loop through each line in hosts.txt
while IFS= read -r host; do
#   # 先删除上次失败的
#   ssh -i "$PRIVATE_KEY" "ubuntu@$host" << EOF
#     rm -r ./script
# EOF

  # Use scp to upload the local file to the remote server
  scp -i "$PRIVATE_KEY" -r ./script "ubuntu@$host:/home/ubuntu/"

  # SSH into the EC2 instance and execute the commands
  ssh -i "$PRIVATE_KEY" "ubuntu@$host" << EOF
    cd script
    nohup python3 main.py --partition_index $index > main_$index.log 2>&1 &
    # The above line runs main.py in the background and redirects its output to main_<index>.log
EOF

  # Increment the index
  index=$((index+1))
done < hosts.txt

# 连接以及查看日志
# scp -i "chris-ec2.pem" ubuntu@ec2-35-162-59-140.us-west-2.compute.amazonaws.com:/home/ubuntu/script/main_19.log ./logs/log_19.log
# ssh -i "chris-ec2.pem" ubuntu@ec2-35-160-55-51.us-west-2.compute.amazonaws.com
