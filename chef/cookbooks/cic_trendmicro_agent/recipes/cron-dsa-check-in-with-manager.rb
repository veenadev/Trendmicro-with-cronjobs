#
# Cookbook Name:: cic_trendmicro_agent
# Recipe:: Check-in with the Deep Security manager
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Ask the Deep Security agent to check-in
# *********************************************************************

cron 'dsa-check-in-with-manager' do
  action node.tags.include?('dsa-check-in-with-manager') ? :create : :delete
  minute '0'
  hour '0'
  weekday '0'
  user 'veena.dev'
  mailto 'veena.dev@reancloud.com'
  home '/home/'
  command %W{
    /opt/ds_agent/dsa_control -m
  }.join(' ')
end

