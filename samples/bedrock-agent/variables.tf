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
    error_message = "Please use a region supporting Agents for Amazon Bedrock https://docs.aws.amazon.com/general/latest/gr/bedrock.html."
  }
}

variable "architecture" {
  type        = string
  description = "The runtime architecture"
  nullable    = false
  default     = "x86_64"
  validation {
    condition     = contains(["x86_64", "arm64"], var.architecture)
    error_message = "The architecture must be either 'x86_64' or 'arm64'."
  }
}

variable "foundation_model" {
  type        = string
  description = "The foundation model to use for the agent"
  nullable    = false
  default     = "anthropic.claude-3-haiku-20240307-v1:0"
  validation {
    condition     = contains(data.aws_bedrock_foundation_models.test.model_summaries[*].model_id, var.foundation_model)
    error_message = "The foundational model is not found"
  }
}