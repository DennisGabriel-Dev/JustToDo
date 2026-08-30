import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.sync = this.sync.bind(this)
    this.sync()
    document.addEventListener("turbo:load", this.sync)
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.sync)
  }

  toggle() {
    const root = document.documentElement
    const current = root.getAttribute("data-theme") || "light"
    const next = current === "dark" ? "light" : "dark"
    root.setAttribute("data-theme", next)
    localStorage.setItem("theme", next)
    this.sync()
  }

  sync() {
    const dark = document.documentElement.getAttribute("data-theme") === "dark"
    const labelText = dark ? "Modo claro" : "Modo escuro"
    const iconClass = dark ? "fas fa-sun" : "fas fa-moon"

    document.querySelectorAll("[data-appearance-label]").forEach((el) => {
      el.textContent = labelText
    })

    document.querySelectorAll("[data-appearance-icon]").forEach((el) => {
      el.className = iconClass
    })
  }
}
