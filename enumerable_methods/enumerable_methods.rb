#!/usr/bin/env ruby
# frozen_string_literal: true

module Enumerable
  def my_each
    for e in 0...self.length
      yield self[e]
    end
  end

  def my_each_with_index
    for e in 0...self.length
      yield self[e], e
    end
  end

  def my_select
    selection = []
    my_each do |item|
      selection << item if yield(item)
    end
    selection
  end

  def truethy_arg?(item, arg)
    return item.is_a?arg if arg.is_a?Class
    return !(item =~ arg).nil? if arg.is_a?Regexp
  end

  def my_all?(arg = (no_arg = true))
    my_each do |item|
      case block_given?
      when false
        (return false unless item) if no_arg
        (return false unless truethy_arg?(item, arg)) unless no_arg
      else
        return false unless yield(item)
      end
    end
    true
  end

  def my_any?(arg = (no_arg = true))
    my_each do |item|
      case block_given?
      when false
        return true if item && no_arg
        return true if !no_arg && truethy_arg?(item, arg)
      else
        return true if yield(item)
      end
    end
    false
  end

  def my_none?(arg = (no_arg = true))
    my_each do |item|
      case block_given?
      when false
        return false if item && no_arg
        return false if !no_arg && truethy_arg?(item, arg)
      else
        return false if yield(item)
      end
    end
    true
  end

  def my_count
    counter = 0
    return counter = length unless block_given?

    my_each do |item|
      counter += 1 if yield(item)
    end
    counter
  end

  def my_map
    returns = []
    my_each do |item|
      returns << yield(item)
    end
    returns
  end

  def my_inject(arg = (no_arg = true))
    accu = self[0]
    for e in 1...length do
      accu = yield(accu, self[e]) if no_arg
      accu = accu.send(arg, self[e]) unless no_arg
    end
    accu
  end

end

# -----------------------------------------------------------

def multiply_els(array)
  array.my_inject(:*)
end

p multiply_els([2, 4, 5]) #=> 40
