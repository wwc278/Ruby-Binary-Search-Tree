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

  def add_value(value, current_node = @first_node)
    if current_node == nil
      @first_node = TreeSetNode.new(value)
      @tree_nodes << @first_node
    elsif value < current_node.value
      if current_node.left_child == nil
        new_node = TreeSetNode.new(value)
        current_node.left_child = new_node
        @tree_nodes << new_node
      else
        add_value(value, current_node.left_child)
      end
    elsif value > current_node.value
      if current_node.right_child == nil
        new_node = TreeSetNode.new(value)
        current_node.right_child = new_node
        @tree_nodes << new_node
      else
        add_value(value, current_node.right_child)
      end
    end
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

end

# if $PROGRAM_NAME == __FILE__
#   n = TreeSetNode.new
#   o = TreeSetNode.new
#   p = TreeSetNode.new

#   n.left_child = o
#   n.right_child = p

#   p n.left_child == o
#   p n.right_child == p  

# end