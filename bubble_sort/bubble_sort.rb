#!/usr/bin/env ruby
# frozen_string_literal: true

def bubble_sort(items)
  items.length.downto(0) do |n|
    (n - 1).times do |i|
      items[i], items[i + 1] = items[i + 1], items[i] if items[i] > items[i + 1]
    end
  end
  items
end

def bubble_sort_by(items)
  items.length.downto(0) do |n|
    (n - 1).times do |i|
      if yield(items[i], items[i + 1]).positive?
        items[i], items[i + 1] = items[i + 1], items[i]
      end
    end
  end
  items
end

ary = %w[18 5 7 1 68 2 19 4 1 177 9 -3].map(&:to_i)
print "#{bubble_sort(ary)}\n"

ary2 = %w[hello hi hola heyho! hallo moin hey]
print "#{bubble_sort_by(ary2) { |left, right| left.length - right.length }}\n"
