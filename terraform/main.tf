provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "demo-key"
  public_key = file("path_to_your_public_key")
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami = "ami-02a2af70a66af6dfb"  # Ubuntu Server 20.04 LTS in ap-south-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "AnsibleDemoWeb"
  }

  provisioner "local-exec" {
    command = <<EOT
echo "[aws_targets]
${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=path_to_your_private_key" > ../ansible/aws_inventory.ini
EOT
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
