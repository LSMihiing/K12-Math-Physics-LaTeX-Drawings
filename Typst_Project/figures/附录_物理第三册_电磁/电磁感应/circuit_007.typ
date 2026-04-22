// circuit_007: 楞次定律 — 线圈回路+条形磁铁
// LaTeX: (0,0)→(0,1)→L→(2,1)→(2,0)→(0,0) + 磁铁(N/S)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    // 闭合回路
    line((0, 0), (0, 1), stroke: w)
    draw-inductor((0, 1), (2, 1), coils: 5)
    line((2, 1), (2, 0), stroke: w)
    line((2, 0), (0, 0), stroke: w)
    // 条形磁铁 N(红)/S(蓝)
    rect((2.3, 0.65), (3.5, 1.25), fill: rgb(230, 100, 100), stroke: 0.4pt + black)
    rect((3.5, 0.65), (4.75, 1.25), fill: rgb(100, 130, 230), stroke: 0.4pt + black)
    content((2.9, 0.95), text(size: 9pt, fill: white, weight: "bold")[$N$])
    content((4.1, 0.95), text(size: 9pt, fill: white, weight: "bold")[$S$])
  })
}
