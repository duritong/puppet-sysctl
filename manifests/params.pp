# default params for sysctl
#
# Use this to set default values that are used by this module.
#
#  * exec_path: The path parameter for your exec. Can be handy if you
#               don't want to set a global exec default.
# DEPRECATED as the exec paths are configured in the provider
#
class sysctl::params(
  $exec_path = undef,
) {
  file { '/etc/sysctl.conf':
    ensure      => 'present',
    owner       => 'root',
    group       => '0',
    mode        => '0644',
  }

  if $exec_path {
    notify{"sysctl::params::exec_path is deprecated and isn't required anymore":}
  }
}
