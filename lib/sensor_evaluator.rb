# frozen_string_literal: true

require 'thread/pool'

require_relative 'file_decorator'
require_relative 'sensor'

# Evaluates sensor log
class SensorEvaluator
  def initialize(log_contents_str, threads)
    @log_contents_str = log_contents_str
    @sensors = %w[thermometer humidity monoxide]
    @log = FileDecorator.new(@log_contents_str, @sensors)
    @threads = threads
  end

  def evaluate
    analyze_sensors
  end

  def return_hash
    @log.to_hash
  end

  def build_sensor(sensor, reference)
    new_sensor = Sensor.new

    new_sensor.type = sensor[:type]
    new_sensor.name = sensor[:name]
    new_sensor.data = sensor[:data]
    new_sensor.reference = reference
    new_sensor
  end

  def analyze(sensor, reference)
    new_sensor = build_sensor(sensor, reference)
    new_sensor.analyze
  end

  def analyze_sensors
    analyzed_hash = return_hash
    final_hash = {}

    pool = Thread.pool(@threads)

    analyzed_hash[:data].each do |sensor|
      pool.process do
        final_hash[sensor[:name]] = analyze(sensor, analyzed_hash[:reference])
      end
    end

    pool.shutdown

    final_hash
  end
end
