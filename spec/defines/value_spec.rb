require 'spec_helper'

describe 'sysctl::value' do
  let :title  do 'rspec_test' end
  let :params do { :value => 'foo bar baz' } end

  it do
    should contain_sysctl('rspec_test').with(
      :val    => "foo\tbar\tbaz",
      :before => 'Sysctl_runtime[rspec_test]'
    )
    should contain_sysctl_runtime('rspec_test').with_val("foo\tbar\tbaz")
  end

end
