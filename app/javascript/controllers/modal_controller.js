import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog", "dialogBody"]

  connect() {
    this.modal = new bootstrap.Modal(this.dialogTarget)
    console.log("yo");
  }

  async launch(event) {
    this.modal.show()
    const url = event.currentTarget.dataset.url;

    const response = await fetch(url)
    const html = await response.text()
    this.dialogBodyTarget.innerHTML = html
  }
}
