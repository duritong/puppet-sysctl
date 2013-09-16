define sysctl::value (
  $value,
  $key = $name
) {

  $array = split($value,'[\s\t]')
  $val1 = inline_template("<%= @array.delete_if(&:empty?).flatten.join(\"\t\") %>")

  sysctl { $key :
    val => $val1,
  }

  $command = $::kernel ? {
    openbsd => shellquote(
      'sysctl',
      "${key}=${val1}"
    ),
    default => shellquote(
      'sysctl',
      '-w',
      "${key}=${val1}"
    ),
  }

  $current_value = shellquote(
    'sysctl',
    '-n',
    $key
  )

  $shellquoted_value = shellquote($val1)
  $unless = "[ \"\$(${current_value})\" = ${shellquoted_value} ]"

  exec { "exec_sysctl_${key}" :
      command => $command,
      unless  => $unless,
      require => Sysctl[$key],
  }
}
