resource "aws_eip" "eip" {
  vpc = true
  tags = {
    "Name"     = var.name
    "PJPrefix" = var.pj_prefix
  }
}
