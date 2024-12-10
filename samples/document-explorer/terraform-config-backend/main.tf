module "genai_doc_ingestion" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  # source             = "aws-ia/genai-document-ingestion-rag/aws"
  # version            = "1.0.1"
  source             = "github.com/aws-ia/terraform-aws-genai-document-ingestion-rag//?ref=4137b7ede3b80c11d28658877c97b3fef22cf31e"

  solution_prefix    = "doc-explorer"
  container_platform = "linux/amd64"
  force_destroy      = true
}
