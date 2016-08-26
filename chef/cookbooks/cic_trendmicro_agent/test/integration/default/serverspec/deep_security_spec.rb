require 'spec_helper'

if os[:family] == 'redhat'
  describe package('ds_agent') do
    it { should be_installed }
  end
elsif os[:family] == 'debian'
  describe package('ds-agent') do
    it { should be_installed }
  end
end

describe service('ds_agent') do
  it { should be_enabled }
  it { should be_running }
end
