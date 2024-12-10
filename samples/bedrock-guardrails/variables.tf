variable "region" {
  type        = string
  description = "AWS region to deploy the resources"
  default     = "us-east-1"
  validation {
    condition = contains([
      "us-east-1", "us-west-2",
      "ap-southeast-1", "ap-southeast-2", "ap-northeast-1", "ap-south-1",
      "ca-central-1",
      "eu-central-1", "eu-west-1", "eu-west-2", "eu-west-3",
      "sa-east-1",
    ], var.region)
    error_message = "Please use a region supporting Guardrails for Amazon Bedrock https://docs.aws.amazon.com/general/latest/gr/bedrock.html."
  }
}

variable "foundation_model" {
  type        = string
  description = "The foundation model to use for the agent"
  nullable    = false
  default     = "anthropic.claude-3-haiku-20240307-v1:0"
  # validation {
  #   condition     = contains(data.aws_bedrock_foundation_models.test.model_summaries[*].model_id, var.foundation_model)
  #   error_message = "The foundational model is not found"
  # }
}

# These are guardrail variables available within the Bedrock module and duplicated below for reference
# and to set with the `guardrails.auto.tfvars` file
variable "blocked_input_messaging" {
  description = "Messaging for when violations are detected in text."
  type        = string
  default     = "Blocked input"
}

variable "blocked_outputs_messaging" {
  description = "Messaging for when violations are detected in text."
  type        = string
  default     = "Blocked output"
}

variable "filters_config" {
  description = "List of content filter configs in content policy."
  type        = list(map(string))
  default     = null
}

variable "pii_entities_config" {
  description = "List of entities."
  type        = list(map(string))
  default     = null
}

variable "regexes_config" {
  description = "List of regex."
  type        = list(map(string))
  default     = null
}

variable "managed_word_lists_config" {
  description = "A config for the list of managed words."
  type        = list(map(string))
  default     = null
}

variable "words_config" {
  description = "List of custom word configs."
  type        = list(map(string))
  default     = null
}

variable "topics_config" {
  description = "List of topic configs in topic policy"
  type = list(object({
    name       = string
    examples   = list(string)
    type       = string
    definition = string
  }))
  default = null
}