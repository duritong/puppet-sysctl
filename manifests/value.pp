# @summary
#   Manage sysctl value in configuration file
#   and runtime.
#
# @example
#   sysctl::value { 'vm.nr_hugepages': value => '1583' }
#
# @param value The string or integer value.
# @param key The sysctl key to set, defaults to resource name.
# @param target Optional configuration file target.
define sysctl::value (
  $value,
  $key    = $name,
  $target = undef,
) {
  require sysctl::base
  $val1 = inline_template("<%= String(@value).split(/[\s\t]/).reject(&:empty?).flatten.join(\"\t\") %>")

  sysctl { $key :
    val    => $val1,
    target => $target,
    before => Sysctl_runtime[$key],
  }
  sysctl_runtime { $key:
    val => $val1,
  }
}
