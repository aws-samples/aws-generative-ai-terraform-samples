output "bedrock_agent_without_guardrail_arn" {
  description = "The Amazon Bedrock Agent ARN to test without Guardrails"
  value       = length(module.bedrock_withoutguardrail.bedrock_agent) > 0 ? module.bedrock_withoutguardrail.bedrock_agent[0].agent_arn : null
}

output "bedrock_agent_with_guardrail_arn" {
  description = "The Amazon Bedrock Agent ARN to test with Guardrails"
  value       = length(module.bedrock_withguardrail.bedrock_agent) > 0 ? module.bedrock_withguardrail.bedrock_agent[0].agent_arn : null
}

output "bedrock_agent_guardrail_identifier" {
  description = "The Amazon Bedrock Agent Guardrail Identifier"
  value       = length(module.bedrock_withguardrail.bedrock_agent) > 0 ? module.bedrock_withguardrail.bedrock_agent[0].guardrail_configuration.guardrail_identifier : null
}
