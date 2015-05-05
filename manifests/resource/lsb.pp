# == Define Resource Type: pacemaker::resource::lsb
#
# See pacemaker::resource::service.  Typical usage is to declare
# pacemaker::resource::service rather than this resource directly.
#
define pacemaker::resource::lsb(
  $ensure          = 'present',
  $service_name    = $name,
  $resource_params = '',
  $op_params       = '',
  $meta_params     = '',
  $clone_params    = undef,
  $group_params    = undef,
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
