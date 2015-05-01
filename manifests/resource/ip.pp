define pacemaker::resource::ip($ip_address,
                               $cidr_netmask=32,
                               $nic='',
                               $group_params='',
                               $ensure='present') {

  $nic_option = $nic ? {
      ''      => '',
      default => " nic=$nic"
  }

  pcmk_resource { "ip-${ip_address}":
    ensure          => $ensure,
    resource_type   => 'IPaddr2',
    resource_params => "ip=${ip_address} cidr_netmask=${cidr_netmask}${nic_option}",
    group_params    => $group_params,
  }

}
