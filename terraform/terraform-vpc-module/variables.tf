# Common variables
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

#vpc variables
variable "vpc_cidr_block" {
  type = string
}

variable "vpc_dns_hostnames" {
  type    = bool
  default = true
}

variable "vpc_tags" {
  type    = map(any)
  default = {}
}

# Internet GateWay variables
variable "igw_tags" {
  type    = map(any)
  default = {}
}

# Select Availability zones
variable "select_azs" {
  type    = list(number)
  default = [0, 1]

  validation {
    condition     = length(distinct(var.select_azs)) == 2 && min(var.select_azs...) >= 0 && max(var.select_azs...) < 6
    error_message = "selected_azs value must be a list of numbers with 2 distinct elements and elements value should be anything from the list=[0,1,2,3,4,5]."
  }
}

#All subnet's cidrs
variable "subnet_cidrs" {
  type = list(list(string))
  default = [
    ["10.0.11.0/24", "10.0.12.0/24"],
    ["10.0.21.0/24", "10.0.22.0/24"]
  ]

  validation {
    condition     = length(var.subnet_cidrs[0]) == 2 && length(var.subnet_cidrs[1]) == 2
    error_message = "subnet_cidrs value must be list of 2 lists, each list should contain 2 cidrs. All values should be distinct."
  }
}

#subnets vars
variable "public_subnet_tags" {
  type    = map(any)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(any)
  default = {}
}

# Elastic IP vars
variable "eip_tags" {
  type    = map(any)
  default = {}
}

# NAT vars
variable "nat_tags" {
  type    = map(any)
  default = {}
}

# Route table vars
variable "public_route_table_tags" {
  type    = map(any)
  default = {}
}

variable "private_route_table_tags" {
  type    = map(any)
  default = {}
}