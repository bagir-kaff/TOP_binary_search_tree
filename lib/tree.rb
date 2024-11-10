require_relative "node"

class Tree
  attr_accessor :array, :root

  def initialize(array)
    @root = nil
    @array = array
  end

  def build_tree(array,start=0,ending=array.uniq.sort.length - 1)
    return nil if start > ending

    array = array.uniq.sort
    mid = (start+ending)/2
    node = Node.new(array[mid])
    node.left = build_tree(array,start,mid-1)
    node.right = build_tree(array,mid+1,ending)
    self.root = node
    return node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    if node.nil?
      puts "the tree is empty"
      return nil
    end

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, current_node = @root)

    return Node.new(data)  if current_node == nil

    return data  if current_node == data #for duplicates

    if data < current_node.data
      current_node.left = insert(data, current_node.left)
    elsif data > current_node.data
      current_node.right = insert(data, current_node.right)
    end

    return current_node
  end

end
