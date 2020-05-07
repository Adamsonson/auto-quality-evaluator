# frozen_string_literal: true

require_relative '../main.rb'

describe '#analyze' do
  it 'should return a hash' do
    expect(execute).to be_a Hash
  end

  it 'should return evaluation hash for a simple log file' do
    expect(execute).to eq({ 'temp-1' => 'precise',
                            'temp-2' => 'ultra precise',
                            'hum-1' => 'keep',
                            'hum-2' => 'discard',
                            'mon-1' => 'keep',
                            'mon-2' => 'keep' })
  end
end
