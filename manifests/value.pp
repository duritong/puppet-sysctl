# Manage sysctl value
#
# It not only manages the entry within
# /etc/sysctl.conf, but also checks the
# current active version.
define sysctl::value (
  $value,
  $key    = $name,
  $target = undef,
) {

  $array = split($value,'[\s\t]')
  $val1 = inline_template("<%= @array.reject(&:empty?).flatten.join(\"\t\") %>")

  include sysctl

  sysctl { $key :
    val => $val1,
    notify => Exec['apply_sysctl'],
    target => $target,
  }

}
