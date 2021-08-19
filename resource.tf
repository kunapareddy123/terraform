resource "aws_instance" "Ansible" {
    ami= "ami-090717c950a5c34d3"
    instance_type= "t2.micro"
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

    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
    }
  
}
