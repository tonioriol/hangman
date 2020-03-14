import { Socket } from 'phoenix'

export default class HangmanSocket {
  constructor() {
    this.socket = new Socket('/socket', {})
    this.socket.connect()
  }

  connectToHangman() {
    this.setupChannel()
    this.channel.on('send_tally', tally => {
      console.dir(tally)
    })

  }

  setupChannel() {
    this.channel = this.socket.channel('hangman:game', {})
    this.channel
      .join()
      .receive('ok', resp => {
        console.log('connected: ', resp)
        this.requestTally()
      })
      .receive('error', resp => {
        console.log('Error: ', resp)
        throw(resp)
      })
  }

  requestTally() {
    this.channel.push('request_tally', {})
  }
}
