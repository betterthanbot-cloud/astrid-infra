data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = "192.168.1.0/24"
  tags = merge(
    local.tags,
    {
      Name = join("-", ["aws-vpc", var.vpc_id])
  })
}

resource "aws_subnet" "this" {
  count             = 3
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 2, count.index)
  vpc_id            = aws_vpc.this.id
  tags = merge(
    local.tags,
    {
      Name = join("-", ["aws-subnet", var.vpc_id, data.aws_availability_zones.available.names[count.index]])
  })

  depends_on = [aws_vpc.this]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    local.tags,
    {
      Name = join("-", ["aws-internet-gateway", var.vpc_id])
  })
}
