module Puppet::Parser::Functions
  newfunction(:catalog_urls, :type => :rvalue) do |args|
    os_names = args[0]
    os_names.map do |o|
      url = function_catalog_url([o])
      if url.start_with?("/content/catalogs/others/index-10")
        "https://swscan.apple.com" + url + ".sucatalog"
      else
        "http://swscan.apple.com" + url + ".sucatalog"
      end
    end
  end
end
