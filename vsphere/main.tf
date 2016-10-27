# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  client_debug = "true"
  client_debug_path = "H:\\temp\\"
}

resource "vsphere_file" "psc-01-vmdk-01" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk1.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk1.vmdk"
  
}

resource "vsphere_file" "psc-01-vmdk-02" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk2.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk2.vmdk"
    #depends_on = []
}

resource "vsphere_file" "psc-01-vmdk-03" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk3.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk3.vmdk"
    depends_on = ["vsphere_file.psc-01-vmdk-02","vsphere_file.psc-01-vmdk-01"]
}

resource "vsphere_file" "psc-01-vmdk-04" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk4.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk4.vmdk"
    depends_on = ["vsphere_file.psc-01-vmdk-03"]
}

resource "vsphere_file" "psc-01-vmdk-05" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk5.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk5.vmdk"
    depends_on = ["vsphere_file.psc-01-vmdk-04"]
}

resource "vsphere_file" "psc-01-vmdk-06" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk6.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk6.vmdk"
    depends_on = ["vsphere_file.psc-01-vmdk-05"]
}

resource "vsphere_file" "psc-01-vmdk-07" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk7.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk7.vmdk"
    depends_on = ["vsphere_file.psc-01-vmdk-06"]
}

resource "vsphere_file" "psc-01-vmdk-08" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk8.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk8.vmdk"
      depends_on = ["vsphere_file.psc-01-vmdk-07"]
 
}

resource "vsphere_file" "psc-01-vmdk-09" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk9.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk9.vmdk"
      depends_on = ["vsphere_file.psc-01-vmdk-08"]
}

resource "vsphere_file" "psc-01-vmdk-10" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk10.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk10.vmdk"
      depends_on = ["vsphere_file.psc-01-vmdk-09"]
}
resource "vsphere_file" "psc-01-vmdk-11" {
  datacenter = "ha-datacenter" 
  datastore = "host-04-lds-01"
  create_directories = "true"
  source_file = "c:\\temp\\vmx\\vmware-vcsa-disk11.vmdk"
  destination_file = "/${var.psc_name}_src/vmware-vcsa-disk11.vmdk"
      depends_on = ["vsphere_file.psc-01-vmdk-10"]
}

resource "vsphere_virtual_machine" "psc" {
      depends_on = ["vsphere_file.psc-01-vmdk-11"]
  name = "${var.psc_name}"
  vcpu = 2
  memory = 4096
  network_interface {
    label = "${var.vm_network_portgroup}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
    vmdk = "${vsphere_file.psc-01-vmdk-01.destination_file}"
    #bootable = "true"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
    vmdk = "${vsphere_file.psc-01-vmdk-02.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-03.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-04.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-05.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-06.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-07.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-08.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-09.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-10.destination_file}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
        vmdk = "${vsphere_file.psc-01-vmdk-11.destination_file}"
  }
}

/*
resource "vsphere_ova" "psc" {
  json_file = "/home/fred.json"
  ova_file = "/home/fred.ova"
}
*/
/*
resource "vsphere_virtual_disk"  "os_disk" {
  size = 40
  vmdk_path = "fre/vm01-disk-02.vmdk"
  datastore = "host-04-lds-01"
  type = "thin"
}
*/


/*
resource "vsphere_virtual_machine" "vm01" {
  name = "vm01"
  vcpu = 2
  memory = 4096
  network_interface {
    label = "${var.vm_network_portgroup}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
    size = 100
    name = "/fred1-1.vmdk"
    type = "thin"
    bootable = "true"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-01"
    size = 50
    name = "/fred1-2.vmdk"
    type = "thin"
  }
}
*/

/*
resource "vsphere_virtual_machine" "vm02" {
  name = "vm02"
  vcpu = 2
  memory = 8192
  network_interface {
    label = "${var.vm_network_portgroup}"
  }
  disk {
    #template = "${var.vm_template}"
    datastore = "host-04-lds-02"
    size = 100
   # name = "/fred2-1.vmdk"
    type = "thin"
    bootable = "true"
  }
}
*/
/*
resource "vsphere_virtual_machine" "vm03" {
  name = "fre"
  vcpu = 4
  memory = 8192
  network_interface {
    label = "${var.vm_network_portgroup}"
  }
  disk {
    datastore = "host-04-lds-01"
    #vmdk = "vm01-disk-02.vmdk"
    vmdk = "fre/vm01-disk-02.vmdk"
  }
}
*/


