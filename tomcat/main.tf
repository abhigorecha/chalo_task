resource "aws_instance" "nginx_ec2" {
    ami = "ami-0cca134ec43cf708f"
    instance_type = "t2.micro"
    key_name = "chalo"
    security_groups = "${aws_security_group.allow_http.id}"

    provisioner "file" {
    source      = "./pom.xml"
    destination = "/etc/java-app/"
  }

   provisioner "file" {
    source      = "./app.java"
    destination = "/etc/java-app/"
  }



  

    provisioner "remote-exec" {
    inline = [
        "sudo amazon-linux-extras update",
        "sudo amazon-linux-extras install java-1.8.0-openjdk",
        "java -version",
        "mkdir /etc/tomcat",
        "wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.37/bin/apache-tomcat-9.0.37.tar.gz",
        "tar -xf apache-tomcat-9.0.37.tar.gz -C /etc/tomcat/",
        "chmod +x /etc/tomcat/bin/*.sh",
        "cd apache-tomcat-9.0.37 ",
        "cd bin",
        "chmod +x startup.sh",
        "chmod +x shutdown.sh",
        "./startup.sh",

        "amazon-linux.extras install maven",
        "mvn archetype:generate -DgroupId=com.app.example -DartifactId=java-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false",
        "mvn package",
        "cp /etc/java-app/target/chalo-1.war /etc/tomcat/webapps/",
        "systemctl restart tomcat"

       
    ]

    connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("./chalo.pem")
        host = self.public_ip
    }

}
}


