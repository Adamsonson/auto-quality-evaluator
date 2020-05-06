# frozen_string_literal: true

require 'descriptive_statistics'

# Analyzes sensor based on input
class Sensor
  attr_accessor :type, :name, :data, :reference

  def analyze
    return temp_eval if type == 'thermometer'
    return hum_eval if type == 'humidity'
    return mon_eval if type == 'monoxide'

    'Sensor not supported - need to update it within Sensor Evaluator'
  end

  def temp_eval
    temp_val_arr = values_array
    avg_diff = average_diff(temp_val_arr)
    deviation = standard_deviation(temp_val_arr)

    return 'ultra precise' if avg_diff < 0.5 && deviation < 3
    return 'very precise' if avg_diff < 0.5 && deviation < 5

    'precise'
  end

  def hum_eval
    return 'keep' if average_diff(values_array) < 1

    'discard'
  end

  def mon_eval
    return 'keep' if average_diff(values_array) < 3

    'discard'
  end

  def values_array
    data.map { |x| x[:reading].to_i }
  end

  def average_diff(values)
    (reference[type.to_sym].to_i - average(values)).abs
  end

  def average(array)
    array.sum(0.0) / array.size
  end

  def standard_deviation(val_arr)
    val_arr.standard_deviation
  end
end
