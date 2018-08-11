Puppet::Type.newtype(:sysctl) do
  @doc = <<-EOF
    @summary
      Manages kernel parameters in /etc/sysctl.conf.  This will only
      edit the configuration file, and not change any of the runtime
      values. If you wish changes to be activated right away, use the
      sysctl::value definition or the sysctl_runtime resource type.

    @api public
  EOF

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Name of the parameter'
    isnamevar
  end
        
  newproperty(:val) do
    desc 'Value the parameter should be set to'
  end

  newproperty(:target) do
    desc 'Name of the file to store parameters in'
    defaultto {
      if (@resource.class.defaultprovider and
         @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile))
        @resource.class.defaultprovider.default_target
      else
        nil
      end
    }
  end
end
