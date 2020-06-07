#!/bin/bash
#Set working directory for Terraform and create EKS cluster
cd terraform-eks-platform
#terraform init -input=false
#terraform plan -input=false
#terraform apply -input=false -auto-approve

#Export AWS access keys to environment variables
AWSAccessKey=$(terraform output vault_user_id)
if [ -z "$AWSAccessKey" ]
	then
		echo -n "Enter AWS Access Key for the tf-eks-jx-demo user: "
		read -s AWSAccessKey
		export VAULT_AWS_ACCESS_KEY_ID=$AWSAccessKey
	else
		export VAULT_AWS_ACCESS_KEY_ID=$AWSAccessKey
fi
echo
AWSSecretKey=$(terraform output vault_user_secret)
if [ -z "$AWSSecretKey" ]
	then
		echo -n "Enter AWS Secret Access Key for the tf-eks-jx-demo user: "
		read -s AWSSecretKey
		export VAULT_AWS_SECRET_ACCESS_KEY=$AWSSecretKey
	else
		export VAULT_AWS_SECRET_ACCESS_KEY=$AWSSecretKey
fi
echo 
#Create and move to JenkinsX directory and run boot. Follow boot instructions to setup JenkinsX in EKS
mkdir ../jenkinsx
cd ../jenkinsx/
jx boot -r ../terraform-eks-platform/jx-requirements.yml