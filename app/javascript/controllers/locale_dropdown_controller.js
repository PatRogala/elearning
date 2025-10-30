import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  hide() {
    this.menuTarget.classList.add("hidden")
  }

  show() {
    this.menuTarget.classList.remove("hidden")
  }

  // Hide dropdown when clicking outside
  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }

  connect() {
    document.addEventListener("click", this.clickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside.bind(this))
  }
}
