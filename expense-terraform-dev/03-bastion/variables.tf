variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
    default = {
        Project="expense"
        environmentnvironment="dev"
        Terraform=true 
    }
  
}
