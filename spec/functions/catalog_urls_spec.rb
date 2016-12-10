require 'spec_helper'

describe 'catalog_urls' do
  it { is_expected.to run.with_params(['10.4']).and_return(["http://swscan.apple.com/content/catalogs/index.sucatalog"]) }
  it { is_expected.to run.with_params(['10.4', 'leopard', 'snowleopard', '10.7']).and_return(
    ["http://swscan.apple.com/content/catalogs/index.sucatalog",
      "http://swscan.apple.com/content/catalogs/others/index-leopard.merged-1.sucatalog",
      "http://swscan.apple.com/content/catalogs/others/index-leopard-snowleopard.merged-1.sucatalog",
      "http://swscan.apple.com/content/catalogs/others/index-lion-snowleopard-leopard.merged-1.sucatalog"]) }
  it { is_expected.to run.with_params(['10.8', '10.9']).and_return(
    ["http://swscan.apple.com/content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog",
      "https://swscan.apple.com/content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog"]) }
end
