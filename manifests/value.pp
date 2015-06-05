# Manage sysctl value
#
# It not only manages the entry within
# /etc/sysctl.conf, but also checks the
# current active version.
#
# Parameters
#
# * value: to set.
# * key Key to set, default: $name
# * target: an alternative target for your sysctl values.
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
