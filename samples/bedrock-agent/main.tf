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
  #source                       = "github.com/aws-ia/terraform-aws-bedrock//?ref=58798f1fcf95db48ce3f336c7e93d50c83e27ce8"
  source                       = "aws-ia/bedrock/aws"
  version                      = "0.0.3"
  create_kb                    = true
  create_default_kb            = true
  create_agent                 = true
  foundation_model             = var.foundation_model
  instruction                  = "You are a helpful and friendly agent that answers questions about literature."
  create_ag                    = true
  action_group_name            = "bedrock-agent-action-group"
  action_group_description     = "Use these functions to get information about the books in the library."
  action_group_state           = "ENABLED"
  lambda_action_group_executor = module.lambda.lambda_function_arn
  api_schema_payload           = file("${path.module}/lambda/action-group.yaml")
}

module "lambda" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source        = "terraform-aws-modules/lambda/aws"
  version       = "7.15.0"
  function_name = "bedrock-agent-action"
  handler       = "index.handler"
  runtime       = "python3.12"
  publish       = true
  timeout       = 15
  architectures = ["${var.architecture}", ]
  layers        = ["arn:aws:lambda:${var.region}:017000801446:layer:AWSLambdaPowertoolsPythonV3-python312-${var.architecture}:4", ]
  source_path = [
    {
      path           = "${path.module}/lambda/action-group"
      poetry_install = true
    }
  ]
}
