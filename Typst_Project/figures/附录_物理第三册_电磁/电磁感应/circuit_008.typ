// circuit_008: 法拉第定律 — 检流计+×磁场+导体棒ab/a₁b₁
// LaTeX: scale=0.7
// (0,0)→(6.5,0) 下轨, (0,0)→G→(0,5)→(6.5,5) 上轨
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // 下轨道
    line((0, 0), (6.5, 0), stroke: w)
    // 左侧 G 检流计（竖向）
    draw-meter((0, 0), (0, 5), label: $G$)
    // 上轨道
    line((0, 5), (6.5, 5), stroke: w)
    // ×磁场
    for x in (1, 2, 3, 4, 5, 6) {
      for y in (1, 2, 3, 4) {
        content((float(x), float(y)), text(size: 6pt)[$times$])
      }
    }
    // 导体棒ab（实线白底）
    rect((3.4, -0.15), (3.6, 5.15), fill: white, stroke: 0.5pt + black)
    // 导体棒a₁b₁（虚线白底）
    rect((5.4, -0.15), (5.6, 5.15),
      fill: white, stroke: (paint: black, thickness: 0.5pt, dash: "dashed"))
    // 标签
    content((0, 5.4), text(size: 7pt)[$d$])
    content((0, -0.4), text(size: 7pt)[$c$])
    content((3.5, 5.4), text(size: 7pt)[$a$])
    content((3.5, -0.4), text(size: 7pt)[$b$])
    content((5.5, 5.4), text(size: 7pt)[$a_1$])
    content((5.5, -0.4), text(size: 7pt)[$b_1$])
  })
}
