Puppet::Functions.create_function(:os_minor_version) do
  dispatch :os_minor_version do
    param 'String', :os_full_version
    return_type 'Integer'
  end

  def os_minor_version(os_full_version)
    case os_full_version
    when '10.4'
      4
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
    when 'elcapitan', '10.11'
      11
    when 'sierra', '10.12'
      12
    when 'highsierra', '10.13'
      13
    else
      14
    end
  end
end
