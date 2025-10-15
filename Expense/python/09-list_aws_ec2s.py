#!/usr/bin/env python3

import boto3  # AWS SDK for Python

# CHANGE THESE IF YOU WANT
REGION = "ap-south-1"        # your AWS region (e.g., ap-south-1, us-east-1)
TAG_KEY = "Environment"      # which tag key to look at
TAG_VALUE = "PROD"           # which tag value to match

# 1) Create an EC2 client for a region
ec2 = boto3.client("ec2", region_name=REGION)

# 2) Build filters: running instances AND tag:Environment=PROD
filters = [
    {"Name": "instance-state-name", "Values": ["running"]},
    {"Name": f"tag:{TAG_KEY}", "Values": [TAG_VALUE]},
]

# 3) Ask AWS for instances that match the filters
resp = ec2.describe_instances(Filters=filters)

# 4) Loop through the response and print a few fields
for reservation in resp.get("Reservations", []):
    for inst in reservation.get("Instances", []):
        # Convert tags (list of dicts) to a simple dict for easy lookup
        tags = {t["Key"]: t["Value"] for t in inst.get("Tags", [])}
        name = tags.get("Name", "")  # instance Name tag if present
        instance_id = inst.get("InstanceId")
        itype = inst.get("InstanceType")
        state = inst.get("State", {}).get("Name")
        priv_ip = inst.get("PrivateIpAddress", "-")
        pub_ip = inst.get("PublicIpAddress", "-")
