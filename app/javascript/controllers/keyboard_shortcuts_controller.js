import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["newLink"]

  connect() {
    this.handleKeydown = this.onKeydown.bind(this)
    window.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    window.removeEventListener("keydown", this.handleKeydown)
  }

  onKeydown(event) {
    if (this.isTyping(event.target)) return

    if (event.key === "n" || event.key === "N") {
      if (!this.hasNewLinkTarget) return
      event.preventDefault()
      this.newLinkTarget.click()
    }

    if (event.key === "Escape") {
      ;["new_task", "new_task_list"].forEach((id) => {
        const frame = document.getElementById(id)
        if (frame) frame.innerHTML = ""
      })
    }
  }

  isTyping(element) {
    return element.matches("input, textarea, select, [contenteditable=true]")
  }
}
