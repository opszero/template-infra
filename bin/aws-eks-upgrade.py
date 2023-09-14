import argparse
import boto3
import time
from botocore.exceptions import WaiterError

def upgrade_sync(environment, aws_region):
    client = boto3.client('eks', region_name=aws_region)
    describe_cluster = client.describe_cluster(name=environment)["cluster"]

    environment = describe_cluster["name"]
    cluster_version = describe_cluster["version"]

    return environment, cluster_version

def upgrade_addon(environment, addon_name, addon_version, aws_region):
    print(f"Updating {environment} addon {addon_name} to version {addon_version}...")
    client = boto3.client('eks', region_name=aws_region)

    try:
        client.update_addon(
            clusterName=environment,
            addonName=addon_name,
            addonVersion=addon_version,
        )
    except Exception as e:
        print(f"Upgrade Failed: {e}")

    while True:
        try:
            waiter = client.get_waiter('addon_active')
            waiter.wait(
                clusterName=environment,
                addonName=addon_name,
                addonVersion=addon_version,
            )
            print(f"Addon {addon_name} update complete")
            break
        except WaiterError:
            time.sleep(10)

def upgrade_node_groups(environment, aws_region, cluster_version):
    client = boto3.client('eks', region_name=aws_region)
    nodegroups = client.list_nodegroups(clusterName=environment)["nodegroups"]

    for nodegroup in nodegroups:
        describe_nodegroup = client.describe_nodegroup(
            clusterName=environment, nodegroupName=nodegroup
        )["nodegroup"]

        print("Nodegroup", describe_nodegroup["nodegroupName"])

        client.update_nodegroup_version(
            clusterName=environment,
            nodegroupName=describe_nodegroup["nodegroupName"],
            version=cluster_version,
        )

        waiter = client.get_waiter('nodegroup_update_complete')
        waiter.wait(
            clusterName=environment,
            nodegroupName=describe_nodegroup["nodegroupName"],
            nodegroupVersion=cluster_version,
        )

        print(f"Node group update completed for: {describe_nodegroup['nodegroupName']}")

def main():
    parser = argparse.ArgumentParser(description="AWS EKS Nodegroup Rotation Script")
    parser.add_argument("--region", required=True, help="AWS region (e.g., us-east-1)")
    parser.add_argument("--cluster", required=True, help="EKS cluster name")
    parser.add_argument("--profile", required=True, help="AWS CLI profile name")
    parser.add_argument("--operation", required=True, choices=["sync", "addons", "nodegroups"], help="Specify the operation to perform")

    args = parser.parse_args()

    boto3.setup_default_session(profile_name=args.profile)

    environment, cluster_version = upgrade_sync(args.cluster, args.region)

    if args.operation == "sync":
        upgrade_sync(environment, args.region)
    elif args.operation == "addons":
        upgrade_addon(environment, args.region)
    elif args.operation == "nodegroups":
        upgrade_node_groups(environment, args.region, cluster_version)

if __name__ == "__main__":
    main()
