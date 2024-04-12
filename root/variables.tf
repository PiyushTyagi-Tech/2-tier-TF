variable "region" {
    description = "This our aws region variable"
    #default = "us-east-2"
      
}
variable "project_name" {
    description = "This is the project name variable"
    #default = "two-tier-app"
  
}
variable "cidr" {
    #default = "10.0.0.0/16"
}
variable "pub_sub_2a" {
    #default = "10.0.0.0/20"
}
variable "pri_sub_2a" {
    #default = "10.0.16.0/20"
}
variable "pub_sub_2b" {
    #default = "10.0.128.0/20"
}
variable "pri_sub_2b" {
    #default = "10.0.144.0/20"
}

variable "my_ip" {}
