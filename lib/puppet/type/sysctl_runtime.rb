Puppet::Type.newtype(:sysctl_runtime) do

        @doc = "Manages kernel runtime parameters. This type doesn't change any configuration files."

        newparam(:name, :namevar => true) do
            desc "Name of the parameter"
            isnamevar
        end
        
        newproperty(:val) do
            desc "Value the parameter should be set to"
        end

end
