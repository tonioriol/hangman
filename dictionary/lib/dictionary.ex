defmodule Dictionary do
  def hello do
    IO.puts "Hello World"
  end

  def random_word() do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n")
  end
end
