# Amazon Bedrock Guardrails

This example shows how to deploy a basic Bedrock agent with guardrails, leaving the default values and without creating an action group or a knowledgebase.

## Overview

The AWS Terraform [bedrock](https://registry.terraform.io/modules/aws-ia/bedrock/aws/latest) module
abstracts the complexity of orchestrating AWS services like for Bedrock's guardrails. This 

## Folder Structure

This sample application codebase is organized into folders : the backend code lives in
The key folders are:

```tree
├── README.md
├── main.tf                      # Creation of the bedrock agent and lambda action group
├── outputs.tf                   # Outputs to use in the initial loading script
├── providers.tf
├── variables.tf
└── scripts
    ├── without_guardrails.sh    # Script to test without Bedrock Guardrails
    ├── with_guardrails.sh       # Script to test with Bedrock Guardrails
    └── requirements.txt         # Script to load and synchronize the Bedrock knowledge base's data source
```

## Getting started

### Prerequisites

- An AWS account. We recommend you deploy this solution in a new account.
- [AWS CLI](https://aws.amazon.com/cli/): configure your credentials

```shell
aws configure --profile [your-profile] 
AWS Access Key ID [None]: xxxxxx
AWS Secret Access Key [None]:yyyyyyyyyy
Default region name [None]: us-east-1 
Default output format [None]: json
```

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli): v1.7.4 or greater
- [Python](https://www.python.org/downloads/): 3.12 or greater

### Deploy the solution

This project is built using [Terraform](https://www.terraform.io/). See [Getting Started - AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started) for additional details and prerequisites.

1. Clone this repository.
    ```shell
    git clone https://github.com/aws-samples/generative-ai-cdk-constructs-samples.git
    ```

2. Enter the code sample backend directory.
    ```shell
    cd generative-ai-cdk-constructs-samples/samples/bedrock-agent
    ```
