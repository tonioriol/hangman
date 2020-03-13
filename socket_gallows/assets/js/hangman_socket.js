import { Socket } from 'phoenix'

export default class HangmanSocket {
  constructor() {
    this.socket = new Socket('/socket', {})
    this.socket.connect()
  }

  connectToHangman() {
    this.channel = this.socket.channel('hangman:game', {})
    this.channel.join()
  }
}
