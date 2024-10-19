require_relative 'node'
class Tree
  attr_accessor :array, :root

  def initialize(array)
    @array = array
  end

  def build_tree(array,start,ending=array.length)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
pohon = Tree.new(array)
pohon.root = pohon.build_tree(array, 0)
# p pohon.root
pohon.pretty_print
