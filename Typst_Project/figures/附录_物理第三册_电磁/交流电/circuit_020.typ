// 3.tex:726-740 功率：AC源+L+R串联+A+V+W表
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((0, 0), (5, 0), stroke: w)
    // 右侧L+R串联（竖向）
    draw-inductor((5, 3), (5, 1.5), coils: 3)
    content((5.5, 2.3), text(size: 7pt)[$L$])
    draw-resistor((5, 1.5), (5, 0), label: $R$)
    // 顶部A表
    line((5, 3), (4, 3), stroke: w)
    draw-meter((4, 3), (1, 3), label: $A$)
    // V表
    circle((3.5, 0), radius: 0.04, fill: black, stroke: none)
    circle((3.5, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((3.5, 0), (3.5, 3), label: $V$)
    // AC源
    draw-ac-source(0, 0, 3)
    // W表+旁路
    circle((0.2, 3), radius: 0.04, fill: black, stroke: none)
    line((1, 3), (1, 0), stroke: w)
    line((1, 3), (1, 3.7), stroke: w)
    line((1, 3.7), (0.2, 3.7), stroke: w)
    line((0.2, 3.7), (0.2, 3), stroke: w)
    draw-meter((2, 3), (0, 3), label: $W$)
  })
}
