import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.dragged = null
    this.onDragStart = this.handleDragStart.bind(this)
    this.onDragOver = this.handleDragOver.bind(this)
    this.onDrop = this.handleDrop.bind(this)
    this.onDragEnd = this.handleDragEnd.bind(this)
    this.onStreamRender = () => requestAnimationFrame(() => this.refresh())
    document.addEventListener("turbo:before-stream-render", this.onStreamRender)
    this.refresh()
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.onStreamRender)
    this.rows().forEach((row) => this.unbind(row))
  }

  refresh() {
    this.rows().forEach((row) => {
      this.unbind(row)
      row.draggable = true
      row.addEventListener("dragstart", this.onDragStart)
      row.addEventListener("dragover", this.onDragOver)
      row.addEventListener("drop", this.onDrop)
      row.addEventListener("dragend", this.onDragEnd)
    })
  }

  rows() {
    return this.element.querySelectorAll(".task-row")
  }

  unbind(row) {
    row.removeEventListener("dragstart", this.onDragStart)
    row.removeEventListener("dragover", this.onDragOver)
    row.removeEventListener("drop", this.onDrop)
    row.removeEventListener("dragend", this.onDragEnd)
  }

  handleDragStart(event) {
    this.dragged = event.currentTarget
    event.currentTarget.classList.add("task-row--dragging")
    event.dataTransfer.effectAllowed = "move"
  }

  handleDragOver(event) {
    event.preventDefault()
    const row = event.target.closest(".task-row")
    if (!row || row === this.dragged) return

    const rect = row.getBoundingClientRect()
    const before = event.clientY < rect.top + rect.height / 2
    if (before) {
      row.parentNode.insertBefore(this.dragged, row)
    } else {
      row.parentNode.insertBefore(this.dragged, row.nextSibling)
    }
  }

  handleDrop(event) {
    event.preventDefault()
    this.saveOrder()
  }

  handleDragEnd(event) {
    event.currentTarget.classList.remove("task-row--dragging")
    this.dragged = null
  }

  saveOrder() {
    const ids = [...this.element.querySelectorAll(".task-row")].map((row) =>
      row.id.replace("task_", "")
    )

    const body = new FormData()
    ids.forEach((id) => body.append("task_ids[]", id))

    fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("[name=csrf-token]").content,
        Accept: "application/json"
      },
      body
    })
  }
}
