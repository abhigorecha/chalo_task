resource "aws_instance" "nginx_ec2" {
    ami = "ami-0cca134ec43cf708f"
    instance_type = "t2.micro"
    key_name = "chalo"
    security_groups = "${aws_security_group.allow_http.id}"
  


provisioner "remote-exec" {
    inline = [
        "sudo amazon-linux-extras install -y nginx1.12",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("./chalo.pem")
        host = self.public_ip
    }

}
}

