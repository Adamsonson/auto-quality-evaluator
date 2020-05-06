# frozen_string_literal: true

# require 'open-uri'
require_relative 'sensor_evaluator'

def evaluate(input)
  contents = read(input)
  SensorEvaluator.new(contents).evaluate
end

def read(file)
  File.open(file).read
end
