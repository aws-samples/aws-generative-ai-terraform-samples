output "bedrock_agent_id" {
  description = "The Amazon Bedrock Agent Id"
  value       = length(module.bedrock.bedrock_agent) > 0 ? module.bedrock.bedrock_agent[0].agent_id : null
}

output "s3_uri" {
  description = "The S3 Data source bucket name."
  value       = module.bedrock.s3_data_source_arn != null ? join("", concat(["s3://", split(":", module.bedrock.s3_data_source_arn)[length(split(":", module.bedrock.s3_data_source_arn)) - 1]])) : null
}

output "knowledge_base_id" {
  description = "The Bedrock Agent's first knowledge base"
  value       = length(module.bedrock.bedrock_agent) > 0 ? length(module.bedrock.bedrock_agent[0].knowledge_bases) > 0 ? module.bedrock.bedrock_agent[0].knowledge_bases[0].knowledge_base_id : null : null
}

output "data_source_id" {
  description = "The Bedrock Agent's data source"
  value       = module.bedrock.datasource_identifier
}