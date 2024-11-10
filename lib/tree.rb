require_relative 'node'
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
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(current_node = root, data)
  end

end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
pohon = Tree.new(array)
pohon.root = pohon.build_tree(array)
pohon.pretty_print
