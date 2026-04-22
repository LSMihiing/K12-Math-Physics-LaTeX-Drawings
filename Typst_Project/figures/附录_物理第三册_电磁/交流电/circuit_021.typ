// 3.tex:774-788 功率：AC源+L+R+C并联
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.55cm, {
    import cetz.draw: *
    line((0, 0), (6, 0), stroke: w)
    draw-inductor((6, 3), (6, 1.5), coils: 3)
    content((6.5, 2.3), text(size: 7pt)[$L$])
    draw-resistor((6, 1.5), (6, 0), label: $R$)
    draw-capacitor((5, 0), (5, 3))
    content((5.5, 1.5), text(size: 7pt)[$C$])
    line((6, 3), (4, 3), stroke: w)
    draw-meter((4, 3), (1, 3), label: $A$)
    circle((3.5, 0), radius: 0.04, fill: black, stroke: none)
    circle((3.5, 3), radius: 0.04, fill: black, stroke: none)
    draw-meter((3.5, 0), (3.5, 3), label: $V$)
    draw-ac-source(0, 0, 3)
    circle((0.2, 3), radius: 0.04, fill: black, stroke: none)
    line((1, 3), (1, 0), stroke: w)
    line((1, 3), (1, 3.7), stroke: w)
    line((1, 3.7), (0.2, 3.7), stroke: w)
    line((0.2, 3.7), (0.2, 3), stroke: w)
    draw-meter((2, 3), (0, 3), label: $W$)
  })
}
