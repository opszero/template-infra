import boto3

session = boto3.Session(profile_name="<mainprofile>")

# Create an Organizations client
org_client = session.client("organizations")

# List all accounts in the organization
response = org_client.list_accounts()


print("[mainprofile]")
print("region=us-west-2")
print("aws_access_key_id=")
print("aws_secret_access_key=")
print("aws_session_token=")
print()

# [auguria-cra]
# role_arn = arn:aws:iam::471112504552:role/OrganizationAccountAccessRole
# source_profile = auguria-infra

# [fake-customer]
# role_arn = arn:aws:iam::592479854049:role/OrganizationAccountAccessRole
# source_profile = auguria-infra
# Iterate through each account and list Kubernetes instances
for account in response["Accounts"]:
    # Assume you have the necessary permissions to list instances in each account
    aid = account["Id"]
    print("[" + account["Name"] + "]")
    print(f"role_arn = arn:aws:iam::{aid}:role/OrganizationAccountAccessRole")
    print("source_profile = auguria-infra")
    print()
