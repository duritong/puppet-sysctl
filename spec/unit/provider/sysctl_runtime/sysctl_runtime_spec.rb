require 'puppet'
require 'spec_helper'
require 'puppet/provider/sysctl_runtime/sysctl_runtime'

provider_class = Puppet::Type.type(:sysctl_runtime)

describe provider_class do

  let :params do
    {
      :name => 'vm.huge.pages',
      :val  => '1234'
    }
  end

  let :resource do
    described_class.new(params)
  end

  let :linux_output do
    "vm.huge.pages = 1122\nvm.test.page = 3344\n"
  end

  let :openbsd_output do
    "test.option=345\nsecond.option=99\n"
  end

  let :freebsd_output do
    "test.option: 132\nsecond.option: 333\n"
  end

  before :each do
    allow(Puppet::Util).to receive(:which).with('sysctl').and_return('/sbin/sysctl')
  end

  # TODO: figure out how to read the :val option of resources from
  # the instances variable here.
  def parse_instances(data)
    result = data.map { |p|
      {
        :name => p[:name],
      }
    }
    result
  end

  describe '#instances' do
    context 'linux output' do
      before do
        allow(Puppet::Util::Execution).to receive(:execute).with('/sbin/sysctl -a', {:failonfail=>true, :combine=>false, :custom_environment=>{}}).and_return(linux_output)
      end

      it 'should return instances' do
        result = parse_instances(described_class.instances)
        expect(result.size).to eq(2)
        expect(result[0][:name]).to eq('vm.huge.pages')
        #expect(result[0][:val]).to eq('1122')
        expect(result[1][:name]).to eq('vm.test.page')
        #expect(result[1][:val]).to eq('3344')
      end
    end
  end

  describe '#instances' do
    context 'openbsd output' do
      before do
        allow(Puppet::Util::Execution).to receive(:execute).with('/sbin/sysctl -a', {:failonfail=>true, :combine=>false, :custom_environment=>{}}).and_return(openbsd_output)
      end

      it 'should return instances' do
        result = parse_instances(described_class.instances)
        expect(result.size).to eq(2)
        expect(result[0][:name]).to eq('test.option')
        #expect(result[0][:val]).to eq('345')
        expect(result[1][:name]).to eq('second.option')
        #expect(result[1][:val]).to eq('333')
      end
    end
  end

  describe '#instances' do
    context 'freebsd output' do
      before do
        allow(Puppet::Util::Execution).to receive(:execute).with('/sbin/sysctl -a', {:failonfail=>true, :combine=>false, :custom_environment=>{}}).and_return(freebsd_output)
      end

      it 'should return instances' do
        result = parse_instances(described_class.instances)
        expect(result.size).to eq(2)
        expect(result[0][:name]).to eq('test.option')
        #expect(result[0][:val]).to eq('132')
        expect(result[1][:name]).to eq('second.option')
        #expect(result[1][:val]).to eq('333')
      end
    end
  end
end
