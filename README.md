# jetbrains_license_server-cookbook

Installs the JetBrains License Server

## Supported Platforms

 - Linux

## Attributes

### default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['version']</tt></td>
    <td>Integer</td>
    <td>Version of the License Server to download and install</td>
    <td><tt>374</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['download']['uri']</tt></td>
    <td>String</td>
    <td>Base URI for the License Server zip file</td>
    <td><tt>'http://download-cf.jetbrains.com/lcsrv/'</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['download']['file_prefix']</tt></td>
    <td>String</td>
    <td>The first part of the filename preceeding the version.</td>
    <td><tt>'licenseServer-war'</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['download']['file_suffix']</tt></td>
    <td>String</td>
    <td>The filename extension.</td>
    <td><tt>'zip'</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['checksum']</tt></td>
    <td>String</td>
    <td>SHA-256 Checksum of the LicenseServer to download</td>
    <td><tt>'a3935a2fdd644d780b30f05855c9d1b0b0582be1ad92919df40a0c3fd7ff33a1'</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['modelContext_path']</tt></td>
    <td>String</td>
    <td>Path to the modelContext.xml file exploded from the war file.</td>
    <td><tt>'licenseServer/WEB-INF/classes/META-INF/modelContext.xml'</tt></td>
  </tr>
  <tr>
    <td><tt>['jetbrains_license_server']['derby_dir']</tt></td>
    <td>String</td>
    <td>Subdirectory name where the database lives</td>
    <td><tt>'derby'</tt></td>
  </tr>
</table>

### java
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['java']['version']</tt></td>
    <td>String</td>
    <td>Version of java to install</td>
    <td><tt>'7'</tt></td>
  </tr>
</table>

### tomcat
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tomcat']['base_version']</tt></td>
    <td>Integer</td>
    <td>Version of tomcat to install</td>
    <td><tt>7</tt></td>
  </tr>
</table>

## Usage

### jetbrains_license_server::default

Include `jetbrains_license_server` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[jetbrains_license_server::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Ryan Hass (<ryan_hass@rapid7.com>)
