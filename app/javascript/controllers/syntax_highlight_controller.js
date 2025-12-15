import { Controller } from "@hotwired/stimulus"
import { highlightAll } from "@37signals/lexxy"

export default class extends Controller {
  connect() {
    highlightAll()
  }
}
