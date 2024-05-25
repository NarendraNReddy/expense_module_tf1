module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  #name = "${var.project_name}-${var.environment}-bastion"
  name=local.backend_name
  ami= data.aws_ami.ami_info.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.frontend_sg_id.value]
  subnet_id              = local.private_subnet_id

  tags = merge(
    var.common_tags,
    {
        #Name="${var.project_name}-${var.environment}-bastion"
        Name=local.backend_name
    }
  )
}

module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  #name = "${var.project_name}-${var.environment}-bastion"
  name=local.frontend_name
  ami= data.aws_ami.ami_info.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  subnet_id              = local.public_subnet_id

  tags = merge(
    var.common_tags,
    {
        #Name="${var.project_name}-${var.environment}-bastion"
        Name=local.frontend_name
    }
  )
}


module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  #name = "${var.project_name}-${var.environment}-bastion"
  name=local.ansible_name
  ami= data.aws_ami.ami_info.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.ansible_sg_id.value]
  subnet_id              = local.public_subnet_id
  user_data = file("expense.sh")
  tags = merge(
    var.common_tags,
    {
        #Name="${var.project_name}-${var.environment}-bastion"
        Name=local.ansible_name
    }
  )
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "backend"
      type    = "A"
      ttl     = 1
      records = [
        module.backend.private_ip
      ]
    },
    {
      name    = "frontend"
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.private_ip
      ]
    },
    {
      name    = "" #daws78s.online
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.public_ip
      ]
    },
  ]

}