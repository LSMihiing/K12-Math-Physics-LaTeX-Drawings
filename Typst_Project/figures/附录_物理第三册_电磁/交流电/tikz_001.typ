// 来源：3.tex:64-91  交流电变化规律 — 旋转线圈在磁场中
// scale=1.5  含旋转矩形(-30°) + ×/· + 磁感线 + 角度弧
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 1.5cm, {
    import cetz.draw: *
    // 水平磁感线
    for y in (0.25, 0.75, -0.25, -0.75) {
      line((-2, y), (2, y), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    // 中性面虚线
    line((0, -1.5), (0, 2.5),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    content((0.3, 2.5), text(size: 8pt)[中性面])
    // 旋转线圈位置虚线
    let c30 = calc.cos(-30deg); let s30 = calc.sin(-30deg)
    line((0, 0), (2.2 * calc.cos(-30deg), 2.2 * calc.sin(-30deg)),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, 0), (2.2 * calc.cos(150deg), 2.2 * calc.sin(150deg)),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // 旋转矩形 rotate=-30
    let rot(px, py) = (px * c30 - py * s30, px * s30 + py * c30)
    let p1 = rot(-1.5, -0.07); let p2 = rot(1.5, -0.07)
    let p3 = rot(1.5, 0.07); let p4 = rot(-1.5, 0.07)
    line(p1, p2, p3, p4, close: true, stroke: 0.4pt + black)
    // d/a 标签
    content((p1.at(0) - 0.1, p1.at(1) - 0.15), text(size: 8pt)[$d$])
    content((p3.at(0) + 0.1, p3.at(1) + 0.15), text(size: 8pt)[$a$])
    // ·/× 端点
    let ep1 = rot(-1.5, 0); let ep2 = rot(1.5, 0)
    circle(ep1, radius: 0.08, fill: white, stroke: 0.4pt + black)
    circle((ep1.at(0), ep1.at(1)), radius: 0.02, fill: black, stroke: none)
    circle(ep2, radius: 0.08, fill: white, stroke: 0.4pt + black)
    content(ep2, text(size: 6pt)[$times$])
    // v 速度箭头
    line((1.5 * calc.cos(150deg), 1.5 * calc.sin(150deg)),
      (1.5 * calc.cos(150deg) + 0.8 * calc.cos(-120deg),
       1.5 * calc.sin(150deg) + 0.8 * calc.sin(-120deg)),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((1.5 * calc.cos(150deg) + 0.8 * calc.cos(-120deg),
             1.5 * calc.sin(150deg) + 0.8 * calc.sin(-120deg) - 0.2),
      text(size: 8pt)[$v$])
    line((1.5 * calc.cos(-30deg), 1.5 * calc.sin(-30deg)),
      (1.5 * calc.cos(-30deg) + 0.8 * calc.cos(60deg),
       1.5 * calc.sin(-30deg) + 0.8 * calc.sin(60deg)),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((1.5 * calc.cos(-30deg) + 0.8 * calc.cos(60deg) + 0.1,
             1.5 * calc.sin(-30deg) + 0.8 * calc.sin(60deg) + 0.1),
      text(size: 8pt)[$v$])
    // ωt 角度弧
    arc((0, 0), start: 0deg, stop: 60deg, radius: 0.25,
      anchor: "origin", stroke: 0.4pt + black)
    let angle-x = 0.75 * 1.732 + 0.25
    content((angle-x + 0.15, -0.75 + 0.15), text(size: 7pt)[$omega t$])
    content((calc.cos(120deg) * 2.2, calc.sin(120deg) * 2.2), text(size: 8pt)[$omega t$])
    content((2.5, 0), text(size: 9pt)[$B$])
    // ωt 大弧
    arc((0, 0), start: 90deg, stop: 150deg, radius: 2,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
  })
}
