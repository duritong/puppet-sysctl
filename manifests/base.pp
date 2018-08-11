# @summary
#   The base class that manages the creation of
#   the default sysctl configuration file.
#
# @api private
class sysctl::base {

  # we dont have puppetlabs-stdlib so we cannot use
  # assert_private() function here.
  if $module_name != $caller_module_name {
    fail('sysctl::base is a private class')
  }

  file { '/etc/sysctl.conf':
    ensure => 'present',
    owner  => 'root',
    group  => '0',
    mode   => '0644',
  }
}
