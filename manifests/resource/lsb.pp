define pacemaker::resource::lsb(
  $ensure          = 'present',
  $resource_params = '',
  $op_params       = '',
  $meta_params     = '',
  $clone_params    = undef,
  $group_params    = undef,
  $service_name    = "{$name}",
) {
  pcmk_resource { $name:
    ensure          => $ensure,
    resource_type   => "lsb:${service_name}",
    resource_params => $resource_params,
    op_params       => $op_params,
    meta_params     => $meta_params,
    clone_params    => $clone_params,
    group_params    => $group_params,
  }
}
