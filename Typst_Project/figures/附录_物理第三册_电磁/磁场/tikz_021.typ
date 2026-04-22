// 来源：1.tex:1101-1112  回旋加速器 — 负电荷半圆轨迹
// scale=0.8
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 坐标轴
    line((-1, 0), (6, 0), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    // v0 竖直轴
    line((0, 0), (0, 3), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((0, 3.3), text(size: 9pt)[$v_0$])

    // 半圆轨迹 very thick: (0,0) arc(180:0:2.5) 圆心在(2.5,0)
    arc((2.5, 0), start: 180deg, stop: 0deg, radius: 2.5,
      anchor: "origin", stroke: 1.2pt + black)
    // 箭头在 90° 处
    arc((2.5, 0), start: 180deg, stop: 90deg, radius: 2.5,
      anchor: "origin", stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))

    // A 和 B 标签
    content((0, -0.5), text(size: 9pt)[$A$])
    content((5, -0.5), text(size: 9pt)[$B$])

    // 负电荷圆圈
    circle((0, 0), radius: 0.14, fill: white, stroke: 0.4pt + black)
    content((0, 0), text(size: 8pt)[$-$])
  })
}
