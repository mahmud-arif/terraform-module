provider "aws" {}



resource "aws_vpc" "myapp-vpc" {
  cidr_blocks=var.vpc_cidr_blocks
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_blocks = var.subnet_cidr_blocks
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id

}


module "myapp-server" {
   source = "./modules/webserver"
   vpc_id = aws_vpc.myapp-vpc.id
   my_ip = var.my_ip
   image_name = var.image_name
   env_prefix = var.env_prefix
   avail_zone = var.avail_zone
   instance_type = var.instance_type
   public_key_location =
   subnet_id = module.mayapp-subnet.subnet.id
}


