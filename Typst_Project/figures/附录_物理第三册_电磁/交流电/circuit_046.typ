// 3.tex:1835-1849 三角源连接
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    draw-inductor((0, 0), (-1.5, -2), coils: 3)
    draw-inductor((0, 0), (1.5, -2), coils: 3)
    draw-inductor((1.5, -2), (-1.5, -2), coils: 3)
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    circle((1.5, -2), radius: 0.05, fill: black, stroke: none)
    circle((-1.5, -2), radius: 0.05, fill: black, stroke: none)
    line((0, 0), (4, 0), stroke: w)
    content((4.2, 0), text(size: 5pt)[$A$])
    line((1.5, -2), (4, -2), stroke: w)
    content((4.2, -2), text(size: 5pt)[$B$])
    line((-1.5, -2), (-1.5, -3), stroke: w)
    line((-1.5, -3), (4, -3), stroke: w)
    content((4.2, -3), text(size: 5pt)[$C$])
    for y in (-2, -3, 0) {
      circle((4, y), radius: 0.04, fill: white, stroke: 0.5pt + black)
    }
  })
}
