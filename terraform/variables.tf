#vpc cidr

variable "region" {
    type = string
    default = "us-east-1"
}

variable "livlev2com_vpccidr" {
  type = string
  description = "name of vpc"
  default = "10.79.0.0/16"
}

#vpc azs
variable "livlevi2com_azs" {
  type = list(string)
  description = "list of availability zones"
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

#vpc private subnets
variable "livlevi2com_prv_subnets" {
    type = list(string)
    description = "list of private subnets"
    default = [ "10.79.0.0/19", "10.79.32.0/19", "10.79.64.0/19" ]
}

#vpc public subnets
variable "livlevi2com_pub_subnets" {
    type = list(string)
    description = "list of public subnets"
    default = [ "10.79.128.0/19", "10.79.160.0/19", "10.79.192.0/19" ]  
}