
variable "vpc_cidr" {
  type = string
  description = "Cidr value for vpc"
}

variable "vpc_tags" {
  type = map(string)
  description = "Tags for vpc"
  default = {
  }
}

variable "public_subnet_details" {
  type = map(object({
    public_subnet_cidr = string
    public_subnet_az   = string
    public_subnet_tags = optional(map(any))
  }))
  description = "Public Subnet details"
  default = {}
}

variable "private_subnet_details" {
  type = map(object({
    private_subnet_cidr = string
    private_subnet_az   = string
    private_subnet_tags = optional(map(any))
  }))
  description = "private subnet details"
  default = {}
}

variable "public_route_table_tags" {
  type = map(any)
  description = "tags for public route table"
  default = {

  }
}

variable "private_route_table_tags" {
  type = map(any)
  description = "tags for private route table"
  default = {

  }
}