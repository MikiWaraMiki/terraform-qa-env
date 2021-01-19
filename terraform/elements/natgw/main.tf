resource "aws_nat_gateway" "ngw" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id

  tags = {
    "Name"     = var.name
    "PJPrefix" = var.pj_prefix
  }
}
