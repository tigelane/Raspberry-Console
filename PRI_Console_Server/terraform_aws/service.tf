# AWS Provider

provider "aws" {
    region = "us-west-2"

    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
}

resource "random_id" "server_name" {
    byte_length = 4
    keepers {
        aws_ami = "${var.aws_ami}"
    }
}

resource "aws_instance" "web" {
    ami = "${var.aws_ami}"
    instance_type = "${var.instance_type}"

    vpc_security_group_ids = ["${var.aws_vpc_security_group_ids}"]
    key_name = "${var.aws_key_name}"

    tags {
        # Name = "${var.aws_ami}-${random_string.password.result}"
        Name = "ubuntu-X-${random_id.server_name.hex}"
    }
}
