def rewrite_condition(os_name)
  os_minor_version = function_os_minor_version([os_name])
  darwin_version = os_minor_version + 4
  "%{HTTP_USER_AGENT} Darwin/#{darwin_version}"
end

def rewrite_rule(os_name)
  catalog_url = function_catalog_url([os_name])
  "^/index(.*)\.sucatalog$ #{catalog_url}$1.sucatalog [L]"
end

def rewrite(os_name)
  { 'rewrite_cond' => rewrite_condition(os_name),
    'rewrite_rule' => rewrite_rule(os_name) }
end

module Puppet::Parser::Functions
  newfunction(:rewrite_rules, :type => :rvalue) do |args|
    info("args[0]: #{args[0]}")
    os_names = args[0]
    os_names.map { |o| rewrite(o) }
  end
end
