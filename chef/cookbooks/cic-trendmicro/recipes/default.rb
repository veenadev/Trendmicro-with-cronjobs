#
# Cookbook Name:: cic-trendmicro
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
if node['platform'] == 'centos' 
  script " Download and Install Deep Security " do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
    wget https://deepsecurity.reancloud.com:443/software/agent/RedHat_EL6/x86_64/ -O /tmp/agent.rpm --no-check-certificate --quiet
    rpm -ihv /tmp/agent.rpm
    EOH
    not_if { File.exist?('/etc/init.d/ds_agent') }
  end

elsif node['platform'] == 'ubuntu'
  if node['platform_version'] == '16.04'    
    bash  'libapt-pkg4.12_0.8.16~exp12ubuntu10.21_amd64.deb' do
    user "root"
    cwd "/tmp"
    code <<-EOH
    #!/usr/bin/env bash
    wget http://security.ubuntu.com/ubuntu/pool/main/a/apt/libapt-pkg4.12_0.8.16~exp12ubuntu10.21_amd64.deb 
    apt-get -f install -y
    dpkg -i /tmp/libapt-pkg4.12_0.8.16~exp12ubuntu10.21_amd64.deb
    EOH
    not_if { File.exist?('/etc/init.d/ds_agent') }
    end
  end

  script " Download and Install Deep Security for ubuntu" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
    #!/usr/bin/env bash
    wget https://deepsecurity.reancloud.com:443/software/agent/Ubuntu_12.04/x86_64/ -O /tmp/agent.deb --no-check-certificate --quiet
    dpkg -i /tmp/agent.deb
    EOH
    not_if { File.exist?('/etc/init.d/ds_agent') }
  end
end
