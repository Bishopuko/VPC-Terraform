resource "aws_security_group" "sg-1" {
   name = "Security-1"
   description = "Allows TCP and SSH "
   vpc_id = aws_vpc.task.id

   ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["10.0.0.0/16"]
    protocol = "tcp"
   }
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
   }

   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }
   tags = {
    "name" : "allow tls"
   }
}