# Jenkins X Implementation
<a id="markdown-Jenkins%20X%20Implementation" name="Jenkins%20X%20Implementation"></a>

![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.12.0-blue.svg)

This PR contains the necessary steps to implement this solution under JenkinsX in EKS. It uses a Terraform module for creating an EKS cluster and all the necessary infrastructure to install Jenkins X via `jx boot`.
The module generates for this purpose a  templated `jx-requirements.yml` file for `jx boot`. Then you can implement `jx boot` command from JenkinsX to boot the JenkinsX cluster and import the solution.

<!-- TOC depthfrom:2 -->
- [Steps to implement Jenkins X](#Steps-to-implement-JenkinsX)
- [How to use this PR](#how-to-use-this-PR)
    - [Prerequisites](#prerequisites)
    - [Cluster provisioning](#cluster-provisioning)
    - [Import Spring Petclinic](#import-spring-petclinic)
	- [Open JenkinsX UI](#open-jenkinsx-ui)
- [Security Disclaimer](#security-disclaimer)
<!-- /TOC -->

## Steps to implement JenkinsX
<a id="markdown-steps-to-implement-JenkinsX" name="Steps%20to%20implement%20JenkinsX"></a>

This JenkinsX implementation is meant as demo purposes only and the Terraform module variables are already pre-populated for a dev-ready environment.
Check the Prerequisites section to make sure you are aligned with them. To improve the deployment please create another PR once this one is in place.

A few suggestions for improving this PR:

- Create production environment.
- Store the EKS cluster and JenkinsX config in a store (S3 perhaps?) for versioning capabilities. Check the Terraform documentation for further insights.
- Automate the JX boot configuration further.

## How to use this PR
<a id="markdown-how-to-use-this-PR" name="How%20to%20use%20this%20PR"></a>

### Prerequisites
<a id="markdown-Prerequisites" name="Prerequisites"></a>

- AWS Account with IAM create user role assigned (to provision Vault user).
- AWS IAM user named `tf-eks-vault-user` (no permissions are required but its access key it's needed).
- GitHub repository with a bot-like access token with permissions to perform `admin:repo_hook, delete_repo, read:org, read:user, repo, user:email`. 

The Terraform module included allows you to create an [EKS](https://aws.amazon.com/eks/) cluster for installation of Jenkins X.
You need the following binaries locally installed and configured on your _PATH_:

- `terraform` (~> 0.12.0)
- `kubectl` (>=1.10)
- `aws-iam-authenticator`

Check the [Terraform module documentation](./terraform-eks-platform/README.md) for information on more advanced configurations.

### Cluster provisioning
<a id="markdown-Cluster%20provisioning" name="Cluster%20provisioning"></a>

A Jenkins X dev-ready cluster can be provisioned by running shell script provided:

```sh
cd /jx-in-eks/
./deploy-jenkinsx-cluster.sh
```
The script will take some time to complete so be patient please!

After successfull EKS cluster deployment and configuration, a `jx-requirements.yml` file will be populated with preconfigured options and the script will execute `jx boot` command.
You need to follow the `jx boot` options to finish the JenkinsX cluster boot up. Steps include cloning JX git repository, adding GitHub users, setting preferences and more.

For more information on `jx boot` see the reference from [Jenkinsx](https://jenkins-x.io/docs/install-setup/installing/boot/)

### Import Spring-Petclinic into JenkinsX
<a id="markdown-import-spring-petclinic" name="Import%20Spring%20Petclinic"></a>

Finally you can import the project using this command:

```sh
cd /jx-in-eks/
./launch-jenkins.sh
```

### Open JenkinsX UI after setup
<a id="markdown-open-jenkinsx-ui" name="Open%20JenkinsX%20UI"></a>

To open JenkinsX UI run:

```sh
jx ui
```

## Security Disclaimer
<a id="markdown-security-disclaimer" name="Security%20Disclaimer"></a>

This implementation is meant to be used as demo for a dev-only environment, not suitable for production use.

All AWS resources are created in `sa-east-1` AWS Region.
