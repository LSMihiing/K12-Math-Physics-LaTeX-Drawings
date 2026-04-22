// 3.tex:612-626 RC滤波：前级R+后级C
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.65cm, {
    import cetz.draw: *
    // 左回路
    line((0, 1.2), (0, 0), stroke: w)
    line((0, 0), (2, 0), stroke: w)
    circle((2, 0), radius: 0.04, fill: black, stroke: none)
    circle((2, 3), radius: 0.04, fill: black, stroke: none)
    draw-resistor((2, 0), (2, 3))
    line((2, 3), (0, 3), stroke: w)
    line((0, 3), (0, 1.8), stroke: w)
    // AC源标记
    content((0, 1.4), text(size: 6pt)[$-$])
    content((0, 1.6), text(size: 7pt)[~])
    circle((0, 1.2), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 1.8), radius: 0.04, fill: white, stroke: 0.5pt + black)
    content((-0.6, 1.75), text(size: 6pt)[前级])
    content((-0.6, 1.25), text(size: 6pt)[输出])
    // 右回路
    line((2, 0), (4, 0), stroke: w)
    line((4, 0), (4, 1.2), stroke: w)
    draw-capacitor((2, 3), (4, 3))
    line((4, 3), (4, 1.8), stroke: w)
    circle((4, 1.2), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((4, 1.8), radius: 0.04, fill: white, stroke: 0.5pt + black)
    content((4, 1.5), text(size: 7pt)[~])
    content((3.4, 1.75), text(size: 6pt)[后级])
    content((3.4, 1.25), text(size: 6pt)[输入])
  })
}
