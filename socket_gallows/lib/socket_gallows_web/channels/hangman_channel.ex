defmodule SocketGallowsWeb.HangmanChannel do

  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    game = Hangman.new()
    socket = assign(socket, :game, game)
    {:ok, socket}
  end

  def handle_in("request_tally", _, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "send_tally", tally)
    {:noreply, socket}
  end

  def handle_in(key, _, socket) do

    require Logger

    Logger.error("Invalid key: " <> key)

    {:noreply, socket}
  end
end
