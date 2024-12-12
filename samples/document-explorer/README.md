# Document Explorer

## Overview

The "Document Explorer" sample AWS generative AI terraform application demonstrates how to build end-to-end solutions leveraging AWS services the [genai-document-ingestion-rag](https://registry.terraform.io/modules/aws-ia/genai-document-ingestion-rag/aws) AWS Generative AI Terraform Module.

It includes examples of key components needed in generative AI applications:

- [Data Ingestion Pipeline](https://github.com/aws-ia/terraform-aws-genai-document-ingestion-rag/tree/main/modules/document-ingestion): Ingests documents, converts them to text, and stores them in a knowledge base for retrieval. This enables long context window approaches.

- [Document Summarization](https://github.com/aws-ia/terraform-aws-genai-document-ingestion-rag/tree/main/modules/summarization): Summarizes PDF documents leveraging Large Language Models like Anthropic Claude V2 via Amazon Bedrock.

- [Question Answering](https://github.com/aws-ia/terraform-aws-genai-document-ingestion-rag/tree/main/modules/question-answering): Answers natural language questions by retrieving relevant documents from the knowledge base and leveraging Large Language Models like Anthropic Claude V2 via Amazon Bedrock.

By providing reusable constructs following AWS best practices, this app helps you quickly build custom generative AI apps on AWS. The constructs abstract complexity of orchestrating AWS services like Lambda, OpenSearch, Step Functions, Bedrock, etc.

Here is the architecture diagram of the sample application:

### Front-End Architecture

![Frontend Architecture Diagram](docs/images/StreamlitFrontend.png)

### Back-End Architecture

![Backend Architecture Diagram](docs/images/architecture.png)

## Folder Structure

This Document Explorer codebase is organized into folders containing the ```frontend``` and ```backend``` infrastructure code. The frontend client app is built with [Streamlit](https://streamlit.io/) and is located in the ```client_app``` folder. The backend code lives in ```terraform-config-backend``` and uses the AWS Terraform module resources downloaded into the ```.terraform``` folder.

The key folders are:

```tree
samples/document-explorer
├── client_app                                   # Frontend using Python Streamlit
│   │
│   ├── Home.ts                                  # Sample app entry point
│   ├── Dockerfile                               # Sample app Dockerfile
│   ├── assets/                                  # Static files
│   ├── common/                                  # Utility classes
│   ├── graphql/                                 # GraphQL statements and client
│   └── pages/                                   # Streamlit pages for document selection, summarization, and QA
│
├── terraform-config-frontend                    # Frontend – Terraform
│   │
│   ├── main.tf                                  # Terraform resources 
│   ├── outputs.tf                               # Outputs definition
│   ├── variables.tf                             # Variables defintion
│   └── terraform.tfvars                         # Variables values
│
└── terraform-config-backend                    # Backend – Terraform
    │
    ├── main.tf                                  # Terraform resources 
    └── outputs.tf                               # Outputs definition
```

## Getting started

To deploy this Document Explorer, follow these steps to set up the required tools and configure your AWS environment:

### Prerequisites

- An AWS account. We recommend you deploy this solution in a new account.
- [AWS CLI](https://aws.amazon.com/cli/): configure your credentials

```shell
% aws configure --profile [your-profile] 
AWS Access Key ID [None]: xxxxxx
AWS Secret Access Key [None]:yyyyyyyyyy
Default region name [None]: us-east-1 
Default output format [None]: json
```

- Node.js: v18.12.1
- [AWS CDK](https://github.com/aws/aws-cdk/releases/tag/v2.68.0): 2.68.0
- jq: jq-1.6
- Clone this repository.

    ```shell
    git clone https://github.com/aws-samples/aws-generative-ai-terraform-samples.git
    ```

- Enter the code sample directory.

    ```shell
    cd samples/document-explorer
    ```

- Enable Access to Amazon Bedrock Models

> You must explicitly enable access to models before they can be used with the Amazon Bedrock service. Please follow these steps in the [Amazon Bedrock User Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html) to enable access to the models (at minimum, ```Anthropic::Claude```):.

### Deploy with Terraform

<!-- markdownlint-disable MD033 -->
<details><summary>Terraform Instructions</summary>
<!-- markdownlint-enable MD033 -->

#### Deploy the Backend

 1. Open the `/terraform-config-backend` folder

    ```shell
        cd terraform-config-backend
    ```

 2. Run `terraform init`
 3. Make sure you have Docker running and deploy the Terraform by running `terraform apply`
 4. When prompted with `Do you want to perform these actions?` enter `yes` and wait for the backend to be deployed.

#### Deploy the Front End

1. Open the `/terraform-config-frontend` folder.

    ```shell
    cd ../terraform-config-frontend
    ```

2. Configure your environment variables in `client_app/Dockerfile`. Replace the property values with the values the were outputted from the backend Terraform deployment in your terminal. You will leave `APP_URI` as a placeholder for now because the URI will be the Cloudfront URL output from your Front End Terraform deployment.

> [!TIP]
> Use this command-line to get them from the Terraform outputs to copy and paste into the Dockerfile:

  ```shell
  terraform output | tr a-z A-Z | sed -e 's/ = /=/g' | sed -e 's/^/ENV /g' | sort -u
  ```

  ```Dockerfile
ENV AUTHENTICATED_ROLE_ARN='<AUTHENTICATED_ROLE_ARN>'
ENV CLIENT_ID='<CLIENT_ID>'
ENV CLIENT_NAME='<CLIENT_NAME>'
ENV COGNITO_DOMAIN='<COGNITO_DOMAIN>'
ENV GRAPHQL_ENDPOINT='<GRAPHQL_ENDPOINT>'
ENV IDENTITY_POOL_ID='<IDENTITY_POOL_ID>'
ENV REGION='<REGION>'
ENV S3_INPUT_BUCKET='<S3_INPUT_BUCKET>'
ENV S3_PROCESSED_BUCKET='<S3_PROCESSED_BUCKET>'
ENV USER_POOL_ID='<USER_POOL_ID>'
  ```

  Note: The ```location_of_cognito_user_client_secret``` is a location of the secret value that can be retrieved from the AWS Console. Go to the [Amazon Cognito page](https://console.aws.amazon.com/cognito/home) in the AWS console, then select the created user pool. Under App integration, select App client settings. Then, select Show Details and copy the value of the App client secret.

<!-- markdownlint-disable MD029 -->
3. Run `terraform init`
<!-- markdownlint-enable MD029 -->

<!-- markdownlint-disable MD029 -->
4. Run `terraform import aws_cognito_user_pool_client.update_client {user-pool-id}/{client-id}` and make sure to update the `user-pool-id` and `client-id` values. In the `terraform.tfvars` folder, add the values for the `user_pool_id`, `client_name`, `client_id`, and `region`.
<!-- markdownlint-enable MD029 -->

<!-- markdownlint-disable MD029 -->
5. Run `terraform import aws_cognito_identity_pool.update_pool {identity-pool-id}`.
<!-- markdownlint-enable MD029 -->

<!-- markdownlint-disable MD029 -->
6. Deploy the Terraform by running `terraform apply`
<!-- markdownlint-enable MD029 -->

<!-- markdownlint-disable MD029 -->
7. Now that you have the CloudFront URL, go back to your `client_app/Dockerfile` and paste in the value of your Cloudfront URL like `https://XXXXXXXXXXXXXX.cloudfront.net/` for your APP_URI. Save the Dockerfile and run `terraform apply` again.
<!-- markdownlint-enable MD029 -->

<!-- markdownlint-disable MD029 -->
8. Once your changes have been applied, open your browser to the outputted URL. It may take a few moments for the webapp to become available.
<!-- markdownlint-enable MD029 -->

</details>

### Deploy the Front End Locally

<!-- markdownlint-disable MD033 -->
<details><summary>Local Deployment Instructions</summary>  
<!-- markdownlint-enable MD033 -->

1. Configure client_app

    ```shell
    cd client_app
    python -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    ```

2. Still within the /client_app directory, create an ```.env``` file with the following content or mutate the ```.env-example```. Replace the property values with the values retrieved from the stack outputs/console.

  ```.env
  COGNITO_DOMAIN="<ApiStack.CognitoDomain>"
  REGION="<ApiStack.Region>"
  USER_POOL_ID="<ApiStack.UserPoolId>"
  CLIENT_ID="<ApiStack.ClientId>"
  CLIENT_SECRET="COGNITO_CLIENT_SECRET"
  IDENTITY_POOL_ID="<ApiStack.IdentityPoolId>"
  APP_URI="http://localhost:8501/"
  AUTHENTICATED_ROLE_ARN="<ApiStack.AuthenticatedRoleArn>"
  GRAPHQL_ENDPOINT = "<ApiStack.GraphQLEndpoint>"
  S3_INPUT_BUCKET = "<PersistenceStack.InputsAssetsBucket>"
  S3_PROCESSED_BUCKET = "<PersistenceStack.processedAssetsBucket>"
  ```

Note: The ```COGNITO_CLIENT_SECRET``` is a secret value that can be retrieved from the AWS Console. Go to the [Amazon Cognito page](https://console.aws.amazon.com/cognito/home) in the AWS console, then select the created user pool. Under App integration, select App client settings. Then, select Show Details and copy the value of the App client secret.
3. Run client_app

  ```shell
  streamlit run Home.py
  ```

</details>

### Test

- Create a user in the Cognito user pool. Go to the [Amazon Cognito page](https://console.aws.amazon.com/cognito/home) in the AWS console, then select the created user pool. Under users, select Create user and fill in the form

- Access the webapp (either locally or through the Amplify hosted domain) and sign in using the user credentials you just created

- Upload sample PDF files to the input bucket. For example, download Amazon's Annual Letters to Shareholders from 1997-2022 from [ir.aboutamazon.com](https://ir.aboutamazon.com/annual-reports-proxies-and-shareholder-letters/default.aspx). Then:

### Step 01. Test document ingestion

`Subscription` *(Optional - to track completion)*

```graphql
subscription UpdateIngestionJobStatus {
  updateIngestionJobStatus(ingestionjobid: "1997-2022") {
    files {
      name
      status
    }
  }
}
```

`Mutation`

```graphql
mutation IngestDocuments {
  ingestDocuments(
    ingestioninput: {
      files: [
        {status: "", name: "1997 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "1998 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "1999 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2000 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2001 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2002 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2003 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2004 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2005 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2006 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2007 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2008 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2009 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2010 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2011 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2012 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2013 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2014 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2015 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2016 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2017 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2018 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2019 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2020 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2021 Amazon Shareholder Letter.pdf"}, 
        {status: "", name: "2022 Amazon Shareholder Letter.pdf"}, 
      ], 
      ingestionjobid: "1997-2022"}
    ) {
    __typename
  }
}
```

### Step 02. Run summarization

```Subscription```

```graphql
subscription UpdateSummaryJobStatus {
  updateSummaryJobStatus(summary_job_id: "2022_Amazon_Shareholder_Letter") {
    summary_job_id
    files {
      name
      status
      summary
    }
  }
}
```

```Mutation```

```graphql
mutation GenerateSummary {
    generateSummary(summaryInput: {
        summary_job_id: "2022_Amazon_Shareholder_Letter",
        files: [{name: "2022 Amazon Shareholder Letter.txt"}],
    }) {
    __typename
  }
}
```

### Step 03. Ask question

```Subscription```

```graphql
subscription UpdateQAJobStatus {
  updateQAJobStatus(jobid: "11a94ffc-423a-4157-a9c2-892446f9a1fe") {
    question
    answer
    jobstatus
  }
}
```

```Post Question```

```graphql
mutation PostQuestion {
    postQuestion(
        jobid: "11a94ffc-423a-4157-a9c2-892446f9a1fe"
        jobstatus: ""
        filename: "2022 Amazon Shareholder Letter.txt"
        question: "V2hvIGlzIEJlem9zPw=="
        max_docs: 1
        verbose: false
    ) {
    __typename
    }
}
```

## Clean up

Do not forget to delete the deployments to avoid unexpected charges.

First make sure to remove all data from the Amazon Simple Storage Service (Amazon S3) Buckets. Then if you deployed with CDK:

```shell
terraform destroy
```

Then in the AWS Console delete the S3 buckets.

## Content Security Legal Disclaimer

The sample code; software libraries; command line tools; proofs of concept; templates; or other related technology (including any of the foregoing that are provided by our personnel) is provided to you as AWS Content under the AWS Customer Agreement, or the relevant written agreement between you and AWS (whichever applies). You should not use this AWS Content in your production accounts, or on production or other critical data. You are responsible for testing, securing, and optimizing the AWS Content, such as sample code, as appropriate for production grade use based on your specific quality control practices and standards. Deploying AWS Content may incur AWS charges for creating or using AWS chargeable resources, such as running Amazon EC2 instances or using Amazon S3 storage.
