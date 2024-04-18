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

for account in response["Accounts"]:
    # Assume you have the necessary permissions to list instances in each account
    aid = account["Id"]
    print("[" + account["Name"] + "]")
    print(f"role_arn = arn:aws:iam::{aid}:role/OrganizationAccountAccessRole")
    print("source_profile = mainprofile")
    print()
