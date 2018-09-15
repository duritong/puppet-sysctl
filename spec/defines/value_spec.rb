require 'spec_helper'

describe 'sysctl::value' do
  let(:title) { 'rspec_test' }

  shared_examples 'sysctl::value' do
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

    context 'with integer value' do
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

    context 'with custom target' do
      let(:params) do
        {
          :value  => 1,
          :target => '/etc/sysctl.d/custom.conf'
        }
      end

      it {
        should contain_sysctl('rspec_test').with(
          :val    => '1',
          :target => '/etc/sysctl.d/custom.conf',
          :before => 'Sysctl_runtime[rspec_test]'
        )
        should contain_sysctl_runtime('rspec_test').with_val('1')
      }
    end

    context 'with invalid custom target' do
      let(:params) do
        {
          :value  => 1,
          :target => 'file.conf'
        }
      end

      it { should raise_error(Puppet::Error, /expects a match for Sysctl::Unixpath/) }
    end
  end

  on_supported_os({
    :supported_os => SUPPORTED_OS
  }).each do |os, facts|
    context "on #{os}" do
      it_behaves_like 'sysctl::value'
    end
  end
end
