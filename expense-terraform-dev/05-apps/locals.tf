locals {
  private_subnet_id = element(split(",", data.aws_ssm_parameter.private_subnet_ids.value), 0)
  backend_name="${var.project_name}-${var.environment}-backend"
  frontend_name="${var.project_name}-${var.environment}-frontend"
  public_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
  ansible_name="${var.project_name}-${var.environment}-ansible"
  #ansible_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
}