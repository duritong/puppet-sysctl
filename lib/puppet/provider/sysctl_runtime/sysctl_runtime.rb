Puppet::Type.type(:sysctl_runtime).provide(:sysctl_runtime,
                                    :parent => Puppet::Provider
                                   ) do
  desc "This provider changes the runtime values of kernel parameters"

  commands :sysctl => 'sysctl'

  mk_resource_methods

  def self.instances
    #we don't use here the sysctl command to be able
    #to disable combining of stderr/stdout output.
    #Sysctl produces mixed output in case of error,
    #and it can't be parsed.
    #https://ask.puppetlabs.com/question/6299/combine-false-for-provider-commands/
    executor = (Facter.value(:puppetversion).to_i < 3) ? Puppet::Util : Puppet::Util::Execution
    output = executor.execute("#{Puppet::Util.which('sysctl')} -a", {
      :failonfail         => true,
      :combine            => false,
      :custom_environment => {}
    })
    output.split("\n").collect do |line|
      # lovely linux shows "fs.dir-notify-enable = 1"
      # lovely openbsd shows "fs.dir-notify-enable=1"
      name, val = line.split(/\s?[=:]\s?/,2)
      if name && val # maybe the line didn't match key = val
        new(
          :name => name,
          :val  => val
        )
      end
    end.compact
  end

  def self.prefetch(resources)
    sysctl_flags = instances
    resources.keys.each do |res|
      if provider = sysctl_flags.find{ |sres| sres.name == res }
        resources[res].provider = provider
      else
        raise(Puppet::ParseError, "sysctl parameter #{res} wasn't found on this system")
      end
    end
  end

  def val=(value)
    sysctl("#{resource[:name]}=#{value}")
  end

end
