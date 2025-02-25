# AWS Generative AI Terraform Samples

This repository provides Terraform samples to demonstrate how to build your own Generative AI solutions using AWS Generative AI Terraform modules like the [Amazon Bedrock module](https://registry.terraform.io/modules/aws-ia/bedrock/aws/latest). The objective is to continue to add examples as new AWS Terraform modules are released. Once they are understood in depth, they can be used to extend on your own.

<!-- Badges -->

## Getting started

Explore each self-contained example in the samples directory to get started!

## Structure

Each folder under the `samples` directory has a `README.md` with the specific instructions required to understand, execute, and cleanup the sample.

```folder
└── samples
    ├── document-explorer               # Deploy a generative AI document explorer
    │   ├── README.md                   # Instructions
    │   ├── client_app                  # Steamlit application
    │   │   └── Dockerfile              # Contain image (environmental variables updates required before frontend deploys)
    │   ├── terraform-config-backend    # Backend Infrastructure
    │   │   ├── main.tf                 # The main resources to be created (optional `solution_prefix`)
    │   │   └── outputs.tf              # The outputs needed for the frontend (`Dockerfile`, and `terraform.tfvars`)
    │   └── terraform-config-frontend   # Frontend Infrastructure
    │       ├── main.tf                 # The main resources for the frontend (optional `app_name`)
    │       ├── outputs.tf              # The outputs needed for accessing the cloud deployment (and second `Dockerfile` edit)
    │       └── terraform.tfvars        # The variables from the backend to be entered
    ├── bedrock-agent                   # Deploy an Amazon Bedrock Agen
    │   ├── README.md                   # Instructions
    │   ├── main.tf                     # The main file
    │   ├── outputs.tf                  # Outputs to use in the initial loading script
    │   ├── scripts/load-kb.sh          # Script to load and synchronize the Bedrock knowledge base's data source
    │   ├── lambda/action-group/        # Code for the action group
    │   └── lambda/action-group.yaml    # The Open API specification for the action group
    ├── bedrock-guardrails              # An example usage for Bedrock guardrails
    │   ├── README.md                   # Instructions
    │   ├── main.tf                     # The main file
    │   ├── outputs.tf                  # Outputs to use while testing
    │   └── scripts/                    # A folder to test and review Bedrock guardrails
    └── ...
    
```

## Issues, Support, Security, and Contributing

Please add issues to this repository directly for the best support. This is a best effort repository and there is no expected SLA. In regards to security, please report it to [Security](mailto:security@aws.com). If you are interested in contributiong, please fork the repository and submit a merge or pull request.

## License

This library is licensed under the [MIT-0](https://github.com/aws/mit-0) License. See the LICENSE file.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

We hope you **Enjoy Exploring!**
