resource "aws_key_pair" "auth_key" {
  key_name   = "${var.project_name}-${var.project_env}"
  public_key = file("mykey.pub")
  tags = {
    Name    = "${var.project_name}-${var.project_env}"
    project = var.project_name
    env     = var.project_env
  
  }
}


resource "aws_security_group" "frontend" {
  name        = "${var.project_name}-${var.project_env}-frontend"
  description = "${var.project_name}-${var.project_env}-frontend"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.project_env}-frontend"
    Project     = var.project_name
    Environment = var.project_env
  }
}






resource "aws_instance" "frontend" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.auth_key.key_name
  user_data     = file("setup.sh")
  vpc_security_group_ids = [
    aws_security_group.frontend.id
  ]

  tags = {
    Name    = "${var.project_name}-${var.project_env}-frontend"
    project = var.project_name
    env     = var.project_env
  
  }

}

resource "aws_route53_record" "frontend" {
  zone_id = var.hosted_zone_id
  name    = "${var.host_name}.${var.hosted_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.frontend.public_ip]
}
