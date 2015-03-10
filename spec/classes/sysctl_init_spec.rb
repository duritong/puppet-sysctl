#
# Author: Emilien Macchi <emilien@redhat.com>
#
require 'spec_helper'

describe 'sysctl' do

  shared_examples_for 'sysctl' do
    it { is_expected.to contain_file('/etc/sysctl.conf').with(
      'ensure' => 'present',
      'owner'  => 'root',
      'group'  => '0',
      'mode'   => '0644',
    )}
  end

  describe 'Debian' do
    let :facts do
      {
        :osfamily => 'Debian',
      }
    end

    it_configures 'sysctl'
  end


  describe 'RHEL' do
    let :facts do
      {
        :osfamily => 'RedHat',
      }
    end

    it_configures 'sysctl'
  end

end
