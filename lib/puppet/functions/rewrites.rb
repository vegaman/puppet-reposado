Puppet::Functions.create_function(:rewrites) do
  dispatch :rewrites do
    param 'Array[String]', :catalogs
    return_type 'Array[Hash[String, String]]'
  end

  def rewrite_cond(os_name)
    darwin_version = call_function('os_minor_version', os_name) + 4
    "%{HTTP_USER_AGENT} Darwin/#{darwin_version}"
  end

  def rewrite_rule(os_name)
    catalog_url = call_function('catalog_url', os_name)
    "^/index(.*)\.sucatalog$ #{catalog_url}$1.sucatalog [L]"
  end

  def rewrite(os_name)
    { 'rewrite_cond' => rewrite_cond(os_name), 'rewrite_rule' => rewrite_rule(os_name) }
  end

  def rewrites(catalogs)
    os_names = catalogs.empty? ? (4..13).to_a.map { |o| "10.#{o}" } : catalogs
    os_names.map { |o| rewrite(o) }
  end
end
