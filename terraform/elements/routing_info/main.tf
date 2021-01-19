resource "aws_route" "route" {
  route_table_id         = var.route_table_id
  destination_cidr_block = var.destination_cidr_block
  # 引数の値がnullじゃないgatewayをアタッチする
  gateway_id      = var.gateway_id
  nat_gateway_id  = var.nat_gateway_id
  vpc_endpoint_id = var.vpc_endpoint_id

  # timeout5分に設定
  timeouts {
    create = "5m"
  }
}
