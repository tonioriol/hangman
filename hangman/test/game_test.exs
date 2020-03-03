defmodule GameTest do
  use ExUnit.Case
  doctest Hangman

  alias Hangman.Game

  test "new returns a structure" do
    game = Game.new()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    Enum.map(
      game.letters
      |> Enum.join
      |> String.to_charlist,
      fn x ->
        assert x >= ?a && x <= ?z
      end
    )
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new()
             |> Map.put(:game_state, state)

      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "first occurrence of letter is already used" do
    game = Game.new()

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used

    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end
end
