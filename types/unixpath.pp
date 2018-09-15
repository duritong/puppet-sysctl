# From puppetlabs-stdlib but included here since we want
# zero dependencies for this module.
type Sysctl::Unixpath = Pattern[/^\/([^\/\0]+\/*)*$/]
