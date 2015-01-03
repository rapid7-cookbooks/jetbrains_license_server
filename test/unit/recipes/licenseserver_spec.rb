# Copyright (C) 2014, Rapid7, LLC.
# License:: Apache License, Version 2.0
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

describe 'jetbrains_license_server::licenseserver' do
  tomcat_versions = [ 6, 7, 8 ]

  tomcat_versions.each do |version|
    context "on tomcat#{version}" do
      cached(:chef_run) {
        ChefSpec::SoloRunner.new do |node|
          node.set['tomcat']['base_version'] = version
        end.converge(described_recipe) }

      let(:licserv_war)   { "#{chef_run.node['jetbrains_license_server']['download']['file_prefix']}-#{chef_run.node['jetbrains_license_server']['version']}.#{chef_run.node['jetbrains_license_server']['download']['file_suffix']}" }
      let(:zip_file)      { ::File.join(Chef::Config[:file_cache_path], licserv_war) }
      let(:tomcat_ver)    { "tomcat#{chef_run.node['tomcat']['base_version']}"}

      let(:remote_zip)    { chef_run.remote_file(zip_file) }
      let(:unzip_command) { chef_run.execute('unzip_licserv') }
      let(:mc_template)   { chef_run.template(::File.join(chef_run.node['tomcat']['webapp_dir'],                                                   chef_run.node['jetbrains_license_server']['modelContext_path'])) }
      let(:tomcat_svc)    { chef_run.service(tomcat_ver) }
      let(:rc_template)   { chef_run.template(::File.join(node['tomcat']['context_dir'], 'ROOT.xml')) }

      it 'installs unzip' do
        expect(chef_run).to install_package('unzip')
      end

      it 're-registers the tomcat service with no action' do
        expect(tomcat_svc).to do_nothing
      end

      it 'creates a directory where the license server/tomcat can create and write to the db' do
        expect(chef_run).to create_directory(::File.join(chef_run.node['tomcat']['home'],
                                                         chef_run.node['jetbrains_license_server']['derby_dir'])
                                            ).with(
                                              user:   chef_run.node['tomcat']['user'],
                                              group:  chef_run.node['tomcat']['group'],
                                              mode:   0755
                                            )

      end

      it 'downloads the license server' do
        expect(chef_run).to create_remote_file(zip_file)

        expect(remote_zip).to notify('execute[unzip_licserv]').to(:run)
      end

      it 'unzips the war file when a new zip file is downloaded' do
        expect(unzip_command).to do_nothing
        expect(unzip_command).to notify("service[#{tomcat_ver}]").to(:restart).delayed
      end

      it 'deploys the template when a new zip file is exploded' do
        expect(mc_template).to do_nothing
        expect(mc_template).to subscribe_to('execute[unzip_licserv]')
      end

      it 'notifies tomcat to restart when the template is deployed' do
        expect(mc_template).to notify("service[#{tomcat_ver}]").to(:restart).immediately
      end

      it 'configures the licenseServer as the root context' do
        expect(chef_run).to create_template(::File.join(chef_run.node['tomcat']['context_dir'], 'ROOT.xml'))
      end

    end
  end
end
