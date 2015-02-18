require 'spec_helper'

describe 'sysctl::value' do
  let(:title) { 'rspec_test' }
  context 'string value' do
    let(:params){ { :value => 'foo bar baz' } }

    it do
      should contain_sysctl('rspec_test').with(
        :val    => "foo\tbar\tbaz",
        :before => 'Sysctl_runtime[rspec_test]'
      )
      should contain_sysctl_runtime('rspec_test').with_val("foo\tbar\tbaz")
    end
  end

  context 'fixnum value' do
    let(:params){ { :value => 1 } }
    it do
      should contain_sysctl('rspec_test').with(
        :val    => "1",
        :before => 'Sysctl_runtime[rspec_test]'
      )
      should contain_sysctl_runtime('rspec_test').with_val("1")
    end
  end

end
