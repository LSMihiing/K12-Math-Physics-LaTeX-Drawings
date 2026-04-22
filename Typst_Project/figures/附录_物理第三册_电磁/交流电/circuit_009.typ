// 3.tex:377-386 纯电阻电路：AC源+R+A表+V表
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    // 底部导线
    line((0, 0), (3, 0), stroke: w)
    // 右侧R（竖向）
    draw-resistor((3, 0), (3, 3), label: $R$)
    // 顶部：A表
    line((0, 3), (1, 3), stroke: w)
    draw-meter((1, 3), (3, 3), label: $A$)
    // V表（竖向，*-*）
    circle((1, 0), radius: 0.04, fill: black, stroke: none)
    circle((1, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((1, 0), (1, 3), label: $V$)
    // AC源（左侧竖线+断口+~符号）
    line((0, 0), (0, 1.3), stroke: w)
    line((0, 1.7), (0, 3), stroke: w)
    circle((0, 1.3), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 1.7), radius: 0.04, fill: white, stroke: 0.5pt + black)
    content((0, 1.5), text(size: 8pt)[~])
  })
}
