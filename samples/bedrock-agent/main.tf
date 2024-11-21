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
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  # source            = "aws-ia/bedrock/aws"
  # version           = "0.0.3"
  source            = "github.com/aws-ia/terraform-aws-bedrock//?ref=9c8177664a05a5596aaaa9cc0acaf75c16f4c407"
  create_kb         = true
  create_default_kb = true
  create_agent      = true
  foundation_model  = "anthropic.claude-v2"
  instruction       = "You are an automotive assisant who can provide detailed information about cars to a customer."
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.15.0"

  function_name = "bedrock-agent-${lower(module.bedrock.bedrock_agent[0].agent_id)}-action"
  handler       = "index.handler"
  runtime       = "python3.12"
  publish       = true

  # https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/master/examples/fixtures/python-app-src-poetry/pyproject.toml
  # build_in_docker = true
  # docker_image = "build-python-poetry"

  source_path = [
    {
      path           = "${path.module}/lambda/action-group"
      poetry_install = true
    }
  ]

  architectures = [
    "arm64",
    # "x86_64",
  ]
  layers = [
    "arn:aws:lambda:${var.region}:017000801446:layer:AWSLambdaPowertoolsPythonV3-python312-arm64:4",
    # "arn:aws:lambda:${var.region}:017000801446:layer:AWSLambdaPowertoolsPythonV3-python312-x86_64:4",
  ]

  hash_extra = "yo1"
}
