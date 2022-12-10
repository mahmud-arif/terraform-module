output "instance" {
  value = aws_instance.myapp-server.instance.public_ip 
}