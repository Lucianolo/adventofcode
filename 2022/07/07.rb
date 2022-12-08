class Tree
  attr_accessor :children, :name, :size, :parent

  def initialize(name, size, parent = nil)
    @parent = parent
    @name = name
    @size = size
    @children = []
  end
end

@total = 0
@current_best = 70_000_000

def generate_fs(input)
  root = Tree.new('/', nil)
  create_tree(root, input)
  root.children.each do |node|
    node.size = calculate_size(node)
  end
  fs_size = 70_000_000
  update_size = 30_000_000
  used_space = root.children.reduce(0) { |tot, node| tot + node.size }
  available = fs_size - used_space
  needed = update_size - available
  find_smallest_to_delete(root, needed)
  @current_best
end

def find_smallest_to_delete(node, needed)
  return unless node.children.any?

  if node.size && node.size >= needed
    @current_best = node.size < @current_best ? node.size : @current_best
  end
  node.children.each do |child|
    find_smallest_to_delete(child, needed)
  end
end

def calculate_size(node)
  if node.size.nil?
    node.size = node.children.reduce(0) { |tot, node| tot + calculate_size(node) }
    @total += node.size unless node.nil? || node.size > 100_000
  end
  node.size
end

def create_tree(root, input)
  current_node = root
  input.split("\n").each do |command|
    if command.include? '$ cd'
      child_dir = command.match(/\$ cd (.+)/)
      if child_dir
        prev_node = current_node
        current_node = case child_dir[1]
                       when '..'
                         prev_node.parent
                       when '/'
                         root
                       else
                         prev_node.children.find{ |node| node.name == child_dir[1] }
                       end
      end
    elsif command.include? 'dir'
      child_dir = command.match(/dir (.+)/)
      if child_dir
        new_dir_name = child_dir[1]
        current_node.children << Tree.new(new_dir_name, nil, current_node)
      end
    else
      matches = command.match(/(\d+) (.+)/)
      current_node.children << Tree.new(matches[2], matches[1].to_i, current_node) if matches
    end
  end
end

input = File.read(File.join(__dir__, 'input.txt'))
puts generate_fs(input)
