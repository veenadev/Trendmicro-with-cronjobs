require 'serverspec'
require 'json'

prop_file = ENV['PROPERTIES_PATH'] || 'properties.json'
file = File.read(prop_file)
properties = JSON.parse(file)
 
if properties["connection"] == "ssh"
	require 'net/ssh'
	# This line tells ServerSpec that SSH is going to be used for communication with the target system.
	set :backend, :ssh
	set :os, :family => 'linux'
	 
	# This line pulls the target hostname out of the TARGET_HOST environment variable as passed by the build.
	host = properties["host"]
	 
	options = Net::SSH::Config.for(host)
	 
	# This line pulls the SSH username out of the TARGET_USER environment variable as passed by the build.
	options[:user] = properties["user"]
	  
	# This line pulls the SSH keyfile path out of the TARGET_KEYS environment variable as passed by the build.
	options[:keys] = properties["key"]
	 
	# These lines configure the SSH connection, and should be considered the bare minimum necessary for successful testing.
	set :host,        options[:host_name] || host
	set :ssh_options, options
	set :request_pty, true
elsif properties["connection"] == "windows"
	require 'winrm'
	set :backend, :winrm
	set :os, :family => 'windows'

	user = properties["user"]
	pass = properties["password"]
	endpoint = "http://#{properties["host"]}:5985/wsman"

	winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
	winrm.set_timeout 300 # 5 minutes max timeout for any operation
	Specinfra.configuration.winrm = winrm
end