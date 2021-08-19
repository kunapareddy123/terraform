resource "aws_instance" "Ansible" {
    ami= "ami-0686851c4e7b1a8e1"
    instance_type= "t2.medium"
    key_name= "JenkinsDemo"
    security_groups= ["launch-wizard-1"]
    tags = {
        "Name" = "Ansible"
    }

    connection {
        type= "ssh"
        user= "centos"
        host= "${aws_instance.Ansible.public_ip}"
        private_key= "${file("./files/JenkinsDemo.pem")}"
             
    }

    provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
    }

    provisioner "file" {
    source      = "./hosts"
    destination = "/tmp/hosts"
    }
    provisioner "file" {
    source      = "./deployment.yml"
    destination = "/tmp/deployment.yml"
    }
    provisioner "file" {
    source      = "./java.sh"
    destination = "/tmp/java.sh"
    }

    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/java.sh",
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
    }
  
}
