locals {
  index_md_file_name   = "${local.full_bucket_name}.index.md"
  index_md_path        = "${path.module}/${local.index_md_file_name}"
  index_html_file_name = "${local.full_bucket_name}.index.html"
  index_html_path      = "${path.module}/${local.index_html_file_name}"
}

data "template_file" "helm-chart-repository-index-md" {
  template = "${file("${path.module}/templates/index.md.tpl")}"

  vars {
    helm_repo_bucket_domain_name = "${aws_s3_bucket.helm-chart-repository.bucket_domain_name}"
    helm_repo_website_endpoint   = "${aws_s3_bucket.helm-chart-repository.website_endpoint}"
    full_bucket_name             = "${local.full_bucket_name}"
    repository_name              = "${var.repository_name}"
    index_html_file_name         = "${local.index_html_file_name}"
  }
}

data "template_file" "helm-chart-repository-index-html" {
  template = "${file("${path.module}/templates/index.html.tpl")}"

  vars {
    rendered_markdown = "${data.template_file.helm-chart-repository-index-md.rendered}"
    repository_name   = "${var.repository_name}"
  }
}

resource "local_file" "helm-chart-repository-index-md" {
  content  = "${data.template_file.helm-chart-repository-index-md.rendered}"
  filename = "${local.index_md_path}"
}

resource "local_file" "helm-chart-repository-index-html" {
  content  = "${data.template_file.helm-chart-repository-index-html.rendered}"
  filename = "${local.index_html_path}"
}

output "helm_chart_repository_bucket_domain_name" {
  value = "${aws_s3_bucket.helm-chart-repository.bucket_domain_name}"
}

output "helm_chart_repository_website_endpoint" {
  value = "${aws_s3_bucket.helm-chart-repository.website_endpoint}"
}
