# frozen_string_literal: true

require 'thread/pool'

require_relative 'file_decorator'
require_relative 'sensor'

# Evaluates sensor log
class SensorEvaluator
  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
    @sensors = %w[thermometer humidity monoxide]
    @log = FileDecorator.new(@log_contents_str, @sensors)
    @threads = 5
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

    # pool = Thread.pool(@threads)

    analyzed_hash[:data].each do |sensor|
      # pool.process do
        final_hash[sensor[:name]] = analyze(sensor, analyzed_hash[:reference])
      # end
    end

    # pool.shutdown

    final_hash
  end

  # def process_log_hash
  #   @log.to_hash.each |sensor_logs| do
  #     @sensor.analyse(sensor_logs)
  #   end
  # end

  # pseudo code
  # DONE 1. A. open file (in separate class) - FileReader
  # DONE 1. B. process it to certain format (json)
  # 2. process the log file (json) - (where threading might be included) with looping
  # and processing each sensor in separate class SensorType (with another looping)
  # 3. the output should be saving to certain hash - wheather within looping method or inside SensorType class (by global variable?)
  # {
  #   "temp-1": "precise",
  #   "temp-2": "ultra precise",
  #   "hum-1": "keep",
  #   "hum-2": "discard",
  #   "mon-1": "keep",
  #   "mon-2": "discard"
  #   }
  #
  # create simple rspec test based on text_analyzer
    # - is output Hash?
    # - use mockup data - should return certain output based on inserted mockup data
end