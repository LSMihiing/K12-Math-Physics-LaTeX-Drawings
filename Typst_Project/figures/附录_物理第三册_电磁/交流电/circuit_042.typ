// 3.tex:1709-1733 星形连接负载
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.4cm, {
    import cetz.draw: *
    // 负载Y型（3电阻）
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
    draw-resistor((0, 0), (2, -3), label: $2$)
    draw-resistor((0, 0), (-2, -3), label: $3$)
    draw-resistor((0, 0), (0, 4), label: $1$)
    // 接线
    line((0, 4), (-6, 4), stroke: w)
    line((-2, -3), (-6, -3), stroke: w)
    line((-6, -4), (2, -4), stroke: w)
    line((2, -4), (2, -3), stroke: w)
    line((0, 0), (-6, 0), stroke: w)
    // 端子
    for y in (0, -4, -3, 4) {
      circle((-6, y), radius: 0.04, fill: white, stroke: 0.5pt + black)
    }
    content((-6.5, 0), text(size: 6pt)[$O$])
    content((-6.5, -4), text(size: 6pt)[$B$])
    content((-6.5, -3), text(size: 6pt)[$C$])
    content((-6.5, 4), text(size: 6pt)[$A$])
    content((0.5, 0), text(size: 6pt)[$O'$])
    // U相 I线 I相
    line((-5, 0), (-5, 4), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((-5.4, 1.7), (-4.6, 2.3), fill: white, stroke: none)
    content((-5, 2), text(size: 5pt)[$U_"相"$])
    line((-5, 4), (-4, 4), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-4, 4.3), text(size: 5pt)[$I_"线"$])
    line((0, 4), (0, 3), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((0.4, 3), text(size: 5pt)[$I_"相"$])
  })
}
