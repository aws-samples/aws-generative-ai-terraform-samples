output "bedrock_agent_id_without_guardrail" {
  description = "The Amazon Bedrock Agent ARN to test without Guardrails"
  value       = length(module.bedrock_withoutguardrail.bedrock_agent) > 0 ? module.bedrock_withoutguardrail.bedrock_agent[0].agent_id : null
}

output "bedrock_agent_id_with_guardrail" {
  description = "The Amazon Bedrock Agent ARN to test with Guardrails"
  value       = length(module.bedrock_withguardrail.bedrock_agent) > 0 ? module.bedrock_withguardrail.bedrock_agent[0].agent_id : null
}
