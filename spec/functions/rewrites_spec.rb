require 'spec_helper'

describe 'rewrites' do
  it { is_expected.to run.with_params(['10.4']).and_return([{ "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/8", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/index$1.sucatalog [L]" }]) }

  it { is_expected.to run.with_params(['10.8', '10.9']).and_return(
    [{ "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/12", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" },
      { "rewrite_cond" => "%{HTTP_USER_AGENT} Darwin/13", "rewrite_rule" => "^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]" } ]) }
end
