# config.tfvarsから読み取る
variable "region" {
  default = ""
}
variable "profile" {
  default = ""
}

variable "pj_prefix" {
  default = "sample-qa-create"
}
# Network周りのパラメータ
variable "vpc_cidr_block" {
  default = "172.17.0.0/16"
}
variable "enable_dns_support" {
  default = true
}
variable "enable_dns_hostnames" {
  default = true
}
variable "instance_tenancy" {
  default = "default"
}
variable "public_subnet_parameters" {
  default = {
    "1a" : {
      az   = "ap-northeast-1a"
      cidr = "172.17.0.0/24"
    },
    "1c" : {
      az   = "ap-northeast-1c"
      cidr = "172.17.1.0/24"
    }
  }
}
variable "private_subnet_parameters" {
  default = {
    "1a" : {
      az   = "ap-northeast-1a"
      cidr = "172.17.2.0/24"
    },
    "1c" : {
      az   = "ap-northeast-1c"
      cidr = "172.17.3.0/24"
    }
  }
}
// NAT GWを設置する数
// nullの場合は、public subnetが設置されたAZ全てに配置(マルチAZの場合は2つ)
variable "natgw_counts" {
  default = 1
}
