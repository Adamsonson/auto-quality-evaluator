# frozen_string_literal: true

require_relative 'lib/helper_methods'

DEFAULT_LOG_PATH = 'inpt/log.txt'
INPUT = ARGV.uniq == [] ? DEFAULT_LOG_PATH : ARGV.uniq * ','

def execute
  evaluate(INPUT)
end

puts execute
