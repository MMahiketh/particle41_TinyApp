# Terraform Module for Customised VPC in AWS

This module is going to create below resources.

* VPC
* Internet Gateway
* 2 Public subnets
* 2 Private subnets
* Elastic IP
* NAT Gateway
* Public Route table
* Private Route table
* Routes
* Route table associations with subnets


## Inputs

* `project` *string* (Mandatory) : User must provide their project name.
* `environment` *string* (Mandatory) : User must provide the envirmonment(PROD, DEV, QA).
* `vpc_cidr_block` *string* (Mandatory) : User must provide CIDR for VPC.
* `vpc_dns_hostnames` *boolean* (Optional) : Set false if you donot need "DNS hostnames" in our VPC. By default it is set to true.
* `vpc_tags` *map(string)* (Optional) : User can supply tags to attach to created vpc. By default it is empty.
* `igw_tags` *map(string)* (Optional) : User can supply tags to attach to created Internet Gateway. By default it is empty.
* `select_azs` *list(number)* (Optional) : User can choose Availability Zones to create subnets. By default it is set to [ 0, 1 ]. You can choose values form 0 to 5. It should be list of 2 distinct elements
* `subnet_cidrs` *list(list(string))* (Optional) : User can supply CIDRs for all subnets created.  
    Default values are:

        [
            ["10.0.11.0/24", "10.0.12.0/24"],   --> AZ1 subnet CIDRs
            ["10.0.21.0/24", "10.0.22.0/24"]    --> AZ2 subnet CIDRs
        ]          ^               ^
                   |               |
            -------------   --------------
            public-subnet   private-subnet
* `public_subnet_tags` *map(string)* (Optional) : User can supply tags to attach to created Public subnet. By default it is empty.
* `private_subnet_tags` *map(string)* (Optional) : User can supply tags to attach to created Private subnet. By default it is empty.
* `eip_tags` *map(string)* (Optional) : User can supply tags to attach to allocated Elastic IP. By default it is empty.
* `nat_tags` *map(string)* (Optional) : User can supply tags to attach to created NAT. By default it is empty.
* `public_route_table_tags` *map(string)* (Optional) : User can supply tags to attach to created Public route table. By default it is empty.
* `private_route_table_tags` *map(string)* (Optional) : User can supply tags to attach to created Private route table. By default it is empty.

## Outputs

* `vpc_id` : ID of the created VPC.
* `igw_id` : ID of the created Internet Gateway.
* `all_azs_info` : Info about all Availability Zones in the region.
* `selected_azs` : List of Availability Zones that are selected.
* `az1_subnet_cidrs` : List of Public, Private and Database subnet CIDRs in AZ1.
* `az2_subnet_cidrs` : List of Public, Private and Database subnet CIDRs in AZ2.
* `public_subnet_ids` : List of Public subnet IDs.
* `private_subnet_ids` : List of Private subnet IDs.
* `eip_ip_address` : IP address Allocated by Elastic IP(Public IP address).
* `nat_id` : ID of the created NAT.
* `public_route_table_id` : ID of the created Public route table.
* `private_route_table_id` : ID of the created Private route table.
* `public_route_id` :ID of the created Public route.
* `private_route_id` :ID of the created Private route.
* `public_route_association_id` : ID of the association of Public route table to Public subnet
* `private_route_association_id` : ID of the association of private route table to private subnet
* `database_route_association_id` : ID of the association of database route table to database subnet