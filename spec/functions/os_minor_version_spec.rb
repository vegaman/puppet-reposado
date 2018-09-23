require 'spec_helper'

describe 'os_minor_version' do
  it { is_expected.to run.with_params('10.4').and_return(4) }
  it { is_expected.to run.with_params('10.5').and_return(5) }
  it { is_expected.to run.with_params('10.6').and_return(6) }
  it { is_expected.to run.with_params('10.7').and_return(7) }
  it { is_expected.to run.with_params('10.8').and_return(8) }
  it { is_expected.to run.with_params('10.9').and_return(9) }
  it { is_expected.to run.with_params('10.10').and_return(10) }
  it { is_expected.to run.with_params('10.11').and_return(11) }
  it { is_expected.to run.with_params('10.12').and_return(12) }
  it { is_expected.to run.with_params('10.13').and_return(13) }
  it { is_expected.to run.with_params('10.14').and_return(14) }
  it { is_expected.to run.with_params('10.42').and_return(14) }
  it { is_expected.to run.with_params('leopard').and_return(5) }
  it { is_expected.to run.with_params('snowleopard').and_return(6) }
  it { is_expected.to run.with_params('lion').and_return(7) }
  it { is_expected.to run.with_params('mountainlion').and_return(8) }
  it { is_expected.to run.with_params('mavericks').and_return(9) }
  it { is_expected.to run.with_params('yosemite').and_return(10) }
  it { is_expected.to run.with_params('elcapitan').and_return(11) }
  it { is_expected.to run.with_params('sierra').and_return(12) }
  it { is_expected.to run.with_params('highsierra').and_return(13) }
  it { is_expected.to run.with_params('mojave').and_return(14) }
  it { is_expected.to run.with_params('elsnowmountainsierra').and_return(14) }
end
