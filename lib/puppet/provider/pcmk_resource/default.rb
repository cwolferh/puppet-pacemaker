Puppet::Type.type(:pcmk_resource).provide(:default) do
  desc 'A base resource definition for a pacemaker resource'

  ### overloaded methods
  def create
    resp = @resource[:resource_params]
    metap = @resource[:meta_params]
    opp = @resource[:op_params]
    clonep = @resource[:clone_params]
    groupp = @resource[:group_params]
    mstrp = @resource[:master_params]

    suffixes = 0
    if clonep then suffixes +=1 end
    if mstrp then suffixes +=1 end
    if groupp then suffixes +=1 end
    if suffixes > 1
      raise(Puppet::Error, "May only define one of clone_params, "+
            "master_params and group_params")
    end

    cmd = 'resource create ' + @resource[:name]+' ' +@resource[:resource_type]
    if resp and resp.kind_of?(String) and not resp.empty?
      cmd += ' ' + resp
    end
    if metap and metap.kind_of?(String) and not metap.empty?
      cmd += ' meta ' + metap
    end
    if opp and opp.kind_of?(String) and not opp.empty?
      cmd += ' op ' + opp
    end
    if clonep
      cmd += ' --clone'
      if clonep.kind_of?(String) and not clonep.empty?
        cmd += ' ' + clonep
      end
    end
    if groupp and groupp.kind_of?(String) and not groupp.empty?
      cmd += ' --group ' + groupp
    end
    if mstrp
      cmd += ' --master'
      if mstrp.kind_of?(String) and not mstrp.empty?
        cmd += ' ' + mstrp
      end
    end

    # do pcs create
    pcs('create', cmd)
  end

  def destroy
    cmd = 'resource delete ' + @resource[:name]
    pcs('delete', cmd)
  end

  def exists?
    cmd = 'resource show ' + @resource[:name] + ' > /dev/null 2>&1'
    pcs('show', cmd)
  end


  ### property methods

  # It isn't an easy road if you want to make these true
  # puppet-like properties.  Here is a start if you are feeling brave:
  # https://github.com/cwolferh/puppet-pacemaker/blob/pcmk_resource_improvements_try0/lib/puppet/provider/pcmk_resource/default.rb#L64
  def resource_params
    @resource[:resource_params]
  end

  def resource_params=(value)
  end

  def op_params
    @resource[:op_params]
  end

  def op_params=(value)
  end

  def meta_params
    @resource[:meta_params]
  end

  def meta_params=(value)
  end

  def group_params
    @resource[:group_params]
  end

  def group_params=(value)
  end

  def master_params
    @resource[:master_params]
  end

  def master_params=(value)
  end

  #def group
  #  # get the list of groups and their resources
  #  cmd = 'resource --groups'
  #  resource_groups = pcs('group list', cmd)
  #
  #  # find the group that has the resource in it
  #  for group in resource_groups.lines.each do
  #    return group[0, /:/ =~ group] if group.include? @resource[:name]
  #  end
  #  # return empty string if a group wasn't found
  #  # that includes the resource in it.
  #  ''
  #end
  #
  #def group=(value)
  #  if value.empty?
  #    cmd = 'resource ungroup ' + group + ' ' + @resource[:name]
  #    pcs('ungroup', cmd)
  #  else
  #    cmd = 'resource group add ' + value + ' ' + @resource[:name]
  #    pcs('group add', cmd)
  #  end
  #end

  def clone_params
    @resource[:clone_params]
    #
    #cmd = 'resource show ' + @resource[:name] + '-clone > /dev/null 2>&1'
    #if pcs('show clone', cmd) == false
    #  return nil
    #end
    #
  end

  def clone_params=(value)
    #if not value
    #  cmd = 'resource unclone ' + @resource[:name]
    #  pcs('unclone', cmd)
    #else
    #  cmd = 'resource clone ' + @resource[:name]
    #  pcs('clone', cmd)
    #end
  end

  def pcs(name, cmd)
    Puppet.debug("/usr/sbin/pcs #{cmd}")
    pcs_out = `/usr/sbin/pcs #{cmd}`
    if $?.exitstatus != 0 and pcs_out.lines.first and not name.include? 'show'
      Puppet.debug("Error: #{pcs_out}")
      raise Puppet::Error, "pcs #{name} failed: #{pcs_out.lines.first.chomp!}" if $?.exitstatus
    end
    # return output for good exit or false for failure.
    $?.exitstatus == 0 ? pcs_out : false
  end

end
