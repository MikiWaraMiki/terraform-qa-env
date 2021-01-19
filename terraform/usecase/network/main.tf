# Create VPC
module "vpc" {
  source = "../../elements/vpc"

  pj_prefix            = var.pj_prefix
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
}
# Create IGW
module "igw" {
  source    = "../../elements/igw/"
  vpc_id    = module.vpc.id
  pj_prefix = var.pj_prefix
}
# Create Public Subnet
# ALB配置用のサブネット
module "public_subnet" {
  source   = "../../elements/subnet/"
  for_each = var.public_subnet_parameters

  vpc_id            = module.vpc.id
  availability_zone = lookup(each.value, "az")
  cidr_block        = lookup(each.value, "cidr")
  name              = "public-subnet-${var.pj_prefix}-${each.key}"
  pj_prefix         = var.pj_prefix
}

# Create Route Table For Public
# ルートテーブルの作成とサブネットの関連付けまで行う
module "public_subnet_route_table" {
  source = "../../elements/route_table/"

  vpc_id = module.vpc.id
  name   = "rt-public-${var.pj_prefix}"
  # for_eachで作成したので、arrayに変換
  association_subnet_ids = [
    for subnet in module.public_subnet :
    subnet.id
  ]
  pj_prefix = var.pj_prefix
}
# パブリックサブネット用のルートテーブルにルーティング情報を追加
module "routing_info_for_public_route_table" {
  source = "../../elements/routing_info/"

  route_table_id = module.public_subnet_route_table.id
  gateway_id     = module.igw.id
}


# プライベートサブネット
module "private_subnet" {
  source   = "../../elements/subnet"
  for_each = var.private_subnet_parameters

  vpc_id            = module.vpc.id
  availability_zone = lookup(each.value, "az")
  cidr_block        = lookup(each.value, "cidr")
  name              = "private-subnet-${var.pj_prefix}-${each.key}"
  pj_prefix         = var.pj_prefix
}

# Create Private Subnet
# EIP(引数で指定された数)
module "eip_for_private_subnet" {
  source = "../../elements/eip/"
  # public subnetの数だけ作成
  count = var.natgw_counts

  name      = "eip-for-nat-gw-${var.pj_prefix}-${count.index + 1}"
  pj_prefix = var.pj_prefix

  depends_on = [module.igw]
}
# NAT Gateway
# TODO: for_eachに変更できる手段を見つける
module "ngw_for_private_subnet" {
  source = "../../elements/natgw/"
  count  = var.natgw_counts

  // moduleで作成したサブネットはmapなのでarrayに変換した上でindexを指定
  subnet_id = element([
    for subnet in module.public_subnet : subnet.id
  ], count.index)
  eip_id    = module.eip_for_private_subnet[count.index].id
  name      = "ngw-${var.pj_prefix}-${count.index + 1}"
  pj_prefix = var.pj_prefix
}
