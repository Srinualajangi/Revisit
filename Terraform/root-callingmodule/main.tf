module "calling_source_moadule_from_here" {
    source = "../Source-module/"
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    Name = "Mywebserver"
}