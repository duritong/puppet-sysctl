# @summary
#   The base class that manages the creation of
#   the default sysctl configuration file.
#
# @api private
class sysctl::base {
  file { '/etc/sysctl.conf':
    ensure => 'present',
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }
}
