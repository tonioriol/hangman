defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new(word) do
    %Hangman.Game{
      letters: word
               |> String.codepoints
    }
  end

  def new() do
    Dictionary.random_word
    |> new()
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.used, guess))
    {game, tally(game)}
  end

  def accept_move(game, _guess, _guessed? = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _guessed?) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.letters)
                |> MapSet.subset?(game.used)
                |> maybe_won()
    Map.put(game, :game_state, new_state)
  end

  def score_guess(game, _good_guess) do
    #    won? -> :won, :good_guess
    game
  end

  def maybe_won(true), do: :won
  def maybe_won(_), do: :good_guess

  def tally(_game) do
    123
  end
end
