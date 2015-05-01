define pacemaker::resource::filesystem(
  $ensure       = 'present',
  $device       = '',
  $directory    = '',
  $fsoptions    = '',
  $fstype       = '',
  $group_params = '',
  $clone_params = false,
) {
  $resource_id = delete("fs-${directory}", '/')

  $resource_params = $fsoptions ? {
    ''      => "device=${device} directory=${directory} fstype=${fstype}",
    default => "device=${device} directory=${directory} fstype=${fstype} options=\"${fsoptions}\"",
  }

  pcmk_resource { $resource_id:
    ensure          => $ensure,
    resource_type   => 'Filesystem',
    resource_params => $resource_params,
    group_paramns   => $group_params,
    clone_params    => $clone,
  }
}
