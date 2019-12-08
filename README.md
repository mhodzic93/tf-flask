# tf-flask
Builds and deploys a flask app on AWS using Terraform 

# Requirements
Mac users will need to install brew prior to running the requirements.sh script using the following command:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install the aws cli by running the following command:
```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```

Run the requirements install script to install the required tools on Mac OS:
```
chmod +x requirements.sh
./requirements.sh
```

Start Docker by navigating to Applications and selecting the `Docker` application.

Run the ecr login script to authenticate with ecr:
```
./scripts/ecr_login.sh <aws_profile>
```

# Building Docker images
##### Flask
To build the flask docker image, run the following commands:
```
./docker_images/flask/flask.sh
```
# Running Terraform
Replace `<path_to_variables_file>` with the path to the manifest.tfvars file.

Replace `<aws_profile>` with the aws profile name.

Run the Terraform plan script to get a plan of the infrastructure that will be deployed:
```
./plan.sh <path_to_variables_file> <aws_profile>
```

Once you have ran the Terraform plan script, run the Terraform deploy script to deploy the infrastructure:
```
./deploy.sh <aws_profile>
```

# Destroying Terraform
Once you have no further need for the infrastructure, run the Terraform deploy script to destroy the deployed infrastructure:
```
./destroy.sh <path_to_variables_file> <aws_profile>
```
