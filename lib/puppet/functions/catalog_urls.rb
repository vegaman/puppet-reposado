Puppet::Functions.create_function(:catalog_urls) do
  dispatch :catalog_urls do
    param 'Array[String]', :os_names
    return_type 'Array[String]'
  end

  def catalog_urls(os_names)
    os_names.map do |o|
      url = call_function('catalog_url', o)
      protocol = url.start_with?("/content/catalogs/others/index-10") ? "https" : "http"
      "#{protocol}://swscan.apple.com#{url}.sucatalog"
    end
  end
end
