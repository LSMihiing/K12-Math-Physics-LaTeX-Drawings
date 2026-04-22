// circuit_006: 楞次定律 — 双检流计+×磁场+导体棒
// LaTeX: yscale=0.8
// 回路 (0,0)→(5,0)→G→(5,3.2)→(0,3.2)→G→(0,0)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.55cm, {
    import cetz.draw: *
    // 回路（闭合）
    line((0, 0), (5, 0), stroke: w)
    draw-meter((5, 0), (5, 3.2), label: $G$)
    line((5, 3.2), (0, 3.2), stroke: w)
    draw-meter((0, 3.2), (0, 0), label: $G$)
    // ×磁场
    for x in (0.5, 1.5, 2.5, 3.5, 4.5) {
      for y in (0.4, 1.2, 2.0, 2.8) {
        content((x, y), text(size: 6pt)[$times$])
      }
    }
    // 导体棒（白色填充矩形）
    rect((2.6, -0.2), (2.8, 3.4), fill: white, stroke: 0.4pt + black)
    // 速度箭头
    line((2.9, 1.6), (3.8, 1.6), stroke: 0.7pt + black,
      mark: (end: "stealth", fill: black))
    content((4.0, 1.8), text(size: 7pt)[$v$])
    // 标签
    content((0, -0.4), text(size: 7pt)[$E$])
    content((2.7, -0.4), text(size: 7pt)[$A$])
    content((5, -0.4), text(size: 7pt)[$D$])
    content((0, 3.6), text(size: 7pt)[$F$])
    content((2.7, 3.6), text(size: 7pt)[$B$])
    content((5, 3.6), text(size: 7pt)[$C$])
  })
}
