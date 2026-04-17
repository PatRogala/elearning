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
    this.#celebrate()
  }

  #celebrate() {
    this.#playSuccessSound()
    this.#launchConfetti()
  }

  #playSuccessSound() {
    const ctx = new (window.AudioContext || window.webkitAudioContext)()

    const notes = [523.25, 659.25, 783.99, 1046.50] // C5, E5, G5, C6
    notes.forEach((freq, i) => {
      const osc = ctx.createOscillator()
      const gain = ctx.createGain()
      osc.connect(gain)
      gain.connect(ctx.destination)
      osc.type = "sine"
      osc.frequency.value = freq
      const start = ctx.currentTime + i * 0.12
      gain.gain.setValueAtTime(0.25, start)
      gain.gain.exponentialRampToValueAtTime(0.001, start + 0.3)
      osc.start(start)
      osc.stop(start + 0.3)
    })
  }

  #launchConfetti() {
    const canvas = document.createElement("canvas")
    canvas.style.cssText = "position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:9999"
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    document.body.appendChild(canvas)

    const ctx = canvas.getContext("2d")
    const colors = ["#494fdf", "#00a87e", "#e61e49", "#ec7e00", "#f4f4f4", "#191c1f"]
    const pieces = Array.from({ length: 120 }, () => ({
      x: Math.random() * canvas.width,
      y: Math.random() * -canvas.height,
      w: 8 + Math.random() * 8,
      h: 4 + Math.random() * 4,
      color: colors[Math.floor(Math.random() * colors.length)],
      vx: (Math.random() - 0.5) * 4,
      vy: 2 + Math.random() * 4,
      angle: Math.random() * Math.PI * 2,
      spin: (Math.random() - 0.5) * 0.2
    }))

    let frame
    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      let alive = false
      for (const p of pieces) {
        p.x += p.vx
        p.y += p.vy
        p.angle += p.spin
        if (p.y < canvas.height + 20) alive = true
        ctx.save()
        ctx.translate(p.x, p.y)
        ctx.rotate(p.angle)
        ctx.fillStyle = p.color
        ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h)
        ctx.restore()
      }
      if (alive) {
        frame = requestAnimationFrame(draw)
      } else {
        canvas.remove()
      }
    }
    frame = requestAnimationFrame(draw)
  }
}
