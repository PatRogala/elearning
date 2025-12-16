import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "preview"]

  trigger(event) {
    event.preventDefault()
    this.inputTarget.click()
  }

  preview() {
    const input = this.inputTarget
    const preview = this.previewTarget
    const file = input.files[0]

    if (file) {
      const reader = new FileReader()

      reader.onload = (e) => {
        preview.src = e.target.result
      }

      reader.readAsDataURL(file)
    }
  }
}
