# frozen_string_literal: true

require '../elves_data'

include ElvesData

@data = ElvesData.read_file('../input/08_input.txt', /\n/)

# visible rows outside are
# # top row
# data[0].split('').to_s
# # data[99] - bottom row
# data[-1].split('').to_s

def trees
  @trees = {}
  @max = @data.length - 1
  @data.each_with_index do |line, x|
    line.chars.each_with_index.map { |tree, y| @trees[[x, y]] = tree.to_i }
  end
end

def check_neighbor(coord, height)
  x, y = coord
  return 1 if x.zero? || x == @max || y.zero? || y == @max

  up = (0..(x - 1)).map { |tx| @trees[[tx, y]] }.max
  down = ((x + 1)..@max).map { |tx| @trees[[tx, y]] }.max
  left = (0..(y - 1)).map { |ty| @trees[[x, ty]] }.max
  right = ((y + 1)..@max).map { |ty| @trees[[x, ty]] }.max

  height > [up, down, left, right].min ? 1 : 0
end

def max_scene(coord, height)
  x, y = coord
  return 0 if x.zero? || x == @max || y.zero? || y == @max

  up, down, left, right = 1, 1, 1, 1
  up += 1 until @trees[[x - up, y]].nil? || @trees[[x - up, y]] >= height || (x - up).zero?
  down += 1 until @trees[[x + down, y]].nil? || @trees[[x + down, y]] >= height || x + down == @max
  left += 1 until @trees[[x, y - left]].nil? || @trees[[x, y - left]] >= height || (y - left).zero?
  right += 1 until @trees[[x, y + right]].nil? || @trees[[x, y + right]] >= height || y + right == @max

  up * down * left * right
end

def part1
  trees
  @trees.map { |coord, height| check_neighbor(coord, height) }.sum
end

def part2
  trees
  @trees.map { |coord, height| max_scene(coord, height) }.max
end

puts part1
puts part2