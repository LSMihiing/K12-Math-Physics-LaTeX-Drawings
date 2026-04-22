// 3.tex:925-939 变压器：升压/降压
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((0, 0), (2, 0), stroke: w)
    line((2, 0), (4, 0), stroke: w)
    // 二次线圈（右侧，高）
    line((4, 3), (2, 3), stroke: w)
    draw-inductor((2, 0), (2, 3), coils: 6)
    // 铁芯
    draw-core(2.3, 0.1, 2.9)
    content((2.3, 1.5), text(size: 6pt)[$n_2$])
    content((1.7, 0.7), text(size: 6pt)[$n_1$])
    // 一次线圈接线端（短）
    line((0, 1.5), (2, 1.5), stroke: w)
    // U₁ U₂
    rect((-0.25, 0.5), (0.25, 1.0), fill: white, stroke: none)
    content((0, 0.75), text(size: 7pt)[$U_1$])
    line((0, 0.1), (0, 1.4), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((3.75, 1.2), (4.25, 1.7), fill: white, stroke: none)
    content((4, 1.5), text(size: 7pt)[$U_2$])
    line((4, 0.1), (4, 2.9), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    // 端子
    circle((0, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 1.5), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((4, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((4, 3), radius: 0.04, fill: white, stroke: 0.5pt + black)
  })
}
