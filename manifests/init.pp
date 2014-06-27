class sysctl (
) {

  $sysctl_apply_command = $::kernel ? {
    /i?BSD$/ => shellquote('sysctl','-f','/etc/sysctl.conf'),
    default  => shellquote('sysctl','-p'),
  }

  include sysctl::params

  exec {'apply_sysctl':
    command     => $sysctl_apply_command,
    refreshonly => true,
    path        => $sysctl::params::exec_path,
  }

}
