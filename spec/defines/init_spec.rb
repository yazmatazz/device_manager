require 'spec_helper'

describe 'puppet_device' do

  context 'on linux, with values for all parameters' do
    let(:title)  { 'bigip' }
    let(:params) { {
        :ensure => 'present',
        :type   => 'f5',
        :url    => 'https://admin:fffff55555@10.0.0.245/',
        :debug  => true,
        :run    => true,
      }
    }

    let(:facts) { {
        :puppet_deviceconfig    => '/etc/puppetlabs/puppet/device.conf',
        :puppetlabs_confdir     => '/etc/puppetlabs',
        :osfamily               => 'redhat',
        :env_windows_installdir => "C:/Program Files/Puppet Labs/Puppet/bin",
      }
    }

    it { is_expected.to contain_puppet_device('bigip') }
    it { is_expected.to contain_exec('run puppet_device target bigip').with_command("/opt/puppetlabs/puppet/bin/puppet device --target bigip --user=root --waitforcert 0") }
    it { is_expected.to contain_class('puppet_device::conf') }
    it { is_expected.to contain_class('puppet_device::fact') }

  end

  context 'on windows, with values for all parameters' do
    let(:title)  { 'bigip' }
    let(:params) { {
        :ensure => 'present',
        :type   => 'f5',
        :url    => 'https://admin:fffff55555@10.0.0.245/',
        :debug  => true,
        :run    => true,
      }
    }

    let(:facts) { {
        :puppet_deviceconfig    => '/etc/puppetlabs/puppet/device.conf',
        :puppetlabs_confdir     => '/etc/puppetlabs',
        :osfamily               => 'windows',
        :env_windows_installdir => "C:/Program Files/Puppet Labs/Puppet/bin",
      }
    }

    it { is_expected.to contain_puppet_device('bigip') }
    it { is_expected.to contain_exec('run puppet_device target bigip').with_command("\"C:/Program Files/Puppet Labs/Puppet/bin/puppet\" device --target bigip --user=root --waitforcert 0") }
    it { is_expected.to contain_class('puppet_device::conf') }
    it { is_expected.to contain_class('puppet_device::fact') }
  end

end