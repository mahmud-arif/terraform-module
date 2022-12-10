resource "aws-subnet" "myapp-subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_blocks
  tags = {
    Name: "${var.env_prefix}-subnet-1"
  }
}

resource "aws_route_table" "myapp-route-table" {
  vpc_id = var.vpc_id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internent_gateway.myapp-igw.id

      tags = {
        Name: "${var.env_prefix}-rtb"
      }
    }
    
}


resource "aws_internent_gateway" "mayapp-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name: "${var.env_prefix}-igw"
  }
}

resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.mayapp-route-table.id
}