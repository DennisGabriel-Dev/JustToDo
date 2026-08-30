import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.completing = false
  }

  markIntent() {
    const row = this.element.closest(".task-row")
    this.completing = row && !row.classList.contains("task-row--done")
  }

  onComplete(event) {
    if (!event.detail.success || !this.completing) return

    this.playSound()
    this.completing = false
  }

  playSound() {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      const t = ctx.currentTime

      const playTone = (freq, start, duration, volume = 0.2) => {
        const osc = ctx.createOscillator()
        const gain = ctx.createGain()
        osc.type = "sine"
        osc.frequency.setValueAtTime(freq, start)
        gain.gain.setValueAtTime(0.0001, start)
        gain.gain.exponentialRampToValueAtTime(volume, start + 0.015)
        gain.gain.exponentialRampToValueAtTime(0.0001, start + duration)
        osc.connect(gain)
        gain.connect(ctx.destination)
        osc.start(start)
        osc.stop(start + duration + 0.05)
      }

      playTone(523.25, t, 0.18, 0.22)
      playTone(659.25, t + 0.07, 0.22, 0.16)
      playTone(783.99, t + 0.14, 0.28, 0.12)
    } catch (_) {
      /* autoplay blocked or unsupported */
    }
  }
}
