// circuit_011: 自感 — 电池+开关+R₁+双支路(L+A₁ / R+A₂)
// LaTeX: european style
// 底部: (2,0)←battery←(0,0)→up→(0,3)→分叉
// 底部: (2,0)→switch→(3,0)→(4,0)→R→(5.1,0)
// 上支路: (.5,3)→(.5,3.7)→choke L→lamp A₁→(4.5,3.7)
// 下支路: (1,1.6)→R→(2.1,1.6)→lamp A₂→(4.5,1.6)→(4.5,3.7)
// 汇合: (4.5,3.7)→(5.5,5.3/2)→(5.5,1)→(4.5,1)→(4.5,.2)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.55cm, {
    import cetz.draw: *
    // 底部主路
    draw-battery((2, 0), (0, 0))  // battery from (2,0) to (0,0)
    line((0, 0), (0, 3), stroke: w)
    draw-switch((2, 0), (3, 0))
    line((3, 0), (4, 0), stroke: w)
    draw-resistor((4, 0), (5.1, 0), label: $R_1$)
    content((2.5, -0.4), text(size: 7pt)[$K$])
    // 分叉节点 (0.5, 3)
    line((0, 3), (0.5, 3), stroke: w)
    circle((0.5, 3), radius: 0.05, fill: black, stroke: none)
    // 上支路: L + A₁
    line((0.5, 3), (0.5, 3.7), stroke: w)
    draw-inductor((0.5, 3.7), (2.5, 3.7), coils: 4)
    draw-lamp((2.5, 3.7), (4.5, 3.7))
    content((1.5, 4.3), text(size: 7pt)[$L$])
    content((3.5, 4.3), text(size: 7pt)[$A_1$])
    // 下支路分叉
    // 下支路分叉→R→灯泡A₂（连续路径）
    line((0.5, 3), (0.5, 1.6), stroke: w)
    line((0.5, 1.6), (1, 1.6), stroke: w,
      mark: (end: "stealth", fill: black))
    draw-resistor((1, 1.6), (2.1, 1.6), label: $R$)
    draw-lamp((2.1, 1.6), (4.5, 1.6))
    content((3.3, 2.2), text(size: 7pt)[$A_2$])
    // 右侧汇合
    line((4.5, 3.7), (4.5, 1.6), stroke: w)
    circle((4.5, 2.65), radius: 0.05, fill: black, stroke: none)
    line((4.5, 2.65), (5.5, 2.65), stroke: w,
      mark: (end: "stealth", fill: black))
    line((5.5, 2.65), (5.5, 1), stroke: w)
    line((5.5, 1), (5.1, 1), stroke: w)
    line((5.1, 1), (5.1, 0), stroke: w)
  })
}
