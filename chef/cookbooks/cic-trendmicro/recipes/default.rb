#
# Cookbook Name:: cic-trendmicro
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
if platform_family?('rhel')
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
end
