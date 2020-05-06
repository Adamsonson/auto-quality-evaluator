# frozen_string_literal: true

require_relative 'file_decorator'
require_relative 'sensor'

# Evaluates sensor log
class SensorEvaluator
  def initialize(log_contents_str)
    @log_contents_str = log_contents_str
    @sensors = %w[thermometer humidity monoxide]
    @log = FileDecorator.new(@log_contents_str, @sensors)
    @sensor = Sensor.new
  end

  def evaluate
    @log.to_hash
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