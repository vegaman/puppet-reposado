Puppet::Functions.create_function(:catalog_url) do
  dispatch :catalog_url do
    param 'String', :os_name
    return_type 'String'
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
    when 11
      '10.11'
    when 12
      '10.12'
    when 13
      '10.13'
    else
      '10.14'
    end
  end

  def catalog_url(os_name)
    case os_name
    when '10.4'
      '/content/catalogs/index'
    when '10.6', 'snowleopard'
      # doesn't follow the usual pattern
      '/content/catalogs/others/index-leopard-snowleopard.merged-1'
    else
      os_minor_version = call_function('os_minor_version', os_name)
      os_minor_versions = (5..os_minor_version).to_a.reverse
      url = os_minor_versions.map { |o| os_name_in_catalog_url(o) }.join('-')
      "/content/catalogs/others/index-#{url}.merged-1"
    end
  end
end
