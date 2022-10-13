resource "aws_vpc""aj"{
 cidr_block          ="10.0.0.0/16"
 instance_tenancy    ="default"
 enable_dns_support  ="true"
 enable_dns_hostnames  ="true"
 tags={
  Name="aj"
 }
}

resource "aws_subnet""aj-public-1"{
 vpc_id    =aws_vpc.aj.id
 cidr_block="10.0.1.0/24"
 map_public_ip_on_launch="true"
 availability_zone  ="ap-south-1a"

 tags={
 Name="aj-public-1"
 }
}

resource"aws_subnet""aj-public-2"{
 vpc_id                  =aws_vpc.aj.id
 cidr_block              ="10.0.2.0/24"
 map_public_ip_on_launch ="true"
 availability_zone       ="ap-south-1b"

 tags={
 Name="aj-public-2"
  }
}

resource"aws_internet_gateway""aj-gw"{
  vpc_id    =aws_vpc.aj.id

    
   tags={
    name="aj"
  }
 }

 resource "aws_route_table" "aj-public-1"{
      vpc_id    =aws_vpc.aj.id
      route{
         cidr_block="0.0.0.0/0"
         gateway_id=aws_internet_gateway.aj-gw.id
        }

        tags={
          name="aj-public-1"
        }
    }    
      resource"aws_route_table_association""aj-public_1-a"{
      subnet_id=aws_subnet.aj-public-1.id
      route_table_id=aws_route_table.aj-public-1.id
      }
     
      resource"aws_route_table_association""aj-public_2-a"{
      subnet_id=aws_subnet.aj-public-2.id
      route_table_id=aws_route_table.aj-public-1.id
      } 

resource"aws_instance""public_inst_1"{
         ami         ="ami-062df10d14676e201"
         instance_type="t2.micro"
         subnet_id= "${aws_subnet.aj-public-1.id}"
         key_name="k8s master"
         tags={
           name="public_inst_1"
          }
         }

resource"aws_instance""public_inst_2"{
         ami         ="ami-062df10d14676e201"
         instance_type="t2.micro"
         subnet_id= "${aws_subnet.aj-public-2.id}"
         key_name="k8s master"
         tags={
           name="public_inst_2"
          }
         }
 
