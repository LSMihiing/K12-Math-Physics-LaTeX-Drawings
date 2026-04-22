// 3.tex:447-470 纯电感：双刀开关+灯泡+电感L
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.55cm, {
    import cetz.draw: *
    // 主回路
    line((0, 1), (0, 0.5), stroke: w)
    line((0, 0.5), (5, 0.5), stroke: w)
    line((5, 0.5), (5, 2), stroke: w)
    draw-lamp((2, 2), (3.5, 2))
    line((3.5, 2), (2, 2), stroke: w)
    line((2, 2), (2, 1), stroke: w)
    line((2, 1), (1, 1), stroke: w)
    draw-inductor((3.5, 2), (5, 2), coils: 3)
    content((4.2, 2.5), text(size: 7pt)[$L$])
    // 双刀开关接线柱
    for x in (0, 1) {
      for y in (0.2, -1, 1, 1.8, 3) {
        circle((float(x), y), radius: 0.04, fill: white, stroke: 0.5pt + black)
      }
    }
    // 开关刀片
    line((0, 1), (-0.3, 1.8), stroke: 1.2pt + black)
    line((1, 1), (0.7, 1.8), stroke: 1.2pt + black)
    // 横档
    line((-0.2, 1.5), (0.8, 1.5), stroke: 0.5pt + black)
    line((-0.25, 1.5), (0.75, 1.5), stroke: 1.0pt + black)
    line((-0.3, 1.6), (0.7, 1.6), stroke: 1.0pt + black)
    content((-0.5, 1), text(size: 7pt)[$K$])
    // 上下接线
    line((0, 0.2), (0, -1), stroke: w)
    line((1, 0.2), (1, -1), stroke: w)
    line((0, 1.8), (0, 3), stroke: w)
    line((1, 1.8), (1, 3), stroke: w)
    content((0.5, -1), text(size: 8pt)[~])
    content((0, 3.2), text(size: 7pt)[$-$])
    content((1, 3.2), text(size: 7pt)[$+$])
  })
}
