# frozen_string_literal: true

# Data model that extracts file and parses based on requirements
module ElvesData
  # Splits a text file per regex (like a line break, blank line, comma, etc)
  #
  # @params String: file name
  # @returns Array
  def read_file(file, regex)
    File.read(file).split(regex)
  end

  # Maps a new array summing each elf's inventory using a line break
  #
  # @params Array
  # @returns sorted Array
  def sum(array)
    array.map { |el| el.split(/\n/).map(&:to_f).reduce(:+) }.sort
  end
end
