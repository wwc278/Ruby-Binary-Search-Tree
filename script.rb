#!/usr/bin/env ruby

require './tree_set_nodes'
require 'set'
require 'gnuplot'
require 'debugger'

n = BinarySearchTree.new

num_el_arr = [1, 10, 1e2, 1e3, 1e4, 1e5]
time_bst = []
time_arr = []

num_el_arr.each do |num_el|
  s = (1..num_el).to_a.shuffle
  s.each do |el|
    n.add_value(el)
  end

  start_time = Time.now
  n.find_value(num_el + 1)
  end_time = Time.now
  time_bst << (end_time - start_time)

  start_time = Time.now
  s.include?(num_el + 1)
  end_time = Time.now
  time_arr << (end_time - start_time)
end

p time_bst
p time_arr

Gnuplot.open { |gp|
    Gnuplot::Plot.new( gp ) { |plot|
        plot.output "testgnu.pdf"
        # plot.terminal "pdf colour size 27cm,19cm"

        plot.xrange "[1:10]"
        plot.title  "BST vs Arr"
        plot.ylabel "t [s]"
        plot.xlabel "x"

        x = (1..num_el_arr.length).to_a
        plot.data << Gnuplot::DataSet.new( [x, time_bst] ) do |ds|
            ds.with = "linespoints"
            ds.linewidth = 5
        end

        plot.data << Gnuplot::DataSet.new( [x, time_arr] ) do |ds|
            ds.with = "linespoints"
            ds.linewidth = 5
        end
    }
}