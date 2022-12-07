# frozen_string_literal: true

require '../elves_data'

@directories = {}

class Folder
  attr_accessor :file_size, :directories

  def initialize(path:)
    @path = path
    @files = []
    @subdirectories = []
    @directories[path] = self
    @file_size = 0
  end

  def add_directory(name:)
    @subdirectories.push(Folder.new(path: @path.dup.push(name)))
  end

  def total_size
    @subdirectories.map(&:total_size).sum + file_size
  end
end

raw_input = File.read('../input/07_input.txt').split("\n$")
puts raw_input.class
current_path = []
Folder.new(path: [])
raw_input.each do |part|
  if part[0..2] == ' cd'
    case rel_path = part.gsub(' cd ', '')
    when '..'
      current_path.pop
    when '/'
      current_path = []
    else
      current_path.push(rel_path)
    end
  else
    nodes = part.split("\n")[1..]
    nodes.each do |node|
      if node[0..2] == 'dir'
        name = node.gsub('dir ', '')
        @directories[current_path].add_directory(name: name)
      else
        size = node.split(' ')[0]
        @directories[current_path].file_size += size.to_i
      end
    end
  end
end

part1 = @directories.values.select { _1.total_size < 100_000 }.map(&:total_size).sum
puts "Part 1: #{part1}"

memory_to_delete = @directories[[]].total_size - 40_000_000

smallest_dir = @directories.values.map(&:total_size).sort.find { _1 >= memory_to_delete }
puts "Part 2: #{smallest_dir}"