# tf-flask
Builds and deploys a flask and node app on AWS using Terraform.

# Requirements
1. Create an AWS account.

2. Create an IAM user, assign the user `Programmatic access`, attach the `AdministratorAccess` IAM policy to the user, and 
save the access key ID and secret access key ID.

3. Install the aws cli by running the following command:
```
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```

4. Configure your aws profile locally by running the below command and filling out the
parameters using the keys saved from step 2:
`aws configure`

5. Import a key pair to the EC2 service in the region you will be deploying in or create
a key pair, if you don't already have an ssh key.

6. Update the following variables in the manifest.tfvars file:
```
region - set this to the region you are deploying in
stack_name - set this to the stack name of your choosing
key_name - set this to the name of the key pair you generated in step 5
vpc_id - set this to the default vpc id in region you are deploying in
public_subnet - set this to one of the default subnet id's that exist in the region you are deploying in 
account_id - set this to your AWS account id
```

7. Mac users will need to install brew prior to running the requirements.sh script using the following command:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

8. Run the requirements install script to install the required tools on Mac OS:
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

# Building Docker images
To build the docker images, run the following command:
```
./scripts/docker_build.sh <path_to_variables_file> <aws_profile>
```

# Viewing the solution
To view the solution, follow the steps below:

1. Identify the Public DNS name of the ecs cluster that is running by navigating
to the AWS EC2 service, selecting instances, selecting the instance and finding the Public DNS(IPv4) description
(ex. `ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com`)

2. Open a web browser (Mozilla Firefox is preferred. Google Chrome will block requests
due to the SSL cert being invalid.)

3. Navigate to the Public DNS name identified in step 1 using http. 
(ex. `http://ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com`)
You will be redirected to https and will need to select `Advanced`, and then select `Accept the Risk and Continue`.
Nginx will redirect the request to the flask container serving the flask api.

4. To access the node container serving the node calculator, navigate to any of the below paths in order to test 
the calculator (replace [number] with any number to perform the calculation):
```
http://ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com/add/[number]/[number]
http://ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com/subtract/[number]/[number]
http://ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com/multiply/[number]/[number]
http://ec2-<IP_ADDRESS>.<REGION>.compute.amazonaws.com/divide/[number]/[number]
```

# Destroying Terraform
Once you have no further need for the infrastructure, run the Terraform destroy script to destroy the deployed infrastructure:
```
./destroy.sh <path_to_variables_file> <aws_profile>
```

# Improvements
1. Build own VPC
2. Make infrastructure highly available by including a load balancer, running multiple
services in multiple AZ's.
3. Create single script to run all commands.
4. Tag docker images with a unique ID.
5. Use ansible to generate SSL certs, build ngingx config files.
