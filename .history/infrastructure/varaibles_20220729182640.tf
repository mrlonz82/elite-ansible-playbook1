variable "elite_general_network" {
  type    = string
  default = "elitegeneralnetwork"
}

variable "location" {
  type    = string
  default = "EASTUS2"
}

variable "elite_devnsg" {
  type    = string
  default = "elite_devnsg"
}

variable "elitedev_vnet" {
  type    = string
  default = "elitedev_vnet"
}

variable "address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "elite_rtb" {
  type    = string
  default = "elite_rtb"
}

variable "database_subnet" {
  type    = string
  default = "database_subnet"
}

variable "application_subnet" {
  type    = string
  default = "application_subnet"
}


variable "address_prefixes_database" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "address_prefixes_application" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "source_address_prefix" {
  type    = string
  default = "70.114.65.185/32"
}

variable "destination_address_prefix" {
  type    = string
  default = "VirtualNetwork"
}

variable "source_address_prefix_appgw" {
  type    = string
  default = "GatewayManager"
}

variable "destination_address_prefix_appgw" {
  type    = string
  default = "*"
}