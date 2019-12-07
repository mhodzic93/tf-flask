# tf-flask
Builds and deploys a flask app on AWS using Terraform 

# Requirements
Run the requirements install script to install the required tools on Mac OS:
```
chmod +x requirements.sh
./requirements.sh
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
