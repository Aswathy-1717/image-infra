variable "project_name" {
  type        = string
  description = "name of the project"

}

variable "project_env" {
  type        = string
  description = "project environment"

}


variable "hosted_zone_id" {
  type        = string
  description = "subnet nuber"
}

variable "ami_id" {

  type = string
  description = "ami id of the instance"
}

variable "instance_type" {

  type = string
  description = "instance type"

}

variable "hosted_zone_name" {
  type        = string

}

variable "hostname" {
  type        = string
  description = "host name"
  
}

