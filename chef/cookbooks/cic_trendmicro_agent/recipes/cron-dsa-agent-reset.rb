#
# Cookbook Name:: cic_trendmicro_agent
# Recipe::dsa-agent-reset.rb
# Copyright 2015, Trend Micro
# *********************************************************************
# *Resets Agent
# *********************************************************************

cron 'dsa-agent-reset' do
  action node.tags.include?('dsa-agent-reset') ? :create : :delete
  minute '0'
  hour '0'
  weekday '0'
  user 'veena'
  mailto 'veena.dev@reancloud.com'
  home '/root'
  command '/opt/ds_agent/dsa_control -r'
end
