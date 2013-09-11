#!/usr/bin/env ruby

class TreeSetNode
  attr_accessor :parent, :value

  attr_reader :left_child, :right_child

  def initialize(value)
    @value = value
    @parent = nil
    @left_child = nil
    @right_child = nil
  end

  def left_child=(child_node)
    @left_child = child_node
    child_node.parent = self
  end

  def right_child=(child_node)
    @right_child = child_node
    child_node.parent = self
  end

end

class BinarySearchTree

  attr_accessor :first_node, :tree_nodes

  def initialize
    @first_node = nil
    @tree_nodes = []
  end

  def find_value(value, current_node = @first_node)
    if current_node == nil
      return nil
    elsif current_node.value == value
      return current_node
    elsif value < current_node.value
      find_value(value, current_node.left_child)
    elsif value > current_node.value
      find_value(value, current_node.right_child)
    end
  end

  def add_values(sorted_array)
    p sorted_array
    if sorted_array.length == 1
      add_value(sorted_array.first)
    else
      add_value(sorted_array[sorted_array.length / 2])
      left = sorted_array[0...sorted_array.length / 2]
      right = sorted_array[sorted_array.length / 2 + 1 .. -1]
      
      add_values(left) if left.length > 0
      add_values(right) if right.length > 0
    end
  end

  def bst_well_formed?(current_node = @first_node, min = -1e99, max = 1e99)
    # verify if the binary search tree is well-formed

    # check that the current node is within the min and max
    current_node.value > min && current_node.value < max &&

    # AND that if the current node has a left child, recursively check that
    (!current_node.left_child || bst_well_formed?(current_node.left_child, 
      min, current_node.value)) &&

    # AND that if the current node has a right child, recursively check that
    (!current_node.right_child || bst_well_formed?(current_node.right_child, 
      current_node.value, max))
  end


  private
  def add_value(value, current_node = @first_node)
    if current_node == nil # first node to be added to the tree
      @first_node = TreeSetNode.new(value)
      @tree_nodes << @first_node

    elsif value < current_node.value # add a node with lesser value
      if current_node.left_child == nil
        new_node = TreeSetNode.new(value)
        current_node.left_child = new_node
        @tree_nodes << new_node
      else
        add_value(value, current_node.left_child)
      end

    elsif value > current_node.value # add a node with greater value
      if current_node.right_child == nil
        new_node = TreeSetNode.new(value)
        current_node.right_child = new_node
        @tree_nodes << new_node
      else
        add_value(value, current_node.right_child)
      end

    else # adding a node that already exists with that value
      p "duplicate detected!"
    end
  end

end
