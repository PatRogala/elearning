import { Controller } from "@hotwired/stimulus"

// Handles show/hide animations and auto-dismiss for flash messages
export default class extends Controller {
  connect() {
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0", "translate-y-2")
    })

    setTimeout(() => {
      this.dismiss()
    }, 5000)
  }

  dismiss() {
    this.element.classList.add("opacity-0", "translate-y-2")

    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}


