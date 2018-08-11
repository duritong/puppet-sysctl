# @summary
#   Manage sysctl value in configuration file
#   and runtime.
#
# @example
#   sysctl::value { 'vm.nr_hugepages': value => '1583' }
#
# @param value String or Integer value.
# @param key String with sysctl key to set, defaults to resource name.
# @param target Optional absolute path to configuration file.
#
# @api public
define sysctl::value (
  Variant[String, Integer] $value,
  String $key                        = $name,
  Optional[Sysctl::Unixpath] $target = undef,
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
