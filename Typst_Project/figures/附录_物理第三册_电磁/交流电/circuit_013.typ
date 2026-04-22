// 3.tex:483-493 纯电感电路：AC源+L+A+V
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    // 底部
    line((0, 0), (3, 0), stroke: w)
    // 右侧电感L（竖向）
    draw-inductor((3, 0), (3, 3), coils: 4)
    content((2.7, 1.5), text(size: 7pt)[$L$])
    // 顶部A表
    line((0, 3), (1, 3), stroke: w)
    draw-meter((1, 3), (3, 3), label: $A$)
    // V表
    circle((1, 0), radius: 0.04, fill: black, stroke: none)
    circle((1, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((1, 0), (1, 3), label: $V$)
    // AC源
    line((0, 0), (0, 1.3), stroke: w)
    line((0, 1.7), (0, 3), stroke: w)
    circle((0, 1.3), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 1.7), radius: 0.04, fill: white, stroke: 0.5pt + black)
    content((0, 1.5), text(size: 8pt)[~])
  })
}
