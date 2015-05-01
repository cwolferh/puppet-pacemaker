define pacemaker::resource::service(
  $ensure          = 'present',
  $resource_params = '',
  $op_params       = '',
  $meta_params     = '',
  $clone_params    = '',
  $group_params    = '',
) {
  include ::pacemaker::params
  $res = "pacemaker::resource::${::pacemaker::params::services_manager}"
  create_resources($res,
    { "${name}" => {
      ensure          => $ensure,
      resource_params => $resource_params,
      op_params       => $op_params,
      meta_params     => $meta_params,
      clone_params    => $clone_params,
      group_params    => $group_params,
    }
  })
}
