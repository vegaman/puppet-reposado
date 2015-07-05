def os_minor_version(os_name)
  case os_name
  when 'leopard', '10.5'
    5
  when 'snowleopard', '10.6'
    6
  when 'lion', '10.7'
    7
  when 'mountainlion', '10.8'
    8
  when 'mavericks', '10.9'
    9
  when 'yosemite', '10.10'
    10
  else
    11
  end
end

def os_name_in_catalog_url(os_minor_version)
  case os_minor_version
  when 5
    'leopard'
  when 6
    'snowleopard'
  when 7
    'lion'
  when 8
    'mountainlion'
  when 9
    '10.9'
  when 10
    '10.10'
  else
    '10.11'
  end
end

def darwin_version(os_name)
  case os_name
  when 'leopard', '10.5'
    9
  when 'snowleopard', '10.6'
    10
  when 'lion', '10.7'
    11
  when 'mountainlion', '10.8'
    12
  when 'mavericks', '10.9'
    13
  when 'yosemite', '10.10'
    14
  else
    15
  end
end

def catalog_url(os_name)
  os_minor_versions = (5..os_minor_version(os_name)).to_a.reverse
  '/content/catalogs/others/index-' + os_minor_versions.map { |o| os_name_in_catalog_url(o) }.join('-') + '.merged-1'
end

def rewrite_condition(os_name)
  ""
end

def rewrite_rule(os_name)
  catalog_url = catalog_url([os_name])
  "^/index(.*)\.sucatalog$ #{catalog_url}$1.sucatalog [L]"
end

def rewrite(os_name)
  { 'rewrite_cond' => "",
    'rewrite_rule' => rewrite_rule(os_name) }
end

module Puppet::Parser::Functions
  newfunction(:rewrite_rules, :type => :rvalue) do |args|
    info("args[0]: #{args[0]}")
    os_names = args[0]
    []
  end
end
