import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["menu", "telegramQrcode"]

  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle('hidden')
  }

  linkTelegram() {
    fetch('/telegrams/link',{
      headers: { 'Accept': 'text/plain' }
    }).then(res => console.log(res.text))

    this.telegramQrcodeTarget.classList.toggle('hidden')
  }

  closeLinkTelegram() {
    this.telegramQrcodeTarget.classList.toggle('hidden')
    this.menuTarget.classList.toggle('hidden')
  }
}
