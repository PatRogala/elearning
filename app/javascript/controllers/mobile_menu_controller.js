import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("Mobile menu controller connected")
  }

  toggle() {
    console.log("Mobile menu controller toggle")
    this.menuTarget.classList.toggle("hidden")
  }
}
