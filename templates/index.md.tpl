# Helm Chart Repository `${repository_name}`

Welcome to the [Helm](https://github.com/helm/helm) [chart repository](https://docs.helm.sh/developing_charts/#the-chart-repository-guide) `${repository_name}`.
See below for instructions on how to add or remove this chart repository using `helm`.
If you're the owner of this Helm chart repository, then please refer to the "Managing the Repository" section below.




# Using the Repository

This section describes the use of the repository `${repository_name}`.
It describes how to add, search, and eventually remove the repository via `helm`.


## Adding the Repository

This chart repository can be [added to `helm`](https://docs.helm.sh/helm/#helm-repo-add) via

```
helm repo add ${repository_name} 'https://${helm_repo_bucket_domain_name}'
helm repo update
```
Here, the latter command is required in order to [get the (latest) information](https://docs.helm.sh/helm/#helm-repo-update) about charts from the repository `${repository_name}`.


## Searching the Repository

All charts in the repository can be [listed](https://docs.helm.sh/helm/#helm-search) via
```
helm search ${repository_name}
```


## Removing the Repository

This chart repository can be [removed from `helm`](https://docs.helm.sh/helm/#helm-repo-remove) via

```
helm repo remove ${repository_name}
```




# Managing the Repository

This section outlines steps for managing Helm chart repository `${repository_name}`.
It describes how to upload Helm charts and eventually delete them again.


## Uploading Helm Charts

The Helm charts can be uploaded to S3 bucket `${full_bucket_name}` via
```
aws s3 sync <packaged-charts-directory> s3://${full_bucket_name}
```

Assuming the packaged Helm charts are located in `../packaged-helm-charts/`, then they can be uploaded via
```
aws s3 sync ../packaged-helm-charts/ s3://${full_bucket_name}
```


## Deleting All Helm Charts

The Helm charts can be deleted from S3 bucket `${full_bucket_name}` via
```
aws s3 rm s3://${full_bucket_name} --recursive --exclude index.html
```

Note that due to versioning, [additional steps](https://docs.aws.amazon.com/AmazonS3/latest/dev/delete-or-empty-bucket.html#empty-bucket) may be necessary.




# About

The Helm chart repository `${repository_name}` and this documentation was created using [https://github.com/dumrauf/s3-helm-chart-repo-with-docs](https://github.com/dumrauf/s3-helm-chart-repo-with-docs) as introduced in article [Build Your Own Helm Chart Repository in S3 — With Auto-Generated User Documentation!](https://www.how-hard-can-it.be/helm-chart-repository-in-s3-with-auto-generated-user-docs/).
Create your own Helm chart repository with auto-generated documentation and start serving Helm charts in a matter of seconds.
