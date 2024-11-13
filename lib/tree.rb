require_relative "node"

class Tree
  attr_accessor :array, :root

  def initialize(array)
    @root = nil
    @array = array
  end

  def build_tree(arr=@array, start=0, ending=array.uniq.sort.length - 1)
    return nil if start > ending
    arr = arr.uniq.sort
    mid = (start+ending)/2
    node = Node.new(arr[mid])
    node.left = build_tree(arr,start,mid-1)
    node.right = build_tree(arr,mid+1,ending)
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

    return Node.new(data)  if current_node == nil #if reaches nil or if root or tree is nil

    return data  if current_node == data #for duplicates

    if data < current_node.data #visit node with smaller value
      current_node.left = insert(data, current_node.left)
    elsif data > current_node.data #visit node with bigger value
      current_node.right = insert(data, current_node.right)
    end
    #puts back the subtree
    return current_node
  end

  def delete(data, current_node = @root) #complete
    return nil if current_node == nil #if it reaches the end (nil), return nil, stays the same

    if data < current_node.data
      current_node.left = delete(data, current_node.left)
    elsif data > current_node.data
      current_node.right = delete(data, current_node.right)
    else
      if current_node.right.nil? #if current node has no children or only left children
        return current_node.left
      elsif current_node.left.nil? #if current node has only right children
        return current_node.right
      else
        successor = current_node.get_successor
        current_node.data = successor.data
        current_node.right = delete(successor.data, current_node.right)
      end
    end
    return current_node
  end

  def find(value, curr = @root) #returns node
    if curr.nil?
      return nil
    elsif value > curr.data
      return find(value, curr.right)
    elsif value < curr.data
      return find(value, curr.left)
    else
      return curr
    end
  end

  def iter_level_order(root = @root)
    queue = []
    arr = []
    return [] if root.nil?
    queue.push(root)
    while queue.any?
      queue.push(queue[0].left)if queue[0].left != nil
      queue.push(queue[0].right)if queue[0].right != nil
      arr<<queue.shift
    end

    if block_given?
      yield arr
    else
      return arr.collect{|x| x.data}
    end
  end

  def recu_level_order(curr=@root, queue = [], arr = [], add_root = true)
    queue.push(curr) if add_root #execute once

    if queue.empty?
      if block_given?
        yield arr
      else
        return arr.collect{|x| x.data}
      end
    else
      queue.push(queue[0].left) unless queue[0].left.nil?
      queue.push(queue[0].right) unless queue[0].right.nil?
      # p queue.collect{|x| x.data unless x.nil? }
      arr<<queue.shift
      # puts "arr = #{arr}"
      return recu_level_order(curr, queue, arr, false)
    end
  end
end
