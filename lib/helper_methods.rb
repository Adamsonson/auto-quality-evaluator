# frozen_string_literal: true

require_relative 'sensor_evaluator'

def evaluate(input, threads)
  contents = read(input)
  SensorEvaluator.new(contents, threads).evaluate
end

def read(file)
  return File.open(file).read if File.exist? File.expand_path(file)

  file
end
