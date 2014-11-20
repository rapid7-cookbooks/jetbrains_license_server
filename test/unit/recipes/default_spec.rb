require_relative '../spec_helper'

describe 'jetbrains_license_server::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    stub_data_bag("users").and_return([])
  end

  it 'includes the tomcat default recipe' do
    expect(chef_run).to include_recipe('tomcat::default')
  end

  it 'includes the licenseserver recipe' do
    expect(chef_run).to include_recipe('jetbrains_license_server::licenseserver')
  end
end
