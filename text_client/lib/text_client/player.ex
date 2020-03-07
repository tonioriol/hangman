defmodule TextClient.Player do

  alias TextClient.{State, Summary, Prompter, Mover}

  def play(
        %State{
          tally: %{
            game_state: :won
          }
        }
      ) do
    exit_w_message("You won.")
  end

  def play(
        %State{
          tally: %{
            game_state: :lost
          }
        }
      ) do
    exit_w_message("You lost.")
  end

  def play(
        game = %State{
          tally: %{
            game_state: :good_guess
          }
        }
      ) do
    continue_w_message(game, "Good guess.")
  end

  def play(
        game = %State{
          tally: %{
            game_state: :bad_guess
          }
        }
      ) do
    continue_w_message(game, "Bad guess.")
  end

  def play(
        game = %State{
          tally: %{
            game_state: :already_used
          }
        }
      ) do
    continue_w_message(game, "You've already used that letter.")
  end

  def play(
        game = %State{
          tally: %{
            game_state: :invalid_guess
          }
        }
      ) do
    continue_w_message(game, "You've made an invalid guess.")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def make_move(game) do
    game
  end

  defp continue_w_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_w_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
