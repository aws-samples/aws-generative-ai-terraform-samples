
output "knowledge-base-id" {
  description = "The Bedrock Agent's first knowledge base"
  value       = length(module.bedrock.bedrock_agent) > 0 ? length(module.bedrock.bedrock_agent[0].knowledge_bases) > 0 ? module.bedrock.bedrock_agent[0].knowledge_bases[0].knowledge_base_id : null : null
}

output "default_kb_identifier" {
  description = "The Bedrock Agent's default knowledge base"
  value       = module.bedrock.default_kb_identifier
}

output "s3_uri" {
  description = "The S3 Data source bucket name."
  value       = module.bedrock.s3_data_source_arn != null ? join("", concat(["s3://", split(":", module.bedrock.s3_data_source_arn)[length(split(":", module.bedrock.s3_data_source_arn)) - 1]])) : null
}

output "bedrock_agent" {
  description = "valu"
  value = length(module.bedrock.bedrock_agent) > 0 ? module.bedrock.bedrock_agent[0].agent_id : null #.agent_id
}