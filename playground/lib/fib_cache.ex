defmodule FibCache do

  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def add(agent, item) do
    Agent.update(
      agent,
      fn state ->
        {state, Map.put(state, item)}
      end
    )
  end

  def get(agent) do
    Agent.get(agent, &(&1))
  end
end
