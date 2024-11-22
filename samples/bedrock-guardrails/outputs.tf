output "bedrock_agent_arn" {
  description = "The Amazon Bedrock Agent ARN to test the Guardrails"
  value       = length(module.bedrock.bedrock_agent) > 0 ? module.bedrock.bedrock_agent[0].agent_arn : null
}

output "bedrock_agent_guardrail_identifier" {
  description = "The Amazon Bedrock Agent Guardrail Indentifier"
  value       = length(module.bedrock.bedrock_agent) > 0 ? module.bedrock.bedrock_agent[0].guardrail_configuration.guardrail_identifier : null
}
