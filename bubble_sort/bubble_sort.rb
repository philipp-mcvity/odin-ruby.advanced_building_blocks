#!/usr/bin/env ruby
# frozen_string_literal: true

def bubble_sort(array)
  swaps = 1
  i = 1
  while swaps.positive?
    swaps = 0
    (0...array.length - i).each do |index|
      if (array[index] <=> array[index + 1]) == 1
        array[index], array[index + 1] = array[index + 1], array[index]
        swaps += 1
      end
    end
    i += 1
  end
  p array
end

bubble_sort([4, 3, 78, 2, 0, 2])
