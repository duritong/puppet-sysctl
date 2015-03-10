# common things for sysctl
class sysctl::base {

  warning('This class will be deprecated in a future release, you should use ::sysctl instead.')

  file { '/etc/sysctl.conf':
    ensure => 'present',
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }
}
