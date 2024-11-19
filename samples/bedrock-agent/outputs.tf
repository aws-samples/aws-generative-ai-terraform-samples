
output "knowledge-base-id" {
    description = "The Bedrock Agent's first knowledge base"
    value = length(module.bedrock.bedrock_agent ) > 0 ? length(module.bedrock.bedrock_agent[0].knowledge_bases) > 0 ? module.bedrock.bedrock_agent[0].knowledge_bases[0].knowledge_base_id : null : null
}

output "s3_uri" {
  description = "The S3 Data source bucket name."
  value       = module.bedrock.s3_data_source != null ? join("", concat(["s3://", module.bedrock.s3_data_source.bucket_name])) : null
}

output "data-source-id" {
    description = "The Knowledge Base Data source"
    value = length(module.bedrock.knowledge_base_data_source ) > 0 ? module.bedrock.knowledge_base_data_source[0].data_source_id : null
}