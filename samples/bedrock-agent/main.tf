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
  source                       = "github.com/aws-ia/terraform-aws-bedrock//?ref= e7f614dc9ba33b8b9d27f042a3c1e0ace877443f"
  # source                       = "aws-ia/bedrock/aws"
  # version                      = "0.0.5"
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
  kb_embedding_model_arn       = "arn:aws:bedrock:${var.region}::foundation-model/amazon.titan-embed-text-v1"
}

module "lambda" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source        = "terraform-aws-modules/lambda/aws"
  version       = "7.16.0"
  function_name = "bedrock-agent-action"
  handler       = "index.handler"
  runtime       = "python3.12"
  publish       = true
  timeout       = 45
  architectures = ["${var.architecture}", ]
  layers        = ["arn:aws:lambda:${var.region}:017000801446:layer:AWSLambdaPowertoolsPythonV3-python312-${var.architecture}:4", ]
  source_path = [
    {
      path           = "${path.module}/lambda/action-group"
      poetry_install = true
    }
  ]
}

resource "aws_lambda_permission" "allow_bedrock_agent" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_arn
  principal     = "bedrock.amazonaws.com"
  source_arn    = module.bedrock.bedrock_agent[0].agent_arn
}

resource "aws_iam_role_policy" "agent_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "lambda:InvokeModel"
        Resource = module.lambda.lambda_function_arn
      }
    ]
  })
  role = split("/", provider::aws::arn_parse(module.bedrock.bedrock_agent[0].agent_resource_role_arn).resource)[1]
}
