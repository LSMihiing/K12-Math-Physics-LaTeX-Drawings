// 4.tex:139-167  电磁波 — 平行板电容器+E/B场
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *
    // 平行板（斜线填充用线条代替）
    rect((-0.8, 0.6), (0.8, 0.8), stroke: 0.4pt + black)
    rect((-0.8, -0.8), (0.8, -0.6), stroke: 0.4pt + black)
    // 斜线填充（手动）
    for k in range(0, 9) {
      let x = -0.8 + float(k) * 0.2
      line((x, 0.6), (calc.min(x + 0.2, 0.8), 0.8), stroke: 0.3pt + black)
      line((x, -0.8), (calc.min(x + 0.2, 0.8), -0.6), stroke: 0.3pt + black)
    }
    // 引线
    line((0, 0.8), (0, 1.5), stroke: 0.4pt + black)
    line((0, -0.8), (0, -1.5), stroke: 0.4pt + black)
    // 板间虚线（电场E）
    for x in (-0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6) {
      line((x, -0.6), (x, 0.6), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    }
    // 弯曲虚线（板边）
    bezier((-0.8, -0.6), (-0.8, 0.6), (-1.2, 0),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    bezier((0.8, -0.6), (0.8, 0.6), (1.2, 0),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // B磁场椭圆
    for x in (0, 3, -3) {
      arc((float(x), 0), start: 0deg, stop: 360deg, radius: (0.9, 0.3),
        anchor: "origin", stroke: 0.8pt + black)
    }
    // E虚线圆
    for x in (1.5, -1.5) {
      circle((float(x), 0), radius: 0.8,
        stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
      content((float(x), 1), text(size: 8pt)[$E$])
    }
    // 半圆弧（左右）
    arc((4.5, 0), start: 90deg, stop: 270deg, radius: 0.8,
      anchor: "origin",
      stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    content((4.5, 1), text(size: 8pt)[$E$])
    arc((-4.5, 0), start: 90deg, stop: -90deg, radius: 0.8,
      anchor: "origin",
      stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    content((-4.5, 1), text(size: 8pt)[$E$])
    // B标签
    content((3, 0.5), text(size: 8pt)[$B$])
    content((-3, 0.5), text(size: 8pt)[$B$])
  })
}
