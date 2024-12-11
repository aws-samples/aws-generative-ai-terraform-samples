module "genai_doc_ingestion" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source             = "aws-ia/genai-document-ingestion-rag/aws"
  version            = "1.0.1"

  solution_prefix    = "doc-explorer"
  container_platform = var.container_platform
  force_destroy      = true
}
