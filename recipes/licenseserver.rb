#
# Cookbook Name:: jetbrains_license_server
# Recipe:: licenseserver
#
# Copyright (C) 2014 Rapid7, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'uri'

licserv_war = "#{node['jetbrains_license_server']['download']['file_prefix']}-#{node['jetbrains_license_server']['version']}.#{node['jetbrains_license_server']['download']['file_suffix']}"

package 'unzip'

# Re-register tomcat as a service as the current upstream cookbook has a bug
# in which the service is not identifiable from a wrapper cookbook.
service "tomcat#{node['tomcat']['base_version']}" do
  action :nothing
end

directory ::File.join(node['tomcat']['home'], node['jetbrains_license_server']['derby_dir']) do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0755
end

remote_file ::File.join(Chef::Config[:file_cache_path], licserv_war) do
  source ::URI.join(node['jetbrains_license_server']['download']['uri'], licserv_war).to_s
  checksum node['jetbrains_license_server']['checksum']
  notifies :run, 'execute[unzip_licserv]'
end

execute 'unzip_licserv' do
  command "unzip -o #{::File.join(Chef::Config[:file_cache_path], licserv_war)} -d #{node['tomcat']['webapp_dir']}"
  action :nothing
  notifies :restart, "service[tomcat#{node['tomcat']['base_version']}]", :delayed
end

template ::File.join(node['tomcat']['webapp_dir'], node['jetbrains_license_server']['modelContext_path']) do
  source 'modelContext.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0644
  variables ({ :derby_dir => node['jetbrains_license_server']['derby_dir'].to_s })
  subscribes :create, 'execute[unzip_licserv]'
  notifies :restart, "service[tomcat#{node['tomcat']['base_version']}]", :immediately
  action :nothing
end

template ::File.join(node['tomcat']['context_dir'], 'ROOT.xml') do
  source 'ROOT.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode 0644
  notifies :restart, "service[tomcat#{node['tomcat']['base_version']}]", :delayed
  action node['jetbrains_license_server']['root_context_action']
end
