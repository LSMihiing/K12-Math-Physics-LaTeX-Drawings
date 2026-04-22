// 3.tex:575-584 纯电容电路：AC源+C+A+V
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    line((0, 0), (3, 0), stroke: w)
    draw-capacitor((3, 0), (3, 3))
    line((0, 3), (1, 3), stroke: w)
    draw-meter((1, 3), (3, 3), label: $A$)
    circle((1, 0), radius: 0.04, fill: black, stroke: none)
    circle((1, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((1, 0), (1, 3), label: $V$)
    draw-ac-source(0, 0, 3)
  })
}
