#
# Author: Emilien Macchi <emilien@redhat.com>
#
require 'spec_helper'

describe 'sysctl::values' do

  shared_examples_for 'sysctl values' do
    let :params do
      {
        :args => {
          'net.ipv4.ip_forward' => {
            'value' => '1',
          },
          'net.ipv6.conf.all.forwarding' => {
            'value' => '1',
          },
        },
      }
    end

    it {
      is_expected.to contain_sysctl('net.ipv4.ip_forward').with('val' => "1")
      is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with('val' => "1")
    }
  end

  describe 'Debian' do
    let :facts do
      {
        :osfamily => 'Debian',
      }
    end

    it_configures 'sysctl values'
  end


  describe 'RHEL' do
    let :facts do
      {
        :osfamily => 'RedHat',
      }
    end

    it_configures 'sysctl values'
  end

end
