module "bedrock_withoutguardrail" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source                = "aws-ia/bedrock/aws"
  version               = "0.0.17"
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
  source                = "aws-ia/bedrock/aws"
  version               = "0.0.17"
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
