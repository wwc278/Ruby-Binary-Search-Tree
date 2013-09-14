#!/usr/bin/env ruby

require 'pp'

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

  def add_values(arr)
    arr.each do |el|
      add_value(el)
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

  def to_sorted_array(node = @first_node)
    arr = []

    arr.push(node.value)

    if node.left_child
      to_sorted_array(node.left_child).reverse_each do |el|
        arr.unshift(el)
      end
    end

    if node.right_child
      to_sorted_array(node.right_child).each do |el|
        arr.push(el)
      end
    end

    arr
  end

  def bst_well_formed2?
    sorted_array = to_sorted_array

    sorted_array.each_with_index do |el, i|
      next if i == 0
      return false if el < sorted_array[i - 1]
    end
    true
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