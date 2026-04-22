// circuit_005: 楞次定律 — 电池+开关+检流计 双回路
// LaTeX: yscale=0.5 → y值乘0.5
// 下回路 (0,0)→battery→(2,0)→switch→(4,0)→(5,0)→(5,1)→(0,1)→(0,0)
// 上回路 (0,1.5)→(5,1.5)→(5,2.5)→G→(0,2.5)→(0,1.5)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    // 下回路
    draw-battery((0, 0), (2, 0))
    draw-switch((2, 0), (4, 0))
    line((4, 0), (5, 0), stroke: w)
    line((5, 0), (5, 1), stroke: w)
    line((5, 1), (0, 1), stroke: w)
    line((0, 1), (0, 0), stroke: w)
    // 上回路
    line((0, 1.5), (5, 1.5), stroke: w)
    line((5, 1.5), (5, 2.5), stroke: w)
    draw-meter((5, 2.5), (0, 2.5), label: $G$)
    line((0, 2.5), (0, 1.5), stroke: w)
    // 标签
    content((-0.3, 1), text(size: 7pt)[$A$])
    content((-0.3, 1.5), text(size: 7pt)[$C$])
    content((5.3, 1), text(size: 7pt)[$B$])
    content((5.3, 1.5), text(size: 7pt)[$D$])
    content((3, -0.35), text(size: 7pt)[$K$])
  })
}
