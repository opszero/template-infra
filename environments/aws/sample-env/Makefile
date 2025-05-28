apply:
	terraform init -upgrade && terraform get -update && terraform apply

kubeconfig:
	KUBECONFIG=./kubeconfig aws --profile <profile> eks update-kubeconfig --name sample-env
