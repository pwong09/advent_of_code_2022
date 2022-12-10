# frozen_string_literal: true

require '../elves_data'

# Standard Node class
class Node
  attr_accessor :name, :parent

  def initialize(parent, name)
    @name = name
    @parent = parent
  end

  def children
    {}
  end
end

# Inherits Node class, represents a file
class FileNode < Node
  attr_reader :size

  def initialize(parent, name, size)
    super(parent, name)
    @size = size
  end
end

# Inherits Node class, represents directory
class DirNode < Node
  attr_reader :children

  def initialize(parent, name)
    super
    @children = {}
    @size = nil
  end

  def size
    @size = @children.values.map(&:size).sum if @size.nil?

    @size
  end
end

def parse_ls(lines, cwd)
  lines.each do |line|
    arg, name = line.split(' ')

    cwd.children[name] =  if arg == 'dir'
                            DirNode.new(cwd, name)
                          else
                            FileNode.new(cwd, name, arg.to_i)
                          end
  end
end

def crawl_size(max_size, root)
  total = 0

  root_size = root.size
  total += root_size if root_size <= max_size

  root.children.each_value do |child|
    next if child.instance_of?(FileNode)

    total += crawl_size(max_size, child)
  end

  total
end

def crawl_largest(required_size, root)
  large_enough = []
  large_enough << root.size if root.size >= required_size
  large_enough << root.children.values.map { |c| crawl_largest(required_size, c) }
end

file = File.open('../input/07_input.txt')
root = DirNode.new(nil, '/')
cwd = root

blocks = file.read.split('$').drop(2)
file.close

blocks.each do |block|
  lines = block.strip.split("\n")
  command = lines.shift

  if command.start_with?('cd')
    dir = command.delete_prefix('cd ')

    cwd = if dir == '..'
            cwd.parent
          else
            cwd = cwd.children[dir]
          end
  elsif command.start_with?('ls')
    parse_ls(lines, cwd)
  end
end

puts crawl_size(100_000, root)

required = root.size + 30_000_000 - 70_000_000
puts crawl_largest(required, root).flatten.sort.shift

# pattern matching method
def solve(input)
  commands = File.read(input).split('$ ').reject(&:empty?).map { _1.split("\n").map(&:split) }
  dirs = Hash.new(0)
  cwd = []

  commands.each do |cmd, *args|
    case cmd
    in ['ls']
      total_contents_size = args.sum { |size, _fname| size.to_i }
      (0..cwd.size).each do |i|
        dirs[cwd[0, i]] += total_contents_size
      end
    in ['cd', '..'] then cwd.pop
    in ['cd', '/'] then cwd = []
    in ['cd', dir] then cwd.push(dir)
    else warn "unknown command #{cmd}"
    end
  end
  # Part 1
  puts dirs.values.reject { _1 > 100_000 }.sum

  # Part 2
  total = 70_000_000
  required = 30_000_000
  free = total - dirs[[]]
  required -= free
  puts dirs.values.select { |size| size >= required }.min
end

puts solve('../input/07_input.txt')
