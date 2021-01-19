resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    "Name"     = var.name
    "PJPrefix" = var.pj_prefix
  }
}

resource "aws_route_table_association" "rt_association" {
  count          = length(var.association_subnet_ids)
  subnet_id      = element(var.association_subnet_ids, count.index)
  route_table_id = aws_route_table.rt.id
}
