class Node
  attr_accessor :right, :left, :data

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def get_successor #helps delete method in Tree
    curr = self.right
    while curr.left != nil
      curr = curr.left
    end
    return curr
  end
end
