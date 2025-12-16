# Common variables
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "sg_tags" {
  type    = map(any)
  default = {}
}