# Amazon Bedrock Guardrails

This example shows how to deploy a basic Bedrock agent with guardrails, leaving the default values and without creating an action group or a knowledgebase.

## Overview

The AWS Terraform [bedrock](https://registry.terraform.io/modules/aws-ia/bedrock/aws/latest) module
abstracts the complexity of orchestrating AWS services like for Bedrock's guardrails.

## Folder Structure

The key files are annotated below:

```tree
├── README.md
├── data.tf
├── guardrails.auto.tfvars        # The configuration for the example guardrail
├── main.tf
├── outputs.tf                    # Outputs for the two bedrock agents
├── providers.tf
├── scripts
│    ├── input.txt                # The inputs to test (one line at a time)
│    ├── requirements.txt
│    └── review.py                # Script to send input and review output
└── variables.tf                  
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

2. Enter the code sample directory.

    ```shell
    cd generative-ai-cdk-constructs-samples/samples/bedrock-guardrails
    ```

3. Initialize Terraform.

    ```shell
    terraform init
    ...
    Terraform has been successfully initialized!
    ...
    ```

4. Deploy the two Agents (takes ~1min)

    ```shell
    terraform apply -auto-approve
    ...
    Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

    Outputs:

    bedrock_agent_id_with_guardrail = "ZYXWVUTSR1"
    bedrock_agent_id_without_guardrail = "ABCDEFGHI9"
    ```

5. Note the two outputs for the Bedrock Agents for testing

## Test the agents

We will use input similiar to the `examples` in the `topics_config` variable listed within the `guardrails.auto.tfvars` file:

- `What stocks should I invest in for my retirement?`
- `Is it a good idea to put my money in a mutual fund?`
- `How should I allocate my 401(k) investments?`
- `What type of trust fund should I set up for my children?`
- `Should I hire a financial advisor to manage my investments?`

### Use scripts

1. Enter the scripts directory.

    ```shell
    cd scripts
    ```

2. Create and activate your python virtual environment.

    ```shell
    python -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
    ```

3. Run the script to see each agents responses.

    ```shell
    python review.py
    ```

4. (optional) Alter the `input.txt` and run the previous step again to see changes

5. Deactivate and remove the virtual environment

    ```shell
    deactivate
    rm -r -f .venv
    ```

### Use the console to test the agents with more examples

Alternatively, open the console test each agent (one with and one without guardrails) directly. _See [Test and troubleshoot agent behavior](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html)_.

## Cleanup

1. Tear the terraform solution down (~30 seconds).

    ```shell
    terraform destroy -auto-approve
    ...
    Destroy complete! Resources: 11 destroyed.
    ```

## References

Here is a sample repositories and workshop to dive deeper with guardrails!

- ["Responsible AI Samples" in Amazon Bedrock Service Sample Repository on Github](https://github.com/aws-samples/amazon-bedrock-samples/blob/main/responsible_ai)
- ["Lab 8 - Creating Agent with Guardrails for Amazon Bedrock integration" in Amazon Bedrock Agents Workshop](https://catalog.workshops.aws/agents-for-amazon-bedrock/en-US/80-create-agent-with-guardrails)
