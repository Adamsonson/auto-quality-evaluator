# frozen_string_literal: true

require_relative 'lib/sensor_evaluator'

INPUT = 'lib/inpt/log.txt'

def execute
  SensorEvaluation.new(INPUT).evaluate
end

p execute
