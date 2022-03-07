

provider "aws" {
  region = "us-east-1"
}

module "mynetwork" {
  source        = "../modules/networking"
  my_cidr_block = "10.0.0.0/16"
  subnet_cidr   = "10.0.1.0/24"
  env           = "dev"
}

module "myserver" {
  source      = "../modules/servers"
  num_servers = 3
  server_size = "t2.micro"
  subnet      = module.mynetwork.instance_subnet
  sg          = module.mynetwork.instance_sg
  env         = "dev"

}
