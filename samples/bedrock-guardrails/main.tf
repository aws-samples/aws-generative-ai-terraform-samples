#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "bedrock" {
  #checkov:skip=CKV_TF_1:Terraform registry has no ability to use a commit hash
  source                = "aws-ia/bedrock/aws"
  version               = "0.0.3"
  create_kb             = false
  create_default_kb     = false
  create_s3_data_source = false
  create_guardrail      = true
  filters_config = [
    {
      input_strength  = "MEDIUM"
      output_strength = "MEDIUM"
      type            = "HATE"
    },
    {
      input_strength  = "HIGH"
      output_strength = "HIGH"
      type            = "VIOLENCE"
    }
  ]
  pii_entities_config = [
    {
      action = "BLOCK"
      type   = "NAME"
    },
    {
      action = "BLOCK"
      type   = "DRIVER_ID"
    },
    {
      action = "ANONYMIZE"
      type   = "USERNAME"
    },
  ]
  regexes_config = [{
    action      = "BLOCK"
    description = "example regex"
    name        = "regex_example"
    pattern     = "^\\d{3}-\\d{2}-\\d{4}$"
  }]
  managed_word_lists_config = [{
    type = "PROFANITY"
  }]
  words_config = [{
    text = "HATE"
  }]
  topics_config = [{
    name       = "investment_topic"
    examples   = ["Where should I invest my money ?"]
    type       = "DENY"
    definition = "Investment advice refers to inquiries, guidance, or recommendations regarding the management or allocation of funds or assets with the goal of generating returns ."
  }]
  foundation_model = var.foundation_model
  instruction      = "You are an automotive assisant who can provide detailed information about cars to a customer."
}