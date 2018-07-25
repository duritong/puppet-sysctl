#
# Author: Tobias Urdin <tobias.urdin@binero.se>
#

require 'puppet'
require 'spec_helper'
require 'puppet/provider/sysctl/parsed'

provider_class = Puppet::Type.type(:sysctl).provider(:parsed)

describe provider_class do

  before :each do
    @provider_class = provider_class
    @provider_class.initvars
  end

  it 'should parse comments' do
    result = [{ :record_type => :comment, :line => "# hello world" }]
    expect(@provider_class.parse("# hello world\n")).to eq(result)
  end

  it 'should parse comments with leading whitespace' do
    result = [{ :record_type => :comment, :line => "  # hello" }]
    expect(@provider_class.parse("  # hello\n")).to eq(result)
  end

  it 'should skip empty lines' do
    result = [{ :record_type => :comment, :line => "#before" },
              { :record_type => :blank,   :line => "" },
              { :record_type => :comment, :line => "#after" }]
    expect(@provider_class.parse("#before\n\n#after\n")).to eq(result)
  end

  it 'should skip lines with only whitespace' do
    result = [{ :record_type => :comment, :line => "#before" },
              { :record_type => :blank,   :line => "  " },
              { :record_type => :comment, :line => "#after" }]
    expect(@provider_class.parse("#before\n  \n#after\n")).to eq(result)
  end

  it 'should parse sysctl type 1' do
    record = @provider_class.parse_line('vm.huge.pages = 1234')
    expect(record).not_to be_nil
    expect(record[:name]).to eq('vm.huge.pages')
    expect(record[:val]).to eq('1234')
  end

  it 'should parse sysctl type 2' do
    record = @provider_class.parse_line('vm.huge.pages= 1234')
    expect(record).not_to be_nil
    expect(record[:name]).to eq('vm.huge.pages')
    expect(record[:val]).to eq('1234')
  end

  it 'should parse sysctl type 3' do
    record = @provider_class.parse_line('vm.huge.pages =1234')
    expect(record).not_to be_nil
    expect(record[:name]).to eq('vm.huge.pages')
    expect(record[:val]).to eq('1234')
  end

  it 'should parse sysctl type 3' do
    record = @provider_class.parse_line('vm.huge.pages=1234')
    expect(record).not_to be_nil
    expect(record[:name]).to eq('vm.huge.pages')
    expect(record[:val]).to eq('1234')
  end
end
