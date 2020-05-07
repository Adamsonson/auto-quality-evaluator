# frozen_string_literal: true

require_relative 'sensor_evaluator'

def evaluate(input)
  contents = read(input)
  SensorEvaluator.new(contents).evaluate
end

def read(file)
  return File.open(file).read if File.exist? File.expand_path(file)

  file
end
