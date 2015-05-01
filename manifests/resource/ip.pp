define pacemaker::resource::ip(
  $ip_address,
  $cidr_netmask = '',
  $nic          = '',
  $group_params = '',
  $ensure       = 'present') {

  $cidr_option = $cidr_netmask ? {
      ''      => '',
      default => " cidr=${cidr_netmask}"
  }
  $nic_option = $nic ? {
      ''      => '',
      default => " nic=${nic}"
  }

  pcmk_resource { "ip-${ip_address}":
    ensure          => $ensure,
    resource_type   => 'IPaddr2',
    resource_params => "ip=${ip_address}$cidr_option${nic_option}",
    group_params    => $group_params,
  }

}
