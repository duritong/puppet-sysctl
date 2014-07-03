require 'spec_helper'

describe 'sysctl::value' do
  oses = [
    { :osfamily        => 'Debian',
      :operatingsystem => 'debian',
      :kernel          => 'Linux',
    },
    { :osfamily        => 'RedHat',
      :operatingsystem => 'CentOS',
      :kernel          => 'Linux',
    },
    { :osfamily        => 'OpenBSD',
      :operatingsystem => 'OpenBSD',
      :kernel          => 'OpenBSD',
    },
    { :osfamily        => 'FreeBSD',
      :operatingsystem => 'FreeBSD',
      :kernel          => 'FreeBSD',
    },
  ]
  let :title  do 'rspec_test' end
  let :params do { :value => 'foo bar baz' } end
  oses.each { |f|
    context "on #{f[:operatingsystem]}" do
      let :facts do f end

      it { should contain_sysctl('rspec_test').with_val(
        "foo\tbar\tbaz"
      ) }

      # OS-specific traits.
      case f[:kernel]
      when 'Linux' then
        it { should contain_exec('apply_sysctl').with_command(
          "sysctl -p"
        ) }
      when /BSD$/ then
        it { should contain_exec('apply_sysctl').with_command(
          "sysctl -f /etc/sysctl.conf"
        ) }
      end
    end
  }
end
