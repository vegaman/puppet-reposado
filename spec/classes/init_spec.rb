require 'spec_helper'
describe 'reposado' do

  context 'with defaults for all parameters' do
    it { should contain_class('reposado') }
  end
end
