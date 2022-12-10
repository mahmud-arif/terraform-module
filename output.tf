output "aws_ami_id" {
  value = module.myapp-server.data.aws_ami.latest-amazon-machine-linux.id
}

