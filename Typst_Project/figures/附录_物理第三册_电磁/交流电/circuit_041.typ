// 3.tex:1681-1697 电源星形连接
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    draw-inductor((0, 0), (0, 2), coils: 3)
    draw-inductor((0, 0), (-1.5, -1), coils: 3)
    draw-inductor((0, 0), (1.5, -1), coils: 3)
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    content((-0.3, 0.1), text(size: 5pt)[$O$])
    content((-0.3, 2), text(size: 5pt)[$A$])
    content((-1.8, -1), text(size: 5pt)[$C$])
    content((1.5, -1.3), text(size: 5pt)[$B$])
    line((0, 2), (5, 2), stroke: w)
    line((0, 0), (5, 0), stroke: w)
    line((1.5, -1), (5, -1), stroke: w)
    line((-1.5, -1), (-1.5, -1.5), stroke: w)
    line((-1.5, -1.5), (5, -1.5), stroke: w)
    // U相 U线
    line((3, 0.1), (3, 1.9), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((2.7, 0.7), (3.3, 1.3), fill: white, stroke: none)
    content((3, 1), text(size: 5pt)[$U_"相"$])
    line((4, -1), (4, 2), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((3.7, 0.2), (4.3, 0.8), fill: white, stroke: none)
    content((4, 0.5), text(size: 5pt)[$U_"线"$])
    for y in (0, 2, -1, -1.5) {
      circle((5, y), radius: 0.04, fill: white, stroke: 0.5pt + black)
    }
  })
}
