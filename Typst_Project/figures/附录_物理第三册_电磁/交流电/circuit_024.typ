// 3.tex:1180-1199 半波整流：变压器+二极管+R
// 一次线圈bumps朝右，二次线圈bumps朝左(mirror)，铁芯在中间
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.55cm, {
    import cetz.draw: *
    // AC源
    draw-ac-source(0, 0, 3)
    // 一次线圈（bumps朝右→铁芯侧）
    line((0, 0), (0.7, 0), stroke: w)
    draw-inductor((0.7, 0), (0.7, 3), coils: 5)
    line((0.7, 3), (0, 3), stroke: w)
    // 铁芯
    draw-core(1.1, 0.3, 2.7)
    content((1.1, 3.0), text(size: 6pt)[$B$])
    // 二次线圈（bumps朝左→铁芯侧，mirror!）
    draw-inductor((1.5, 0), (1.5, 3), coils: 5, mirror: true)
    content((1.5, 3.3), text(size: 6pt)[$a$])
    content((1.5, -0.3), text(size: 6pt)[$b$])
    // R + 回路
    line((1.5, 0), (5, 0), stroke: w)
    draw-resistor((5, 0), (5, 3), label: $R$)
    line((5, 3), (1.5, 3), stroke: w)
    // 二极管
    draw-diode((1.5, 3), (5, 3))
    content((3.1, 3.5), text(size: 6pt)[$D$])
    // u / u_R
    line((2.25, 0.1), (2.25, 2.9), stroke: 0.3pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((2.0, 1.2), (2.5, 1.7), fill: white, stroke: none)
    content((2.25, 1.5), text(size: 6pt)[$u$])
    line((4, 0.1), (4, 2.9), stroke: 0.3pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((3.75, 1.2), (4.25, 1.7), fill: white, stroke: none)
    content((4, 1.5), text(size: 6pt)[$u_R$])
    content((5.3, 0.8), text(size: 6pt)[$-$])
    content((5.3, 2.2), text(size: 6pt)[$+$])
  })
}
