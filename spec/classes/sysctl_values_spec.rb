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

  on_supported_os({
    :supported_os => SUPPORTED_OS
  }).each do |os, facts|
    context "on #{os}" do
      it_behaves_like 'sysctl::values'
    end
  end
end
