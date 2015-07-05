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

module Puppet::Parser::Functions
  newfunction(:catalog_urls, :type => :rvalue) do |args|
    os_minor_version = function_os_minor_version([args[0]])
    os_minor_versions = (5..os_minor_version).to_a.reverse
    '/content/catalogs/others/index-' + os_minor_versions.map { |o| os_name_in_catalog_url(o) }.join('-') + '.merged-1'
  end
end
