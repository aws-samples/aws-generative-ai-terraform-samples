variable "region" {
  type        = string
  description = "AWS region to deploy the resources"
  default     = "us-east-1"
}

provider "aws" {
  region = var.region
}

provider "awscc" {
  region = var.region
}

provider "opensearch" {
  url         = module.bedrock.default_collection[0].collection_endpoint
  healthcheck = false
}

module "bedrock" {
  source            = "aws-ia/bedrock/aws"
  version           = "0.0.2"
  create_kb         = true
  create_default_kb = true
  foundation_model  = "anthropic.claude-v2"
  instruction       = "You are an automotive assisant who can provide detailed information about cars to a customer."
}