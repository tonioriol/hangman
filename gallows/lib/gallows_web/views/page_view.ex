defmodule GallowsWeb.PageView do
  use GallowsWeb, :view

  def plural_of(word, amount = 1), do: "#{amount} #{word}"
  def plural_of(word, amount), do: "#{amount} #{word}s"
end
