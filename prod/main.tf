

provider "aws" {
  region = "us-east-1"
}

module "mynetwork" {
  source        = "../modules/networking"
  my_cidr_block = "10.2.0.0/16"
  subnet_cidr   = "10.2.1.0/24"
  env           = "prod"
}

module "myserver" {
  source      = "../modules/servers"
  num_servers = 3
  server_size = "t2.micro"
  env         = "prod"
  subnet      = module.mynetwork.instance_subnet
  sg          = module.mynetwork.instance_sg

}
