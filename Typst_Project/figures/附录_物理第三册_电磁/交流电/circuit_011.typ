// 3.tex:412-425 纯电阻：AC源+R+A+V+W表+分流
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    // 底部
    line((0, 0), (5, 0), stroke: w)
    // 右侧R
    draw-resistor((5, 0), (5, 3), label: $R$)
    // 顶部：A表
    line((5, 3), (4, 3), stroke: w)
    draw-meter((4, 3), (1, 3), label: $A$)
    // V表
    circle((3.5, 0), radius: 0.04, fill: black, stroke: none)
    circle((3.5, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((3.5, 0), (3.5, 3), label: $V$)
    // AC源
    line((0, 0), (0, 1.3), stroke: w)
    line((0, 1.7), (0, 3), stroke: w)
    circle((0, 1.3), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 1.7), radius: 0.04, fill: white, stroke: 0.5pt + black)
    content((0, 1.5), text(size: 8pt)[~])
    // W表分流旁路
    circle((0.2, 3), radius: 0.04, fill: black, stroke: none)
    line((1, 3), (1, 0), stroke: w)
    line((1, 3), (1, 3.7), stroke: w)
    line((1, 3.7), (0.2, 3.7), stroke: w)
    line((0.2, 3.7), (0.2, 3), stroke: w)
    draw-meter((2, 3), (0, 3), label: $W$)
  })
}
