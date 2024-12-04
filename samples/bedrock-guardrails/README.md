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
├── guardrails.auto.tfvars       # The configuration of the sample guardrails
└── scripts
    ├── 01_without_guardrails.py # Script to test without Bedrock Guardrails
    ├── 02_with_guardrails.py    # Script to test with Bedrock Guardrails
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

    bedrock_agent_guardrail_identifier = "arn:aws:bedrock:aa-example-1:555555555555:guardrail/a1bcdefghijk"
    bedrock_agent_with_guardrail_arn = "arn:aws:bedrock:aa-example-1:555555555555:agent/ZYXWVUTSR1"
    bedrock_agent_without_guardrail_arn = "arn:aws:bedrock:aa-example-1:555555555555:agent/ABCDEFGHI9"
    ```

5. Record the two outputs for the Bedrock Agents for testing

## Test the agents

We will use the `examples` in the `topics_config` variable listed within the `guardrails.auto.tfvars` file:

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
    ```

3. Run the script without guardrails.

    ```shell
    python 01_without_guardrails.py
    ```

4. Run the script with guardrails.

    ```shell
    python 02_with_guardrails.py
    ```

5. Deactivate and remove the virtual environment

    ```shell
    deactivate
    rm -r -f .venv
    ```

### Use the console to test the agents

Open the console test the agents.

## Cleanup

1. Tear the terraform solution down (~30 seconds).

    ```shell
    terraform destroy -auto-approve
    ...
    Destroy complete! Resources: 11 destroyed.
    ```

## References

Here are some Bedrock Agents samples repositories and workshops for a deeper dive with guardrails!