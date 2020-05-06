# frozen_string_literal: true

# Formats the file (string) into needed format
class FileDecorator
  def initialize(contents_str, slicers)
    @contents_str = contents_str
    @slicers = slicers
  end

  def to_hash
    final_hash = reference_to_hash

    unreferenced_array.each do |element|
      final_hash[:data] << data_to_hash(element)
    end

    final_hash
  end

  def to_array(arr_sep = "\n")
    @contents_str.split(arr_sep)
  end

  def slice_points
    split_array = to_array

    slice_points = split_array.each_index.select do |i|
      @slicers.any? { |spliter| split_array[i].include? spliter }
    end

    [0] + slice_points << to_array.length
  end

  def to_sliced_array
    array = to_array
    delimiters = slice_points
    sliced_array = []

    delimiters.each_with_index do |val, index|
      unless delimiters[index + 1].nil?
        sliced_array << array[val..delimiters[index + 1] - 1]
      end
    end

    sliced_array
  end

  def reference_to_hash
    ref_arr = to_sliced_array[0][0].split(' ')
    { reference:
      { thermometer: ref_arr[1],
        humidity: ref_arr[2],
        monoxide: ref_arr[3] },
      data: [] }
  end

  def data_to_hash(data_arr)
    header = data_arr[0].split(' ')
    sensor_hash = { type: header[0],
                    name: header[1],
                    data: [] }

    data_arr.drop(1).each do |line|
      temp_arr = line.split(' ')
      sensor_hash[:data] << {temp_arr[0] => temp_arr[1]}
    end

    sensor_hash
  end

  def unreferenced_array
    clean_sliced_array = to_sliced_array
    clean_sliced_array.shift
    clean_sliced_array
  end
end