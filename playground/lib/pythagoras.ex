defmodule Pythagoras do

  def triples_normal do
    for a <- 1..100, b <- 1..100, c <- 1..100, (a * a) + (b * b) == (c * c), do: {a, b, c}
  end

  def triples_normal_len do
    length for a <- 1..100, b <- 1..100, c <- 1..100, do: {a, b, c}
  end

  def triples_opt do
    for a <- 1..100, b <- (a + 1)..100, c <- (b + 1)..100, (a * a) + (b * b) == (c * c), do: {a, b, c}
  end

  def triples_opt_len do
    length for a <- 1..100, b <- (a + 1)..100, c <- (b + 1)..100, do: {a, b, c}
  end
end
