blocked_input_messaging   = "I can provide general info about products and services, but can't fully address your request here. For personalized help or detailed questions, please contact our customer service team directly. For security reasons, avoid sharing sensitive information through this channel. If you have a general product question, feel free to ask without including personal details."
blocked_outputs_messaging = "I can provide general info about products and services, but can't fully address your request here. For personalized help or detailed questions, please contact our customer service team directly. For security reasons, avoid sharing sensitive information through this channel. If you have a general product question, feel free to ask without including personal details."
filters_config = [
  {
    input_strength  = "HIGH"
    output_strength = "HIGH"
    type            = "VIOLENCE"
  },
  {
    input_strength  = "HIGH"
    output_strength = "NONE"
    type            = "PROMPT_ATTACK"
  },
  {
    input_strength  = "HIGH"
    output_strength = "HIGH"
    type            = "MISCONDUCT"
  },
  {
    input_strength  = "HIGH"
    output_strength = "HIGH"
    type            = "HATE"
  },
  {
    input_strength  = "HIGH"
    output_strength = "HIGH"
    type            = "SEXUAL"
  },
  {
    input_strength  = "HIGH"
    output_strength = "HIGH"
    type            = "INSULTS"
  },
]
managed_word_lists_config = [
  {
    type = "PROFANITY"
  }
]
pii_entities_config = [
  {
    action = "ANONYMIZE"
    type   = "NAME"
  },
  {
    action = "ANONYMIZE"
    type   = "PHONE"
  },
  {
    action = "ANONYMIZE"
    type   = "EMAIL"
  },
  {
    action = "BLOCK"
    type   = "US_SOCIAL_SECURITY_NUMBER"
  },
  {
    action = "BLOCK"
    type   = "US_BANK_ACCOUNT_NUMBER"
  },
  {
    action = "BLOCK"
    type   = "CREDIT_DEBIT_CARD_NUMBER"
  },
]
regexes_config = [
  {
    name        = "Account Number"
    description = "Matches account numbers in the format XXXXXX1234"
    pattern     = "(\\b\\d{6}\\d{4}\\b)"
    action      = "ANONYMIZE"
  }
]
topics_config = [{
  name       = "Fiduciary Advice"
  type       = "DENY"
  definition = "Providing personalized advice or recommendations on managing financial assets, investments, or trusts in a fiduciary capacity or assuming related obligations and liabilities."
  examples = [
    "What stocks should I invest in for my retirement?",
    "Is it a good idea to put my money in a mutual fund?",
    "How should I allocate my 401(k) investments?",
    "What type of trust fund should I set up for my children?",
    "Should I hire a financial advisor to manage my investments?",
  ]
}]
words_config = [
  { text = "fiduciary advice" },
  { text = "investment recommendations" },
  { text = "stock picks" },
  { text = "financial planning guidance" },
  { text = "portfolio allocation advice" },
  { text = "retirement fund suggestions" },
  { text = "wealth management tips" },
  { text = "trust fund setup" },
  { text = "investment strategy" },
  { text = "financial advisor recommendations" },
]