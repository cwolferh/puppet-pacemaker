define pacemaker::resource::filesystem(
  $ensure       = 'present',
  $device       = '',
  $directory    = '',
  $fsoptions    = '',
  $fstype       = '',
  $op_params    = '',
  $meta_params  = '',
  $clone_params = undef,
  $group_params = undef,
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
    op_params       => $op_params,
    meta_params     => $meta_params,
    clone_params    => $clone_params,
    group_params    => $group_params,
  }
}
