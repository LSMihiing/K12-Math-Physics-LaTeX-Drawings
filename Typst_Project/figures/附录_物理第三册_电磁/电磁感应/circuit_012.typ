// circuit_012: 自感 — 电池+开关+并联(灯泡A/电感L)
// LaTeX: yscale=0.7
// 底部: (4,2.1)→(5,2.1)→(5,0)→switch→(2.5,0)→battery→(0,0)→(0,2.1)→(1,2.1)
// 上支路: (1,2.1)→(1,2.6)→lamp A→(4,2.6)→(4,2.1)
// 下支路: (1,2.1)→(1,1.6)→L→(4,1.6)→(4,2.1)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    // 底部主路（闭合）
    line((0, 0), (0, 2.1), stroke: w)
    draw-battery((2.5, 0), (0, 0))  // battery (2.5→0)
    draw-switch((5, 0), (2.5, 0))   // switch (5→2.5)
    line((5, 0), (5, 2.1), stroke: w)
    content((3.75, 0.4), text(size: 7pt)[$K$])
    // 并联汇合点
    line((0, 2.1), (1, 2.1), stroke: w)
    line((4, 2.1), (5, 2.1), stroke: w)
    circle((1, 2.1), radius: 0.05, fill: black, stroke: none)
    circle((4, 2.1), radius: 0.05, fill: black, stroke: none)
    // 上支路: 灯泡A
    line((1, 2.1), (1, 2.65), stroke: w)
    draw-lamp((1, 2.65), (4, 2.65))
    line((4, 2.65), (4, 2.1), stroke: w)
    content((2.5, 3.3), text(size: 7pt)[$A$])
    // 上支路电流箭头
    line((2.2, 2.65), (1.6, 2.65), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.3, 2.9), text(size: 7pt)[$I$])
    // 下支路: 电感L
    line((1, 2.1), (1, 1.55), stroke: w)
    draw-inductor((1, 1.55), (4, 1.55), coils: 4)
    line((4, 1.55), (4, 2.1), stroke: w)
    content((2.5, 1.0), text(size: 7pt)[$L$])
    // 下支路电流箭头
    line((2.2, 1.55), (1.6, 1.55), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
  })
}
