variable "project" {
  type    = string
  default = "particle41"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type = list(list(string))
  default = [
    ["10.0.1.0/24", "10.0.11.0/24"],
    ["10.0.2.0/24", "10.0.12.0/24"]
  ]
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "http_port" {
  type    = number
  default = 80
}

variable "nodeport_start" {
  type    = number
  default = 30000
}

variable "nodeport_end" {
  type    = number
  default = 32767
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/AhjY1D0LzhkAUZFgmtIJFgFGBE0/3m+TP/o+OLPVnqWhlnVhVDJISs5w4BVRgfMYkuY/uH5rgLJf2nkXJm0Toz0tT9S3rteM8c19JbCD8XDe6hIAb2fOLEkzSBD3JSz0byTfaj1EtCdqkFkvUgwKrFGNLbKyPsqjeppTFZmUwxBB9pV+FebyNU9M6raOLtTcnh7ogtAtIWmu3ToYsiC4374OdjrJtpWS+IRTNhqgc9w2zvOOXgurPf74+cnyjpE75P4+GOevVL4FKQDSF6L9akCF/sfoLjhsgWm2xbwL2ZNdYbZjnGV57qKTCUG49HnxKF8wDHqlenQxizJ1bOSCnbK8/QTH6mThV82oaSoYCkbTPjsp0qeS9QeRwNmgn0vX8p+qG5r/Brs0LPhAXwpITkddYLkA+a3yPJcv7/l7Fp05edpNuAtRtBsbed7HLKkb6pWHqEudBNJfI3qpbTEvXn3n3ndN6kII3+rg5c/IWJLTVF9pINy5U/mcxJRQ36M= babbu@pop-os"
}