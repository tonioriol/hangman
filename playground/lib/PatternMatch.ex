defmodule PatternMatch do

  @doc """
  function that takes a two-element tuple as a parameter, and
  uses pattern matching to return a two element tuple with the values
  swapped (so pass it `{2,5}`  and you'll get `{5,2}` back).
  """
  def flip({a, b}) do
    {b, a}
  end

  @doc """
  a function that takes two parameters. It should return `true`
  if the parameters are the same, `false` others. You aren't allowed
  to use any conditional logic, so you'll have to rely on pattern
  matching.
  """
  def equal(a, a), do: true
  def equal(_, _), do: false

end
