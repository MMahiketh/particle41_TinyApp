# Terraform Module to Create Security Group in AWS

  This module is going to create a security group in spcified vpc.

## Inputs

* `project` *string* (Mandatory) : User must provide their project name.
* `environment` *string* (Mandatory) : User must provide the envirmonment(PROD, DEV, QA).
* `instance` *string* (Mandatory) : User must provide the security group instance name.
* `sg_tags` map(string) (Optional) : User can supply tags to attach to created security group. By default it is empty.

## Outputs

* `id` : ID of the created security group.