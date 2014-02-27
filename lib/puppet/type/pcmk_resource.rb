Puppet::Type.newtype(:pcmk_resource) do
    @doc = "Base resource definition for a pacemaker resource"

    ensurable
    def munge_boolean(value)
        case value
        when true, "true", :true
            :true
        when false, "false", :false
            :false
        else
            fail("munge_boolean only takes booleans")
        end
    end

    newparam(:name) do
        desc "A unique name for the resource"
    end

    newparam(:resource_type) do
        desc "the pacemaker type to create"
    end
    newproperty(:resource_params) do
        desc "extra parameters to the retource group"
    end
    newproperty(:group) do
        desc "A resource group to put the resource in"
    end
    newproperty(:clone, :boolean => true) do
        desc "set if this is a cloned resource"
        newvalue(:true)
        newvalue(:false)
        defaultto :false

        munge do |value|
        puts "VALUE clone before munge IS "+value.to_s
        value = @resource.munge_boolean(value)
            puts "VALUE clone after munge IS "+value.to_s
            value
        #    @resource.munge_boolean(value)
        end
    end
    newproperty(:interval) do
        desc "resource check interval"
        defaultto "30s"
    end

end
