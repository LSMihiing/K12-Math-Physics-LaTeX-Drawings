// 4.tex:183-229  电磁波传播 — 三时刻E场分布+方向箭头
#import "@preview/cetz:0.4.2"
#import "../交流电/_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    // 三组坐标轴
    for y-off in (0, 2, 4) {
      line((-0.5, float(y-off)), (20, float(y-off)), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
      content((20.3, float(y-off)), text(size: 7pt)[$z$])
      line((0, float(y-off) - 0.8), (0, float(y-off) + 1), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
      content((0.3, float(y-off) + 1), text(size: 7pt)[$E$])
      content((-0.25, float(y-off) - 0.25), text(size: 7pt)[$O$])
    }
    // 正弦波
    // 甲 t=0: sin(x) + 4
    let pts-a = sine-points(0, 4 * pi, amp: 0.7, offset-y: 4)
    line(..pts-a, stroke: 1.2pt + black)
    // 乙 t=T/2: -sin(x) + 2
    let pts-b = sine-points(0, 5 * pi, amp: -0.7, offset-y: 2)
    line(..pts-b, stroke: 1.2pt + black)
    // 丙 t=T: sin(x) + 0
    let pts-c = sine-points(0, 6 * pi, amp: 0.7, offset-y: 0)
    line(..pts-c, stroke: 1.2pt + black)
    // 竖直虚线
    for k in (1, 2, 3) {
      line((2 * pi * float(k), -1), (2 * pi * float(k), 5),
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    }
    // λ标注
    line((4 * pi, 4.5), (6 * pi, 4.5), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((5 * pi - 0.3, 4.25), (5 * pi + 0.3, 4.75), fill: white, stroke: none)
    content((5 * pi, 4.5), text(size: 7pt)[$lambda$])
    // 标签
    content((-4, 4), text(size: 8pt)[甲])
    content((-4, 2), text(size: 8pt)[乙])
    content((-4, 0), text(size: 8pt)[丙])
    content((-2, 4), text(size: 7pt)[$t=0$])
    content((-2, 2), text(size: 7pt)[$t=T\/2$])
    content((-2, 0), text(size: 7pt)[$t=T$])
    // E方向箭头（关键位置）
    let h = 0.7; let h2 = h / 1.414
    for (x, dy) in ((pi / 2, h), (pi * 1.5, -h), (pi / 4, h2), (pi * 0.75, h2), (pi * 1.25, -h2), (pi * 1.75, -h2)) {
      for y-off in (0, 2, 4) {
        let sign = if y-off == 2 { -1 } else { 1 }
        line((x, float(y-off)), (x, float(y-off) + sign * dy),
          stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
      }
    }
  })
}
