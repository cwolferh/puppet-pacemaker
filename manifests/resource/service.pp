define pacemaker::resource::service(
  $service_name    = "${name}",
  $ensure          = 'present',
  $resource_params = '',
  $op_params       = '',
  $meta_params     = '',
  $clone_params    = undef,
  $group_params    = undef,
) {
  include ::pacemaker::params
  $res = "pacemaker::resource::${::pacemaker::params::services_manager}"

  create_resources($res,
    { "${name}" => {
      service_name    => $service_name,
      ensure          => $ensure,
      resource_params => $resource_params,
      op_params       => $op_params,
      meta_params     => $meta_params,
      clone_params    => $clone_params,
      group_params    => $group_params,
    }
  })
}
