require 'spec_helper'

describe 'split' do
  it 'should return correct values' do
    expect { subject.call('aoeu', 'o').to_eq(['a', 'eu']) }
  end

  expected_error = ArgumentError

  it 'should fail with one argument - match exception type' do
    expect { subject.call(['foo']) }.to raise_error(expected_error)
  end

  it 'should fail with one argument - match exception type and message' do
    expect { subject.call(['foo']) }.to raise_error(expected_error, /called with mis-matched arguments/)
  end

  it 'should fail with one argument - match exception message' do
    expect { subject.call(['foo']) }.to raise_error(/called with mis-matched arguments/)
  end
end
