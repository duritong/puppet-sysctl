require 'puppet/provider/parsedfile'

default_target = '/etc/sysctl.conf'

Puppet::Type.type(:sysctl).provide(:parsed, :parent => Puppet::Provider::ParsedFile,
                                   :default_target => default_target, :filetype => :flat) do
    confine :exists => default_target
    text_line :comment, :match => /^\s*#/;
    text_line :blank, :match => /^\s*$/;

    record_line :parsed, :fields => %w{name val}, :joiner => '=', :separator => /\s*=\s*/
end
