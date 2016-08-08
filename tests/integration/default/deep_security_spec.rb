require 'spec_helper'

describe package("ds_agent") do
  it { should be_installed }
end


describe service('ds_agent') do
  it { should be_enabled }
  it { should be_running }
end
