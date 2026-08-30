import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "label"]

  connect() {
    this.sync()
  }

  toggle() {
    const next = document.documentElement.dataset.theme === "dark" ? "light" : "dark"
    document.documentElement.dataset.theme = next
    localStorage.setItem("theme", next)
    this.sync()
  }

  sync() {
    const dark = document.documentElement.dataset.theme === "dark"
    if (this.hasIconTarget) {
      this.iconTarget.className = dark ? "fas fa-sun" : "fas fa-moon"
    }
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = dark ? "Modo claro" : "Modo escuro"
    }
  }
}
