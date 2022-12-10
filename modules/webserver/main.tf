resource "aws_security_group" "mayapp-sg" {
  name = "myapp-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocal = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
      from_port = 8080
      to_port = 8080
      protocal = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }


  egress {
     from_port = 0
      to_port = 0
      protocal = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      prefix_list_ids = []
  }
   
  tags = {
    Name: "${env_prefix}-sg"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = <my key name>
  public_key = file(var.public_key_location) 
}

data "aws_ami" "latest-amazon-machine-linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name: "name"
    values: [var.image_name ]
  }
  fileter {
    name: "vitualization-type"
    values: ["hvm"]
  }
}



resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.latest-amazon-machine-linux.id
  instance_type = var.instance_type

  subnet_id = var.subnet_id
  security_group_ids = [aws_security_group.mayapp-sg.id]

  assosciate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh"  )

  tags = {
    Name: "${env_prefix}-server"
  }


}