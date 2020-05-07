# frozen_string_literal: true

require_relative 'lib/helper_methods'

DEFAULT_LOG_PATH = 'inpt/log.txt'
INPUT = ARGV.uniq == [] ? DEFAULT_LOG_PATH : ARGV.uniq * ','
THREAD_LIMIT = 5

def execute
  evaluate(INPUT, THREAD_LIMIT)
end

puts execute
