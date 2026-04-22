// circuit_013: 涡流 — R₁R₂矩形回路+×磁场+导体棒AB
// LaTeX: scale=0.7, european
// 闭合: (-4,-1.5)→(4,-1.5)→R₂→(4,1.5)→(-4,1.5)→R₁→(-4,-1.5)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // ×磁场
    for x in (-3, -2, -1, 0, 1, 2, 3) {
      for y in (-1, 0, 1) {
        content((float(x), float(y)), text(size: 6pt)[$times$])
      }
    }
    // 闭合矩形回路
    line((-4, -1.5), (4, -1.5), stroke: w)
    draw-resistor((4, -1.5), (4, 1.5), label: $R_2$)
    line((4, 1.5), (-4, 1.5), stroke: w)
    draw-resistor((-4, 1.5), (-4, -1.5), label: $R_1$)
    // 导体棒AB（粗线）
    line((0.5, -1.8), (0.5, 1.8), stroke: 1.6pt + black)
    content((0.8, 1.9), text(size: 8pt)[$A$])
    content((0.8, -1.9), text(size: 8pt)[$B$])
  })
}
