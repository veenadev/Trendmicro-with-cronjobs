#
# Cookbook Name:: cic_trendmicro_agent
# Recipe::dsa-integrity-scan.rb
#
# Copyright 2015, Trend Micro
#
# License as per [repo](master/LICENSE)
#
# *********************************************************************
# * Perform integrity scan
# *********************************************************************


cron 'dsa-integrity-scan' do
  #action node.tags.include?('dsa-integrity-scan') ? :create : :delete
  minute '30'
  hour '9'
  day '*'
  month '*'
  week '*'
  user 'veena.dev'
  mailto 'veena.dev@reancloud.com'
  home '/home/'
  command '/opt/ds_agent/dsa_control -m "IntegrityScan:true"'

  }.join(' ')
end
