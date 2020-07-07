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

  shared_examples 'sysctl::values with defaults' do
    let :params do
      {
        args: {
          'net.ipv4.ip_forward' => {
            'value'  => '1',
            'target' => '/dne/bar.conf',
          },
          'net.ipv6.conf.all.forwarding' => {},
        },
        defaults: {
          'target' => '/dne/foo.conf',
          'value'  => 42,
        }
      }
    end

    it do
      is_expected.to contain_sysctl('net.ipv4.ip_forward').with(
        val: '1',
        target: '/dne/bar.conf',
      )
    end
    it do
      is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with(
        val: '42',
        target: '/dne/foo.conf',
      )
    end
  end

  on_supported_os({
    :supported_os => SUPPORTED_OS
  }).each do |os, facts|
    context "on #{os}" do
      it_behaves_like 'sysctl::values'
      it_behaves_like 'sysctl::values with defaults'
    end
  end

  context 'does not fail with no args params' do
    it { is_expected.to compile.with_all_deps }
  end
end
