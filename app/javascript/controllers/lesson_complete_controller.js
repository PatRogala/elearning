import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.completed = false
    this.observer = new IntersectionObserver(this.#onIntersect.bind(this), { threshold: 1.0 })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer.disconnect()
  }

  #onIntersect(entries) {
    if (this.completed) return
    if (!entries[0].isIntersecting) return

    this.completed = true
    fetch(this.urlValue, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content }
    })
  }
}
