require 'puppet'
require 'puppet/type/sysctl_runtime'

describe 'Puppet::Type.type(:sysctl_runtime)' do

  before do
    @sysctl_runtime_resource = Puppet::Type::type(:sysctl_runtime).new(
      :name => 'vm.nr_hugepages',
      :val  => '1583'
    )
  end

  it 'should have its name set' do
    expect(@sysctl_runtime_resource[:name]).to eq('vm.nr_hugepages')
  end

  it 'should have its value set' do
    expect(@sysctl_runtime_resource[:val]).to eq('1583')
  end

  it 'should have its value updated' do
    expect(@sysctl_runtime_resource[:val]).to eq('1583')
    @sysctl_runtime_resource[:val] = '1234'
    expect(@sysctl_runtime_resource[:val]).to eq('1234')
  end
end
