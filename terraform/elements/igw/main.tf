resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags = {
    "Name"     = "igw-${var.pj_prefix}"
    "PJPrefix" = var.pj_prefix
  }
}
