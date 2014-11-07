Puppet::Type.newtype(:pcmk_constraint) do
    @doc = "Base constraint definition for a pacemaker constraint"

    ensurable

    newparam(:name) do
        desc "A unique name for the constraint"
    end

    newparam(:constraint_type) do
        desc "the pacemaker type to create"
        newvalues(:location, :colocation)
    end
    newparam(:resource) do
        desc "resource list"
        newvalues(/.+/)
    end
    newparam(:location) do
        desc "location"
        newvalues(/.+/)
    end
    newparam(:score) do
        desc "Score"
    end

    newparam(:tries) do
      desc "The number of times to attempt to add the cosntraint
        Defaults to '1'."

      munge do |value|
        if value.is_a?(String)
          unless value =~ /^[\d]+$/
            raise ArgumentError, "Tries must be an integer"
          end
          value = Integer(value)
        end
        raise ArgumentError, "Tries must be an integer >= 1" if value < 1
        value
      end

      defaultto 1
    end

    newparam(:try_sleep) do
      desc "The time to sleep in seconds between 'tries'."

      munge do |value|
        if value.is_a?(String)
          unless value =~ /^[-\d.]+$/
            raise ArgumentError, "try_sleep must be a number"
          end
          value = Float(value)
        end
        raise ArgumentError, "try_sleep cannot be a negative number" if value < 0
        value
      end

      defaultto 0
    end

end
