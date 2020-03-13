import HangmanSocket from './hangman_socket.js'

window.onload = () => {
  const hangman = new HangmanSocket()
  hangman.connectToHangman()
}
