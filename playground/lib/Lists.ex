defmodule Lists do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def double([]), do: []
  def double([head | tail]), do: [2 * head | double(tail)]

  def square([]), do: []
  def square([head | tail]), do: [head * head | double(tail)]
end
