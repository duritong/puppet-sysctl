# sysctl/manifests/init.pp - Define sysctl module stuff
# Copyright (C) 2008 admin@immerda.ch
# See LICENSE for the full license granted to you.

#modules_dir { "sysctl": }

class sysctl {

}

define sysctl::set_value(
	$value
){

 	exec { "exec_sysctl_${name}":
 		command => "/sbin/sysctl ${name}=${value}",
 		refreshonly => true,
 	}
 
 	sysctl { $name:
 		val => $value,
 		notify => Exec["exec_sysctl_${name}"],
 	}
}


