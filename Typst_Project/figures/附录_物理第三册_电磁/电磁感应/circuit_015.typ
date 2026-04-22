// circuit_015: 涡流 — 电池+开关+×磁场+导体棒AB+安培力F
// LaTeX: scale=0.8
// 闭合: (0,0)→switch→(3,0)→(6,0)→(6,4)→(0,4)→battery→(0,0)
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *

#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    // 闭合回路
    draw-switch((0, 0), (3, 0))
    line((3, 0), (6, 0), stroke: w)
    line((6, 0), (6, 4), stroke: w)
    line((6, 4), (0, 4), stroke: w)
    draw-battery((0, 4), (0, 0))
    content((1.5, -0.3), text(size: 7pt)[$K$])
    // ×磁场
    for x in (0.5, 1.25, 2.0, 2.75, 3.5, 4.25, 5.0, 5.75) {
      for y in (0.5, 1.25, 2.0, 2.75, 3.5) {
        content((x, y), text(size: 5pt)[$times$])
      }
    }
    // 导体棒AB（粗线）
    line((4, 0), (4, 4), stroke: 1.6pt + black)
    content((4, 4.35), text(size: 7pt)[$A$])
    content((4, -0.35), text(size: 7pt)[$B$])
    // 端点半圆弧
    arc((4, 0), start: 0deg, stop: -180deg, radius: 0.1,
      anchor: "origin", stroke: 1.2pt + black)
    arc((4, 4), start: 0deg, stop: 180deg, radius: 0.1,
      anchor: "origin", stroke: 1.2pt + black)
    // 安培力F
    line((4, 2.3), (4.8, 2.3), stroke: 0.7pt + black,
      mark: (end: "stealth", fill: black))
    content((5.1, 2.3), text(size: 7pt)[$F$])
  })
}
