#
# Cookbook Name:: cic_trendmicro_agent
# Recipe:: Re-build an integrity baseline for the node
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Re-builds an integrity baseline for the current node
# *********************************************************************
cron 'dsa-rebuild-integrity-baseline' do
  #action node.tags.include?('dsa-integrity-scan') ? :create : :delete
  minute '0'
  hour '0'
  day '0'
  month '0'
  weekday '1'
  user 'veena.dev'
  mailto 'veena.dev@reancloud.com'
  home '/root'
  command '/opt/ds_agent/dsa_control -m "RebuildBaseline:true"'

  }.join(' ')
end
