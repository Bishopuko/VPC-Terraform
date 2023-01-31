
# provider "aws" {
#     access_key = AKIA4KCK4LMKKLGJNPH2
#     secret_key = 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
#     profile = "default"
#     region = "us-east-2"
# }
resource "aws_instance" "test-instance" {
  ami =        "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  key_name = "bishop-KP"
  user_data = "${file("./install.sh")}"
  tags = {
    "Name" : "Test-Instance"
  }
  
}




