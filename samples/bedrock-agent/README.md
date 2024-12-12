# Amazon Bedrock Agent

This example shows how to deploy an extended Bedrock agent,
creating a default Opensearch Serverless Bedrock knowledgebase with an S3 datasource.

## Overview

A chat assistant designed to answer questions about literature using RAG from a
selection of books from Project Gutenburg.

This app deploys a Bedrock Agent that can consult a Bedrock Knowledge Base
backed by OpenSearch Serverless as a vector store. An S3 bucket is created to
store the books for the Knowledge Base. The agent also includes a Bedrock Agent
Action Group that provides a function to query the most popular books in Project
Gutenburg.

By providing reusable modules following AWS best practices,
this app helps you quickly build custom generative AI apps on AWS using Terraform.

The AWS Terraform [bedrock](https://registry.terraform.io/modules/aws-ia/bedrock/aws/latest) module
abstracts the complexity of orchestrating AWS services like S3, OpenSearch, Bedrock, etc.

Here is the architecture diagram of the sample application:

![Architecture Diagram](docs/images/architecture.png)

## Folder Structure

This sample application codebase is organized into folders : the backend code lives in
The key folders are:

```tree
├── README.md
├── docs
│   └── images
│       └── architecture.png
├── lambda
│   ├── action-group             # Code for the action group lambda
│   │   ├── README.md
│   │   ├── gutendex.py
│   │   ├── index.py
│   │   ├── poetry.lock
│   │   └── pyproject.toml
│   └── action-group.yaml        # The Open API specification for the action group
├── main.tf                      # Creation of the bedrock agent and lambda action group
├── outputs.tf                   # Outputs to use in the initial loading script
├── providers.tf
└── scripts
    └── load-kb.sh               # Script to load and synchronize the Bedrock knowledge base's data source
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

- Terraform: v1.7.4 or greater
- Python: 3.12 or greater

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

3. Install packages
   ```shell
   python -m venv .venv
   source .venv/bin/activate
   pip install poetry
   ```

4. Initialize the neccessary Terraform providers.
    ```shell
    terraform init
    ```

5. Enable Access to Amazon Bedrock Models
> You must explicitly enable access to models before they can be used with the Amazon Bedrock service. Please follow these steps in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html) to enable access to the models (```Anthropic::Claude```):.

_NOTE: The default architecture is `x86_64`, feel free to add `-var="architecture=$(python -c "import platform;print('x86_64' if platform.machine().upper() in ['X86', 'AMD64'] else 'arm64')")"` to inspect and use your platform's architecture or set it directly with the `arm64.tfvars`_

6. Check the plan.

    ```shell
    terraform plan
    ```

7. Deploy the sample in your account.

    ```shell
    $ terraform apply
    ```

The command above will deploy in your AWS account. With the default configuration of this sample, the observed deployment time was ~451 seconds (7.5 minutes).

To protect you against unintended changes that affect your security posture, the Terraform prompts you to approve before deploying them. You will need to answer "yes" to get the solution deployed.

```
...

Apply complete! Resources: 30 added, 0 changed, 0 destroyed.

Outputs:

bedrock_agent_id = <AgentID>
data_source_id = <DataSourceID>
knowledge_base_id = <KBID>
s3_uri = <DocBucket>
```

8. Load Knowledge Base using the values from the outputs above.

    ```shell
    ./scripts/load-kb.sh <DocBucket> <KBID> <DataSourceID>
    ```

### Test

Navigate to the [Bedrock Agents console](https://console.aws.amazon.com/bedrock/home#/agents) in your region and find your new agent.

Ask some questions. You may need to tell the agent what book you want to ask about or refresh the session when asking about different books.

#### Example questions

* What are the most popular books in the library?

**Frankenstein**
* What does the Creature want Victor to do?

**Pride and Prejudice**
* Who is Mr. Bingley quite taken with at the ball in Meryton?
* How does Mr. Darcy offend Elizabeth at the first ball?
* Why does Jane’s visit to the Bingleys end up lasting for days?

**Moby Dick**
* What does Ahab nail to the ship’s mast to motivate his crew in his quest for Moby Dick?
* What frightens Ishmael the most about Moby Dick? 

**Romeo and Juliet**
* Why is Romeo exiled?
* Where do Romeo and Juliet meet?

## Clean up

Do not forget to delete the resources to avoid unexpected charges.

1. First make sure to remove all data from the Amazon Simple Storage Service (Amazon S3) Bucket.

    ```shell
    aws s3 rb <DocBucket> --force
    ```

2. Next, set the data source to retain to allow Terraform to destroy all the resources.
    - open the console to the Bedrock Knowledge base
    - click the name of the knowledge base and verify the page shows the knowlege base id as output above <KBID>
    - click the data source and verify the data source id is the <DataSourceID> as above
    - click the edit button and expand "Advanced settings"
    - Change the data deletion policy from "Delete" to "Retain"
    - Click the submit button

3. Last remove all the resources.

    ```shell
    terraform destroy
    ```

Delete all the associated logs created by the different services in Amazon CloudWatch logs

## Content Security Legal Disclaimer

The sample code; software libraries; command line tools; proofs of concept; templates; or other related technology (including any of the foregoing that are provided by our personnel) is provided to you as AWS Content under the AWS Customer Agreement, or the relevant written agreement between you and AWS (whichever applies). You should not use this AWS Content in your production accounts, or on production or other critical data. You are responsible for testing, securing, and optimizing the AWS Content, such as sample code, as appropriate for production grade use based on your specific quality control practices and standards. Deploying AWS Content may incur AWS charges for creating or using AWS chargeable resources, such as running Amazon EC2 instances or using Amazon S3 storage.
