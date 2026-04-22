// circuit_014: 涡流 — ×磁场中的矩形金属框A
// LaTeX: scale=0.7
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    // ×磁场
    for x in (-3, -2, -1, 0, 1, 2) {
      for y in (-1, 0, 1) {
        content((float(x), float(y)), text(size: 6pt)[$times$])
      }
    }
    // 矩形金属框
    rect((-1, 1.5), (0, 2.2), stroke: 0.7pt + black)
    content((0.3, 1.9), text(size: 8pt)[$A$])
  })
}
