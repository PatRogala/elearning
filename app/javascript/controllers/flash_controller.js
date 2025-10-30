import { Controller } from "@hotwired/stimulus"

// Handles show/hide animations and auto-dismiss for flash messages
export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 4000 }
  }

  connect() {
    // Animate in
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0", "translate-y-2")
    })

    // Auto-dismiss
    this.dismissTimer = setTimeout(() => this.dismiss(), this.timeoutValue)
  }

  disconnect() {
    if (this.dismissTimer) clearTimeout(this.dismissTimer)
  }

  dismiss() {
    this.element.classList.add("opacity-0", "translate-y-2")
    // Remove after transition
    setTimeout(() => this.element.remove(), 300)
  }
}


