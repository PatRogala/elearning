import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hidden", "button"]

  show() {
    this.hiddenTarget.classList.remove("hidden")
    this.buttonTarget.classList.add("hidden")
  }
}
