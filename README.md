# CloudLabs
Terraform files to deploy and replicate vulnerable scenarios in cloud.

For Azure the only requirement is an Azure Account with a Subscription and permissions to manage resources!
For AWS the only requirement is an Account with AdministratorAccess Policy attached!

To run the lab go into the folder with the lab you want to run and run the commands:

- terraform init
- terraform plan 
- terraform apply 


Azure labs:

* az vault
> this scenario will create 2 Azure AD Groups (readers - contributor) with a single user for each one, will also create a Vault and assign contributor permissions to the contributors group. Will also create a recourse group for all those.




# To-do 
- add information about the aws/iam lab
- add information about the aws/vpc
