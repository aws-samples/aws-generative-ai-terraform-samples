output "s3_uri" {
  description = "The S3 Data source bucket name."
  value       = module.bedrock.s3_data_source_arn != null ? join("", concat(["s3://", split(":", module.bedrock.s3_data_source_arn)[length(split(":", module.bedrock.s3_data_source_arn)) - 1]])) : null
}

output "knowledge-base-id" {
  description = "The Bedrock Agent's first knowledge base"
  value       = length(module.bedrock.bedrock_agent) > 0 ? length(module.bedrock.bedrock_agent[0].knowledge_bases) > 0 ? module.bedrock.bedrock_agent[0].knowledge_bases[0].knowledge_base_id : null : null
}

output "data-source-id" {
  description = "The Bedrock Agent's data source"
  value       = module.bedrock.datasource_identifier
}