defmodule IaPlayer do

  alias IaPlayer.State

  def start() do
    state = %State{
      game: Hangman.new(),
      letters: MapSet.new(String.codepoints("abcdefghijklmnopqrstuvwxyz"))
    }
    play(state)
  end

  def play(
        state = %State{
          game: %{
            game_state: :lost
          }
        }
      ) do
    IO.puts("LOST.")
  end

  def play(state = %State{}) do
    guess = random_letter(state.letters)
    IO.puts("trying with: #{guess}")
    MapSet.delete(state.letters, guess)
    {game, _tally} = Hangman.make_move(state.game, guess)
    new_state = %State{
      game: game,
      letters: state.letters
    }
    play(new_state)
  end

  def random_letter(letters) do
    rand = letters
           |> Enum.random()

    List.to_string([rand])
  end
end
