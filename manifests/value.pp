define sysctl::value (
  $value,
  $key = 'name',
) {

  $real_key = $key ? {
    'name'  => $name,
    default => $key,
  }

  sysctl { $real_key :
    val    => $value,
    before => Exec["exec_sysctl_${real_key}"],
  }

  $command = $::kernel ? {
    openbsd => "sysctl ${real_key}=\"${value}\"",
    default => "sysctl -w ${real_key}=\"${value}\"",
  }

  $unless = $::kernel ? {
    openbsd => "sysctl ${real_key} | grep -q '=${value}\$'",
    default => "sysctl ${real_key} | grep -q ' = ${value}\$'",
  }

  exec { "exec_sysctl_${real_key}" :
      command => $command,
      unless  => $unless,
      require => Sysctl[$real_key],
  }
}
