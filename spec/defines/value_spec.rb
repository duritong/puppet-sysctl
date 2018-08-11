require 'spec_helper'

describe 'sysctl::value' do

  let(:title) { 'rspec_test' }

  context 'with string value' do
    let(:params) do
      {
        :value => 'foo bar baz',
      }
    end

    it {
      should contain_sysctl('rspec_test').with(
        :val    => "foo\tbar\tbaz",
        :before => 'Sysctl_runtime[rspec_test]'
      )
      should contain_sysctl_runtime('rspec_test').with_val("foo\tbar\tbaz")
    }
  end

  context 'with Fixnum value' do
    let(:params) do
      {
        :value => 1
      }
    end

    it {
      should contain_sysctl('rspec_test').with(
        :val    => '1',
        :before => 'Sysctl_runtime[rspec_test]'
      )
      should contain_sysctl_runtime('rspec_test').with_val('1')
    }
  end
end
