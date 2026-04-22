// 3.tex:1528-1533 信号检波：AC表+电池+D+R
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    line((0, 0), (3, 0), stroke: w)
    draw-resistor((3, 0), (3, 3), label: $R$)
    draw-battery((1.5, 3), (0, 3))
    draw-meter((0, 0), (0, 3), label: text(size: 7pt)[~])
    draw-diode((1.5, 3), (3, 3))
    content((1, 1.5), text(size: 7pt)[信号])
  })
}
