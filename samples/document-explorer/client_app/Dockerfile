#syntax=docker/dockerfile:1.4
FROM public.ecr.aws/docker/library/python@sha256:d57ec66c94b9497b9f3c66f6cdddc1e4e0bad4c584397e0b57a721baef0e6fdc

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install procps && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt ./requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Set most of the environment variables from Terraform backend deployment outputs
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

# CLIENT_SECRET look in AWS Console
ENV CLIENT_SECRET='<CLIENT_SECRET>'

# Replace APP_URI with the Amazon CloudFront output from Terraform frontend, then deploy Terraform frontend again
ENV APP_URI='http://localhost:8501'
EXPOSE 8501
COPY . .
RUN chmod a+x /app/healthcheck.sh

USER nobody
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "/app/healthcheck.sh" ]
ENTRYPOINT ["streamlit", "run", "Home.py", "--server.port=8501"]
