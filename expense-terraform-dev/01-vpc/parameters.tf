resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.Project_name}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id #This is coming from vpc module . Capturing through SSM parameter store.
#   output "vpc_id"{  This is exposed from output.tf from VPC module.
#   value=aws_vpc.main.id }

}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.Project_name}/${var.environment}/public_subnet_ids"
  type  = "String"
  value = join(",",module.vpc.public_subnet_ids) #This is coming from vpc module . Capturing through SSM parameter store.
#   output "vpc_id"{  This is exposed from output.tf from VPC module.
#   value=aws_vpc.main.id }

}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.Project_name}/${var.environment}/private_subnet_ids"
  type  = "String"
  value = join(",",module.vpc.private_subnet_ids) #This is coming from vpc module . Capturing through SSM parameter store.
#   output "vpc_id"{  This is exposed from output.tf from VPC module.
#   value=aws_vpc.main.id }

}

# resource "aws_ssm_parameter" "db_subnet_group_name" {
#   name  = "/${var.Project_name}/${var.environment}/db_subnet_group_name"
#   type  = "String"
#   value = module.vpc.database_subnet_group_name
# }

