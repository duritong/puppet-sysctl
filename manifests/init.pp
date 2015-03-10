# common things for sysctl
class sysctl {
  file { '/etc/sysctl.conf':
    ensure => 'present',
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }
}
