# Example for deploying a VM on straight up ESXi w/t vCenter
variable "vsphere_user" {
  default = "root" 
}
variable "vsphere_password" {
  default = "!QAZ2wsx"
}
variable "vsphere_server" {
  default = "192.168.2.187"
}
variable "vsphere_datacenter" {
  default = "ha-datacenter"
}

variable "allow_unverified_ssl" {
  default = "true"
}

variable "vm_network_portgroup" {
  default = "home"
}
variable "vm_template" {
  default = "rtr"
}

variable "psc_name" {
  default = "psc3"
}