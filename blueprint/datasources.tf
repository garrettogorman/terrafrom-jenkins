data "template_file" "public_cidrsubnet" {
  count = "${var.public_subnet_count}"

  template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

  vars {
    vpc_cidr      = "${var.vpc_cidr}"
    current_count = "${count.index*2+1}"
  }
}

data "template_file" "private_cidrsubnet" {
  count = "${var.private_subnet_count}"

  template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

  vars {
    vpc_cidr      = "${var.vpc_cidr}"
    current_count = "${count.index*2}"
  }
}
