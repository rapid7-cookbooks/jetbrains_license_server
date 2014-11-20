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

default['jetbrains_license_server']['version']  = 374
default['jetbrains_license_server']['download']['uri'] = 'http://download-cf.jetbrains.com/lcsrv/'
default['jetbrains_license_server']['download']['file_prefix'] = 'licenseServer-war'
default['jetbrains_license_server']['download']['file_suffix'] = 'zip'
default['jetbrains_license_server']['checksum'] = 'a3935a2fdd644d780b30f05855c9d1b0b0582be1ad92919df40a0c3fd7ff33a1'
default['jetbrains_license_server']['modelContext_path'] = 'licenseServer/WEB-INF/classes/META-INF/modelContext.xml'
default['jetbrains_license_server']['derby_dir'] = 'derby'
