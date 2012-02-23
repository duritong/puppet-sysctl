define sysctl::value (
  $key = 'name',
  $value
) {

  $real_key = $key ? {
    'name' => $name,
    default => $key
  }
  sysctl {
    $real_key :
      val => $value,
      before => Exec["exec_sysctl_${real_key}"],
  }
  exec {
    "exec_sysctl_${real_key}" :
      command => $::kernel ? {
        openbsd => "sysctl ${real_key}=\"${value}\"",
        default => "sysctl -w ${real_key}=\"${value}\""
      },
      unless => $::kernel ? {
        openbsd => "sysctl ${real_key} | grep -q '=${value}\$'",
        default => "sysctl ${real_key} | grep -q ' = ${value}\$'"
      },
      require => Sysctl[$real_key],
  }
}
