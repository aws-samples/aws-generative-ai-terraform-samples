module "bedrock_withoutguardrail" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source                = "github.com/aws-ia/terraform-aws-bedrock//?ref=e7f614dc9ba33b8b9d27f042a3c1e0ace877443f"
  # source                = "aws-ia/bedrock/aws"
  # version               = "0.0.5"
  create_kb             = false
  create_default_kb     = false
  create_s3_data_source = false
  create_agent          = true
  create_ag             = false
  foundation_model      = var.foundation_model
  instruction           = "You are a customer support agent for a financial institution that can answer general questions."

  create_guardrail = false
  agent_name       = "WithoutGuardrail"
}

module "bedrock_withguardrail" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source                = "github.com/aws-ia/terraform-aws-bedrock//?ref=e7f614dc9ba33b8b9d27f042a3c1e0ace877443f"
  # source                = "aws-ia/bedrock/aws"
  # version               = "0.0.5"
  create_kb             = false
  create_default_kb     = false
  create_s3_data_source = false
  create_agent          = true
  create_ag             = false
  foundation_model      = var.foundation_model
  instruction           = "You are a customer support agent for a financial institution that can answer general questions."
  # above here is the same as above in the withoutguardrail module

  create_guardrail          = true
  agent_name                = "WithGuardrail"
  pii_entities_config       = var.pii_entities_config
  filters_config            = var.filters_config
  regexes_config            = var.regexes_config
  managed_word_lists_config = var.managed_word_lists_config
  words_config              = var.words_config
  topics_config             = var.topics_config
  blocked_input_messaging   = var.blocked_input_messaging
  blocked_outputs_messaging = var.blocked_outputs_messaging
}

resource "aws_iam_role_policy" "guardrail_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "bedrock:ApplyGuardrail",
        ]
        Resource = module.bedrock_withguardrail.bedrock_agent[0].guardrail_configuration.guardrail_identifier
      }
    ]
  })
  role = split("/", provider::aws::arn_parse(module.bedrock_withguardrail.bedrock_agent[0].agent_resource_role_arn).resource)[1]
}