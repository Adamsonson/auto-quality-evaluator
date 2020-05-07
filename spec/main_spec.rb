# frozen_string_literal: true

require_relative '../lib/helper_methods.rb'

describe '#sensors_evaluation' do
  it 'should return a hash' do
    expect(evaluate('test', 1)).to be_a Hash
  end

  context 'with sample log data input' do
    let(:sensor) { Sensor.new }
    let(:result) { 'precise' }
    let(:name)   { 'temp-1' }
    let(:type)   { 'thermometer' }
    let(:reference) { { thermometer: '70.0' } }
    let(:data) do
      [{ timestamp: '2007-04-05T22:00', reading: '72.4' },
       { timestamp: '2007-04-05T22:01', reading: '76.0' },
       { timestamp: '2007-04-05T22:02', reading: '79.1' }]
    end

    it 'returns correct sensor evaluation' do
      allow(sensor).to receive(:analyze)
        .and_return(result)

      analyse = Sensor.new
      analyse.name = name
      analyse.type = type
      analyse.data = data
      analyse.reference = reference

      expect(analyse.analyze).to eq result
    end
  end
end
