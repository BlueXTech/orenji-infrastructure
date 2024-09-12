#!/bin/bash

# Change directory
cd /home/ec2-user

# Fetch Ordika artifact from S3 to /home/ec2-user
aws s3 cp s3://orang3-app-artifacts/ordika/ordika.jar .
aws s3 cp s3://orang3-app-artifacts/ordika/prod/.env-prod.properties .

# Start application
java -jar ordika.jar --spring.profiles.active=prod --spring.config.additional-location=file:.env-prod.properties > log-$(date '+%d-%m-%Y').txt 2>&1 &