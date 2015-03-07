#
# Author: Emilien Macchi <emilien@redhat.com>
#
# == Class: sysctl::values
#
# Class wrapper to create sysctl values with Hiera.
#
# === Parameters:
#
# [*args*] A sysctl config hash
#   Required.
#
# [*defaults*] A config hash
#   Optional. Defaults to a empty hash
#
class sysctl::values($args, $defaults = {}) {
  create_resources(sysctl::value, $args, $defaults)
}
