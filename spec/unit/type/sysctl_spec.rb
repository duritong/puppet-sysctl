#
# Author: Tobias Urdin <tobias.urdin@binero.se>
#

require 'puppet'
require 'puppet/type/sysctl'

describe 'Puppet::Type.type(:sysctl)' do

  before do
    @sysctl_resource = Puppet::Type::type(:sysctl).new(
      :name => 'vm.nr_hugepages',
      :val  => '1583'
    )
  end

  it 'should have its name set' do
    expect(@sysctl_resource[:name]).to eq('vm.nr_hugepages')
  end

  it 'should have its value set' do
    expect(@sysctl_resource[:val]).to eq('1583')
  end

  it 'should have its value updated' do
    expect(@sysctl_resource[:val]).to eq('1583')
    @sysctl_resource[:val] = '1234'
    expect(@sysctl_resource[:val]).to eq('1234')
  end

  it 'should have its target set' do
    expect(@sysctl_resource[:target]).to eq('/etc/sysctl.conf')
  end

  it 'should have its target updated' do
    expect(@sysctl_resource[:target]).to eq('/etc/sysctl.conf')
    @sysctl_resource[:target] = '/etc/sysctl.d/test.conf'
    expect(@sysctl_resource[:target]).to eq('/etc/sysctl.d/test.conf')
  end
end
