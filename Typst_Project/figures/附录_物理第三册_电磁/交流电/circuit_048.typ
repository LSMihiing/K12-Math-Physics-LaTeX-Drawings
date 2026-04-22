// 3.tex:1975-1994 逆变器：R+D₁+D₂+电池
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.45cm, {
    import cetz.draw: *
    // 主回路上下两线
    line((0, 0), (3, 0), stroke: w)
    line((3, 0), (5, 0), stroke: w)
    line((5, 0), (7, 0), stroke: w)
    draw-resistor((0, 4), (3, 4), label: $R$)
    line((3, 4), (5, 4), stroke: w)
    line((5, 4), (7, 4), stroke: w)
    // 左支路: D₁+battery (下行)
    circle((3, 4), radius: 0.05, fill: black, stroke: none)
    circle((3, 0), radius: 0.05, fill: black, stroke: none)
    draw-diode((3, 4), (3, 2))
    draw-battery((3, 2), (3, 0))
    content((2.3, 3), text(size: 6pt)[$D_1$])
    // 右支路: battery+D₂ (上行)
    circle((5, 0), radius: 0.05, fill: black, stroke: none)
    circle((5, 4), radius: 0.05, fill: black, stroke: none)
    draw-battery((5, 0), (5, 2))
    draw-diode((5, 2), (5, 4))
    content((5.7, 3), text(size: 6pt)[$D_2$])
    // 端子
    circle((0, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 4), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((7, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((7, 4), radius: 0.04, fill: white, stroke: 0.5pt + black)
    // u₁ u₂
    line((0, 0.1), (0, 3.9), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((-0.3, 1.7), (0.3, 2.3), fill: white, stroke: none)
    content((0, 2), text(size: 6pt)[$u_1$])
    line((7, 0.1), (7, 3.9), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((6.7, 1.7), (7.3, 2.3), fill: white, stroke: none)
    content((7, 2), text(size: 6pt)[$u_2$])
  })
}
