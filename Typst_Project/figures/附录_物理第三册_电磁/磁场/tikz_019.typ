// 来源：1.tex:974-991  回旋加速器（乙）侧视图 - 反向电场
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    line((0, 0), (9, 0), stroke: 0.4pt + black)
    content((-0.5, 0), text(size: 9pt)[$A$])
    content((9.5, 0), text(size: 9pt)[$A$])
    line((0, 2), (9, 2), stroke: 0.4pt + black)
    content((-0.5, 2), text(size: 9pt)[$A'$])
    content((9.5, 2), text(size: 9pt)[$A'$])
    // 反向电场箭头（<-）
    for x in range(1, 9) {
      line((float(x), 2), (float(x), 0), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    for x in range(1, 9) {
      content((float(x), 2.5), text(size: 9pt)[$+$])
      content((float(x), -0.5), text(size: 9pt)[$-$])
    }
    // 虚线半圆：(7,2) arc(0:180:2.25) 圆心在(4.75,2)
    arc((4.75, 2), start: 0deg, stop: 180deg, radius: 2.25,
      anchor: "origin",
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // 粒子圆
    circle((2.5, 1.7), radius: 0.25, stroke: 0.4pt + black)
    content((2.5, 1.7), text(size: 7pt)[$+$])
    // 标签
    content((2.3, 2.5), text(size: 9pt)[$A'_2$])
    content((7.2, 2.5), text(size: 9pt)[$A'_1$])
    // v2 箭头
    line((2.5, 1.45), (2.5, -1.3), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((2.5, -1.6), text(size: 9pt)[$v_2$])
    content((4.5, -2), text(size: 9pt)[乙])
  })
}
