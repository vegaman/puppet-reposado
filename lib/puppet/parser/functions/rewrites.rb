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

def catalog_url(os_name)
  os_minor_version = function_os_minor_version([os_name])
  os_minor_versions = (5..os_minor_version).to_a.reverse
  url = os_minor_versions.map { |o| os_name_in_catalog_url(o) }.join('-')
  "/content/catalogs/others/index-#{url}.merged-1"
end

def rewrite_cond(os_name)
  darwin_version = os_minor_version(os_name) + 4
  "%{HTTP_USER_AGENT} Darwin/#{darwin_version}"
end

def rewrite_rule(os_name)
  catalog_url = catalog_url(os_name)
  "^/index(.*)\.sucatalog$ #{catalog_url}$1.sucatalog [L]"
end

def rewrite(os_name)
  { "rewrite_cond" => rewrite_cond(os_name), "rewrite_rule" => rewrite_rule(os_name) }
end

module Puppet::Parser::Functions
  newfunction(:rewrites, :type => :rvalue) do |args|
    os_names = args[0]
    os_names.map { |o| rewrite(o) }
  end
end
