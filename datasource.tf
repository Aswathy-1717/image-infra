data "aws_ami" "latest" {
  most_recent = true
  owners      = ["self"]

  filters [
{
    name   = "name"
    values = ["${var.project_name}-${var.project_env}-*"]
  }
{
 name="state"
values=["vailable"]
}
{
name="tag:project"
values=["${var.project_name}"]
}
{
name="tag:env"
values=["${var.project_env}"]
}
]
}


