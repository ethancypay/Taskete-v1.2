import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["menu", "background", "telegramQrcode", "linkbtn"]

  connect() {
  }

  toggle() {
    this.menuTarget.classList.toggle('hidden')
  }

  linkTelegram() {
    fetch('/telegrams/link', {
      headers: { 'Accept': 'text/plain' }
    })
    .then(res => res.text())
    .then(this.generateQr.bind(this))

    this.backgroundTarget.classList.toggle('hidden')
  }

  generateQr(svg) {
    this.telegramQrcodeTarget.innerHTML = svg;
  }

  closeLinkTelegram() {
    this.backgroundTarget.classList.toggle('hidden')
    this.menuTarget.classList.toggle('hidden')
    this.telegramQrcodeTarget.innerHTML = '';
  }

  unlinkTelegram() {
    fetch('/telegrams/unlink', {
      headers: { 'Accept': 'text/plain' }
    })
      .then(res => res.text())
      .then(this.unlinkSuccess.bind(this))

    this.backgroundTarget.classList.toggle('hidden');
  }

  unlinkSuccess(reply) {
    this.telegramQrcodeTarget.innerHTML = reply;
    this.linkbtnTarget.dataset.action = "click->account-dropdown#linkTelegram"
    this.linkbtnTarget.children[0].innerHTML = 'Link Telegram'
  }
}
