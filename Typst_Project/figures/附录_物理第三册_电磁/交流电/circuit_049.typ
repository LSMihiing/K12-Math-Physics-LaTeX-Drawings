// 3.tex:2003-2014 涓夌浉Y-螖娣峰悎
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // 鍙戠數鏈篩鍨?    draw-inductor((0, 0), (0, 2), coils: 3)
    draw-inductor((0, 0), (-2, -1), coils: 3)
    draw-inductor((0, 0), (2, -1), coils: 3)
    content((0, 2), text(size: 5pt)[$A$])
    content((-2, -1), text(size: 5pt)[$B$])
    content((2, -1), text(size: 5pt)[$C$])
    // 璐熻浇螖鍨?    draw-resistor((5, 2), (3, -1))
    draw-resistor((5, 2), (7, -1))
    draw-resistor((3, -1), (7, -1))
    // 杩炵嚎
    line((0, 2), (5, 2), stroke: w)
    line((2, -1), (2, -1.5), stroke: w)
    line((2, -1.5), (7, -1.5), stroke: w)
    line((7, -1.5), (7, -1), stroke: w)
    line((-2, -1), (-2, -2), stroke: w)
    line((-2, -2), (3, -2), stroke: w)
    line((3, -2), (3, -1), stroke: w)
  })
}
