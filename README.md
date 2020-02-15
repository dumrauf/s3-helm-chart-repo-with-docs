# A Helm Chart Repository in AWS S3 - With Auto-Generated User Documentation!

This repository contains a Terraform module that creates a [Helm chart repository](https://docs.helm.sh/developing_charts/#the-chart-repository-guide) using an AWS S3 bucket. The S3 bucket is configured as a static website and contains an auto-generated `index.html` with instructions on using and managing the Helm chart repository.

A live example can be found at [http://dumrauf-helm-chart-repo.s3-website-us-east-1.amazonaws.com](http://dumrauf-helm-chart-repo.s3-website-us-east-1.amazonaws.com/?utm_source=GitHub&utm_medium=social&utm_campaign=README).

> For further information, see the corresponding article [Build Your Own Helm Chart Repository in S3 — With Auto-Generated User Documentation!](https://www.how-hard-can-it.be/helm-chart-repository-in-s3-with-auto-generated-user-docs/?utm_source=GitHub&utm_medium=social&utm_campaign=README) on [How Hard Can It Be?!](https://www.how-hard-can-it.be/?utm_source=GitHub&utm_medium=social&utm_campaign=README).

The master branch in this repository is compliant with [Terraform v0.12](https://www.terraform.io/upgrade-guides/0-12.html); a legacy version that is compatible with [Terraform v0.11](https://www.terraform.io/upgrade-guides/0-11.html) is available in branch [terraform@0.11](https://github.com/dumrauf/s3-helm-chart-repo-with-docs/tree/terraform%400.11).


## You Have

Before you can use the Terraform module in this repository out of the box, you need

 - an [AWS account](https://portal.aws.amazon.com/gp/aws/developer/registration/index.html)
 - a [Terraform](https://www.terraform.io/intro/getting-started/install.html) CLI
 - a [log bucket](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#access-logs-choosing-s3-bucket) which can be used to store [S3 access logs](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerLogs.html) (use the Terraform module provided in [https://github.com/dumrauf/aws_log_bucket](https://github.com/dumrauf/aws_log_bucket) to create a log bucket if needed) 

Moreover, you probably also have a directory containing the packaged Helm charts along with an `index.yaml` file.


## You Want

After running the Terraform module in this repository you get an S3 bucket that contains auto-generated documentation and can be used to host a Helm chart repository.


## Setup

The input variables for the module are defined in [settings/example.tfvars](settings/example.tfvars) to be
```hcl
region = "<your-region>"

shared_credentials_file = "/path/to/.aws/credentials"

profile = "<your-profile>"

bucket_name = "<your-bucket-name>"

repository_name = "<your-repository-name>"

log_bucket_id = "<your-log-bucket-id>"
```
Here, you need to replace the example values with your settings.

Moreover, note that the S3 bucket will be named `${var.repository_name}-${var.bucket_name}`.


## Execution

Initialise Terraform by running
```
terraform init
```
As a best practice, create a new workspace by running
```
terraform workspace new example
```
The Helm chart repository can be planned by running
```
terraform plan -var-file=settings/example.tfvars
```
and created by running
```
terraform apply -var-file=settings/example.tfvars
```


## Terraform Outputs

The module has CLI outputs as well as template files it generates. Here, the template files contain the auto-generated documentation.

### CLI Outputs

The module has two outputs, namely `helm_chart_repository_bucket_domain_name` and `helm_chart_repository_website_endpoint` which are the corresponding Terraform attributes of the newly created Helm chart repository bucket. Point your browser to the output of `helm_chart_repository_website_endpoint` in order to visit your new Helm chart repository as well as to review the auto-generated documentation.

### Generated Template Files

The module also generates a Markdown as well as an HTML file. Both files are named `${var.repository_name}-${var.bucket_name}.index.{md,html}`. Here, the HTML file is constructed from the rendered Markdown file and intended to be used as an `index.html` file for the new Helm chart repository. It contains tailored instructions on how to use the Helm chart repository, making it easier for your users to add, use, and remove the Helm chart repository via the `helm` CLI. Moreover, the `index.html` file also contains instructions on how to manage the Helm chart repository.

For example inputs
```hcl
bucket_name = "helm-charts-repo"

repository_name = "dumrauf"
```
files `dumrauf-helm-charts-repo.index.md` and `dumrauf-helm-charts-repo.index.html` are generated.

Here, the contents of file `dumrauf-helm-charts-repo.index.html` which is automatically uploaded to [http://dumrauf-helm-chart-repo.s3-website-us-east-1.amazonaws.com](http://dumrauf-helm-chart-repo.s3-website-us-east-1.amazonaws.com) as `index.html` are 
> # Helm Chart Repository `dumrauf`
> 
> Welcome to the [Helm](https://github.com/helm/helm) [chart repository](https://docs.helm.sh/developing_charts/#the-chart-repository-guide) `dumrauf`.
> See below for instructions on how to add or remove this chart repository using `helm`.
> If you're the owner of this Helm chart repository, then please refer to the "Managing the Repository" section below.
> 
> 
> 
> 
> # Using the Repository
> 
> This section describes the use of the repository `dumrauf`.
> It describes how to add, search, and eventually remove the repository via `helm`.
> 
> 
> ## Adding the Repository
> 
> This chart repository can be [added to `helm`](https://docs.helm.sh/helm/#helm-repo-add) via
> 
> ```
> helm repo add dumrauf 'https://dumrauf-helm-charts-repo.s3.amazonaws.com'
> helm repo update
> ```
> Here, the latter command is required in order to [get the (latest) information](https://docs.helm.sh/helm/#helm-repo-update) about charts from the repository `dumrauf`.
> 
> 
> ## Searching the Repository
> 
> All charts in the repository can be [listed](https://docs.helm.sh/helm/#helm-search) via
> ```
> helm search dumrauf
> ```
> 
> 
> ## Removing the Repository
> 
> This chart repository can be [removed from `helm`](https://docs.helm.sh/helm/#helm-repo-remove) via
> 
> ```
> helm repo remove dumrauf
> ```
> 
> 
> 
> 
> # Managing the Repository
> 
> This section outlines steps for managing Helm chart repository `dumrauf`.
> It describes how to upload Helm charts and eventually delete them again.
> 
> 
> ## Uploading Helm Charts
> 
> The Helm charts can be uploaded to S3 bucket `dumrauf-helm-charts-repo` via
> ```
> aws s3 sync <packaged-charts-directory> s3://dumrauf-helm-charts-repo
> ```
> 
> Assuming the packaged Helm charts are located in `../packaged-helm-charts/`, then they can be uploaded via
> ```
> aws s3 sync ../packaged-helm-charts/ s3://dumrauf-helm-charts-repo
> ```
> 
> 
> ## Deleting All Helm Charts
> 
> The Helm charts can be deleted from S3 bucket `dumrauf-helm-charts-repo` via
> ```
> aws s3 rm s3://dumrauf-helm-charts-repo --recursive
> ```
> 
> Note that due to versioning, [additional steps](https://docs.aws.amazon.com/AmazonS3/latest/dev/delete-or-empty-bucket.html#empty-bucket) may be necessary.
> 
> 
> 
> 
> # About
> 
> The Helm chart repository `dumrauf` and this documentation was created using [https://github.com/dumrauf/s3-helm-chart-repo-with-docs](https://github.com/dumrauf/s3-helm-chart-repo-with-docs).
> Create your own Helm chart repository with auto-generated documentation and start serving Helm charts in a matter of seconds.


## Deletion

The Helm chart repository can be deleted by running
```
terraform destroy -var-file=settings/example.tfvars
```


## Credits

This respository uses the following projects for handling markdown:

1. Showdown from [https://github.com/showdownjs/showdown](https://github.com/showdownjs/showdown) to render the generated markdown entirely in the visitor's browser
2. The minified GitHub markdown CSS from [https://www.npmjs.com/package/github-markdown-css](https://www.npmjs.com/package/github-markdown-css) to achieve a GitHub like look and feel of the resulting `index.html` page


## FAQs


### Why's the Bucket Not Emptied Before It's Destroyed?

The `force_destroy` option is deliberately set to `false` in `variables.tf` in order to avoid accidental deletion of the contents when running `terraform destroy`. It's essentially a safety net. Feel free to change and use it at your own risk.


## Helm Chart Repositories

For a detailed overview of Helm chart repositories, see the excellent official Helm documentation on [https://docs.helm.sh/developing_charts/#the-chart-repository-guide](https://docs.helm.sh/developing_charts/#the-chart-repository-guide).
