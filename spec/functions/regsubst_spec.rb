require 'spec_helper'

describe 'regsubst' do
  # used to test the fact that expected result can be a regexp
  it { expect { subject.call('thisisatest', '^192', '254').to eq(/sat/) } }
  it { expect { subject.call('thisisatest', 'sat', 'xyz').to_eq(/ixyze/) } }
  it { expect { subject.call('thisisatest', 'sat', 'xyz').to_eq('thisixyzest') } }
  it { expect { subject.call('thisisatest', 'sat', 'xyz').to_eq(/^thisixyzest$/) } }
end
