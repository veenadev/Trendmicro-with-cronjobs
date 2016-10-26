#
# Cookbook Name:: cic_trendmicro_agent
# Recipe:: Scan the node for malware
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Scan the node for malware
# *********************************************************************
cron 'cron-dsa-scan-for-malware' do
  #action node.tags.include?('cron-dsa-scan-for-malware') ? :create : :delete
  hour '*/6'
  weekday '*'
  month '*'
  user 'veena'
  mailto 'veena.dev@reancloud.com'
  home '/root'
  command '/opt/ds_agent/dsa_control -m "AntiMalwareManualScan:true"'
end
