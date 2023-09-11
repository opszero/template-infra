import subprocess
import json, base64

def keys_extract(namespace, secret, prefix, github_repo):
    secret_vals = json.loads(subprocess.getoutput(f"kubectl get secrets {secret} -n {namespace} -o jsonpath='{{.data}}' "))

    for key, val64 in secret_vals.items():
        val = base64.b64decode(val64).decode('utf-8')
        print(f'gh --repo {github_repo} secret set {prefix}{key} --body "{val}"')