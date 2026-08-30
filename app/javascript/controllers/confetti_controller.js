import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { fire: Boolean }

  connect() {
    if (this.fireValue) {
      this.shoot()
      this.element.remove()
    }
  }

  shoot() {
    const canvas = document.createElement("canvas")
    canvas.className = "confetti-canvas"
    document.body.appendChild(canvas)

    const ctx = canvas.getContext("2d")
    const resize = () => {
      canvas.width = window.innerWidth
      canvas.height = window.innerHeight
    }
    resize()

    const colors = ["#7c3aed", "#a78bfa", "#22c55e", "#f59e0b", "#ec4899", "#3b82f6", "#fbbf24"]
    const cx = canvas.width * 0.5
    const cy = canvas.height * 0.38

    const particles = Array.from({ length: 140 }, () => ({
      x: cx + (Math.random() - 0.5) * 80,
      y: cy,
      vx: (Math.random() - 0.5) * 14,
      vy: Math.random() * -16 - 6,
      color: colors[Math.floor(Math.random() * colors.length)],
      w: Math.random() * 9 + 5,
      h: Math.random() * 6 + 3,
      rot: Math.random() * 360,
      rv: (Math.random() - 0.5) * 12,
      gravity: 0.28 + Math.random() * 0.12,
      opacity: 1
    }))

    let frame = 0
    const animate = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height)

      particles.forEach((p) => {
        p.vy += p.gravity
        p.vx *= 0.99
        p.x += p.vx
        p.y += p.vy
        p.rot += p.rv
        if (frame > 60) p.opacity -= 0.015

        ctx.save()
        ctx.globalAlpha = Math.max(0, p.opacity)
        ctx.translate(p.x, p.y)
        ctx.rotate((p.rot * Math.PI) / 180)
        ctx.fillStyle = p.color
        ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h)
        ctx.restore()
      })

      frame++
      if (frame < 110) {
        requestAnimationFrame(animate)
      } else {
        canvas.remove()
      }
    }

    animate()
  }
}
