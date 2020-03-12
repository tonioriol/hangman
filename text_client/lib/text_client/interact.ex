defmodule TextClient.Interact do

  @hangman_server :hangman@plasma

  alias TextClient.{Player, State}

  def start() do
    new_game()
    |> setup_state()
    |> Player.play()
  end

  def setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

  defp new_game() do
    :rpc.call(@hangman_server, Hangman, :new, [])
  end
end
