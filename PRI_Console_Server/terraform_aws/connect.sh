#!/usr/bin/env bash

MYIP=`terraform show | grep "public_ip " | awk '{print $3}'`
ssh -i "/Users/tige/Dropbox/security-keys/aws_key-general-tige.pem" ubuntu@$MYIP
