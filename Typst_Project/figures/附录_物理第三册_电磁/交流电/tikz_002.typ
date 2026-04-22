// 来源：3.tex:139-160  交流电变化规律 — 含初相位φ₀的旋转线圈
// scale=1.5
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
    // 实线：当前位置
    let c30 = calc.cos(-30deg); let s30 = calc.sin(-30deg)
    line((0, 0), (1.5 * c30, 1.5 * s30), stroke: 0.4pt + black)
    line((0, 0), (2.2 * calc.cos(150deg), 2.2 * calc.sin(150deg)), stroke: 0.4pt + black)
    // 虚线：初始位置 -60°
    let c60 = calc.cos(-60deg); let s60 = calc.sin(-60deg)
    line((1.5 * calc.cos(120deg), 1.5 * calc.sin(120deg)),
      (1.5 * calc.cos(-60deg), 1.5 * calc.sin(-60deg)),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // 虚线矩形 rotate=-60
    let rot60(px, py) = (px * c60 - py * s60, px * s60 + py * c60)
    let q1 = rot60(-1.5, -0.07); let q2 = rot60(1.5, -0.07)
    let q3 = rot60(1.5, 0.07); let q4 = rot60(-1.5, 0.07)
    line(q1, q2, q3, q4, close: true,
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // 实线矩形 rotate=-30
    let rot30(px, py) = (px * c30 - py * s30, px * s30 + py * c30)
    let p1 = rot30(-1.5, -0.07); let p2 = rot30(1.5, -0.07)
    let p3 = rot30(1.5, 0.07); let p4 = rot30(-1.5, 0.07)
    line(p1, p2, p3, p4, close: true, stroke: 0.4pt + black)
    content((p1.at(0) - 0.1, p1.at(1) - 0.15), text(size: 8pt)[$d$])
    content((p3.at(0) + 0.1, p3.at(1) + 0.15), text(size: 8pt)[$a$])
    // 端点 ·/×
    for pair in ((rot30, -1.5, "cdot"), (rot30, 1.5, "times"), (rot60, -1.5, "cdot"), (rot60, 1.5, "times")) {
      let ep = (pair.at(0))(pair.at(1), 0)
      circle(ep, radius: 0.08, fill: white, stroke: 0.4pt + black)
      if pair.at(2) == "times" {
        content(ep, text(size: 5pt)[$times$])
      } else {
        circle(ep, radius: 0.02, fill: black, stroke: none)
      }
    }
    content((2.5, 0), text(size: 9pt)[$B$])
    // φ₀ 弧
    arc((0, 0), start: 90deg, stop: 117deg, radius: 1.3,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((calc.cos(103deg) * 1.5, calc.sin(103deg) * 1.5), text(size: 7pt)[$phi_0$])
    // ωt+φ₀ 弧
    arc((0, 0), start: 90deg, stop: 150deg, radius: 2,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((calc.cos(120deg) * 2.3, calc.sin(120deg) * 2.3), text(size: 7pt)[$omega t + phi_0$])
  })
}
