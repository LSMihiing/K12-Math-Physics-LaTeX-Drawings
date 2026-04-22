// 3.tex:1802-1822 三角形连接负载
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.35cm, {
    import cetz.draw: *
    // Δ型负载（3电阻）
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    circle((5, 0), radius: 0.05, fill: black, stroke: none)
    circle((2.5, 4), radius: 0.05, fill: black, stroke: none)
    draw-resistor((0, 0), (5, 0), label: $2$)
    draw-resistor((5, 0), (2.5, 4), label: $1$)
    draw-resistor((2.5, 4), (0, 0), label: $3$)
    // 接线
    line((5, 0), (5, -2), stroke: w)
    line((5, -2), (-4, -2), stroke: w)
    line((0, 0), (-4, 0), stroke: w)
    line((2.5, 4), (-4, 4), stroke: w)
    // 端子
    for y in (0, -2, 4) {
      circle((-4, y), radius: 0.04, fill: white, stroke: 0.5pt + black)
    }
    content((-4.3, 0), text(size: 6pt)[$C$])
    content((-4.3, -2), text(size: 6pt)[$B$])
    content((-4.3, 4), text(size: 6pt)[$A$])
    // U线 I线 I相
    line((-3.5, 0), (-3.5, 4), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((-3.9, 1.7), (-3.1, 2.3), fill: white, stroke: none)
    content((-3.5, 2), text(size: 5pt)[$U_"线"$])
    line((-2, 4), (-1, 4), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-1, 4.3), text(size: 5pt)[$I_"线"$])
    line((2.5, 4), (2, 3.2), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.6, 3.2), text(size: 5pt)[$I_"相"$])
    line((2.5, 4), (3, 3.2), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((3.4, 3.2), text(size: 5pt)[$I_"相"$])
  })
}
