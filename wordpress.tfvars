#database_name           = "wordpress_db"   // database name
#db_name           = "wordpress_db"   // database name
#database_user           = "wordpress_user" //database username
shared_credentials_file = "~/.aws"         //Access key and Secret key file location
region                  = "ap-south-1"     //Mumbai region
IsUbuntu                = true             // true for ubuntu,false for linux 2  //boolean type

// avaibility zone and their CIDR
ami	     = "ami-006d3995d3a6b963b"
AZ1          = "ap-south-1a" // for EC2
AZ2          = "ap-south-1b" //for RDS
AZ3          = "ap-south-1c" //for RDS
VPC_cidr     = "10.0.0.0/16"     // VPC CIDR
subnet1_cidr = "10.0.1.0/24"     // Public Subnet for EC2
subnet2_cidr = "10.0.2.0/24"     //public Subnet 
subnet3_cidr = "10.0.3.0/24"     //Private subnet for RDS
subnet4_cidr = "10.0.4.0/24"     //Private subnet for RDS


PUBLIC_KEY_PATH  = "../../mykey-pair.pub" // key name for ec2, make sure it is created before terraform apply
PRIV_KEY_PATH    = "../../mykey-pair"
instance_type    = "t2.micro"    //type of instance
instance_class   = "db.t2.micro" //type of RDS Instance
root_volume_size = 22
keyname = "mykey-pair"
