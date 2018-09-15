sysctl::value { 'net.ipv4.ip_forward':
  value => 1,
}

sysctl::value { 'net.ipv4.ip_forward':
  value => '1',
}

sysctl::value { 'net.ipv4.tcp_rmem':
  value => "4096\t131072\t131072",
}

sysctl::value { 'vm.nr_hugepages':
  value  => '1583',
  target => '/etc/sysctl.d/mysysctl.conf',
}

$my_sysctl_settings = {
  'net.ipv4.ip_forward'          => { value => 1 },
  'net.ipv6.conf.all.forwarding' => { value => 1 },
}

create_resources(sysctl::value, $my_sysctl_settings, {})

sysctl::values { 'multiple':
  args => $my_sysctl_settings,
}
