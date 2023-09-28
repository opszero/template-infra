import argparse

import boto3

RETENTION_PERIOD = 14

# Define the command-line arguments
parser = argparse.ArgumentParser(
    description="Set the retention period for all CloudWatch Logs log groups"
)
parser.add_argument(
    "--profile", "-p", required=True, help="The name of the AWS profile to use"
)
parser.add_argument(
    "--region", "-e", required=True, help="The name of the AWS profile to use"
)

# Parse the command-line arguments
args = parser.parse_args()

# Initialize the CloudWatch Logs client with the specified profile
session = boto3.Session(profile_name=args.profile, region_name=args.region)
client = session.client("logs")

log_groups = client.describe_log_groups()

# Iterate through each log group and set the retention to 90 days
for log_group in log_groups["logGroups"]:
    group_name = log_group["logGroupName"]
    print(f"Updating retention for log group {group_name}...")
    client.put_retention_policy(
        logGroupName=group_name, retentionInDays=RETENTION_PERIOD
    )

print("Done!")
