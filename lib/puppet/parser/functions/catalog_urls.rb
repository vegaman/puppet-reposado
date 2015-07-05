module Puppet::Parser::Functions
  newfunction(:catalog_urls, :type => :rvalue) do |args|
    os_names = args[0]
    os_names.map { |o| function_catalog_url([o]) }
  end
end
