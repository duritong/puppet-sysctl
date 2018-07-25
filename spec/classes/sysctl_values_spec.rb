#
# Author: Emilien Macchi <emilien@redhat.com>
#
require 'spec_helper'

describe 'sysctl::values' do

  shared_examples 'sysctl::values' do
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
      should contain_sysctl('net.ipv4.ip_forward').with_val('1')
      should contain_sysctl('net.ipv6.conf.all.forwarding').with_val('1')
    }
  end

  describe 'sysctl::values on Debian' do
    let :facts do
      {
        :osfamily => 'Debian',
      }
    end

    it_behaves_like 'sysctl::values'
  end


  describe 'sysctl::values on RedHat' do
    let :facts do
      {
        :osfamily => 'RedHat',
      }
    end

    it_behaves_like 'sysctl::values'
  end

end
