import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "backdrop"]

  toggle() {
    this.sidebarTarget.classList.toggle("sidebar--open")
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.toggle("sidebar-backdrop--visible")
    }
  }

  close() {
    this.sidebarTarget.classList.remove("sidebar--open")
    if (this.hasBackdropTarget) {
      this.backdropTarget.classList.remove("sidebar-backdrop--visible")
    }
  }
}
