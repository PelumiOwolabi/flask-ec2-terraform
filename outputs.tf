output "ec2_public_ip" {
  value = aws_instance.terraform-flask.public_ip
}
