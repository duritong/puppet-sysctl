# @summary
#   Manage multiple sysctl values.
#
# @example
#   $args = {
#     'net.ipv4.ip_forward'          => { value => 1 },
#     'net.ipv6.conf.all.forwarding' => { value => 1 },
#   }
#   sysctl::values
#
# @param args Hash with sysctl::value resources.
# @param defaults Hash with sysctl::value resource default values.
class sysctl::values($args, $defaults = {}) {
  create_resources(sysctl::value, $args, $defaults)
}
