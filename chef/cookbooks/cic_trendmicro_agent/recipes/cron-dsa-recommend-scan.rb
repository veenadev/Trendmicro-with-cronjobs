#
# Cookbook Name:: cic_trendmicro_agent
# Recipe:: dsa-recommend-scan.rb
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Recommend a security policy for the node
# *********************************************************************
cron 'dsa-recommend-scan' do
  action node.tags.include?('dsa-recommend-scan') ? :create : :delete
  minute '0'
  hour '0'
  weekday '1'
  user 'veena'
  mailto 'veena.dev@reancloud.com'
  home '/root'
  command '/opt/ds_agent/dsa_control -m "RecommendationScan:true"'
 
end
