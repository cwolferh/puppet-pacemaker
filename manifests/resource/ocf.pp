define pacemaker::resource::ocf(
  $ensure          = 'present',
  $resource_params = '',
  $op_params       = '',
  $meta_params     = '',
  $clone_params    = '',
  $group_params    = '',
) {
  pcmk_resource { $name:
    ensure          => $ensure,
    resource_type   => "ocf:${name}",
    resource_params => $resource_params,
    op_params       => $op_params,
    meta_params     => $meta_params,
    clone_params    => $clone_params,
    group_params    => $group_params,
  }
}
