require 'spec_helper'

describe 'catalog_url' do
  it { is_expected.to run.with_params('10.4').and_return("/content/catalogs/index") }
  it { is_expected.to run.with_params('10.5').and_return("/content/catalogs/others/index-leopard.merged-1") }
  it { is_expected.to run.with_params('leopard').and_return("/content/catalogs/others/index-leopard.merged-1") }
  it { is_expected.to run.with_params('10.6').and_return("/content/catalogs/others/index-leopard-snowleopard.merged-1") }
  it { is_expected.to run.with_params('snowleopard').and_return("/content/catalogs/others/index-leopard-snowleopard.merged-1") }
  it { is_expected.to run.with_params('10.7').and_return("/content/catalogs/others/index-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('lion').and_return("/content/catalogs/others/index-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.8').and_return("/content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.9').and_return("/content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.10').and_return("/content/catalogs/others/index-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.11').and_return("/content/catalogs/others/index-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.12').and_return("/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1") }
  it { is_expected.to run.with_params('10.13').and_return("/content/catalogs/others/index-10.13-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1") }
end
