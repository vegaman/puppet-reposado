module Puppet::Parser::Functions
  newfunction(:os_minor_version, :type => :rvalue) do |args|
    case args[0]
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
    else
      12
    end
  end
end
