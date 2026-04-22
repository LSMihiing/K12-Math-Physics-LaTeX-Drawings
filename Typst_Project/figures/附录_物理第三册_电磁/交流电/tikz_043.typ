// 3.tex:1741-1765  三相电路连接 ia,ib,ic + 花括号标注
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    // yscale=1.6
    line((0, -2.56), (0, 2.88), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 2.88), text(size: 8pt)[$i$])
    line((0, 0), (7, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((7.3, 0), text(size: 8pt)[$t$])
    // 三相电流（yscale=1.6 → amp=1.5*1.6=2.4）
    let pts-a = sine-points(0, 2 * pi, amp: 2.4)
    line(..pts-a, stroke: 0.8pt + black)
    let pts-b = sine-points(0, 2 * pi, amp: 2.4, phase: 2 * pi / 3)
    line(..pts-b, stroke: 1.2pt + black)
    let pts-c = sine-points(0, 2 * pi, amp: 2.4, phase: 4 * pi / 3)
    line(..pts-c, stroke: 1.6pt + black)
    // 波名标签
    content((pi / 2, 2.7), text(size: 8pt)[$i_a$])
    content((pi / 2 + 2 * pi / 3, 2.7), text(size: 8pt)[$i_b$])
    content((pi / 2 + 4 * pi / 3, 2.7), text(size: 8pt)[$i_c$])
    // 竖直虚线
    line((3.5, 2.4 * calc.sin(3.5 + 2 * pi / 3)),
      (3.5, 2.4 * calc.sin(3.5 + 4 * pi / 3)),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // 花括号标注 ib, ic, ia
    // 简化为竖线+标签
    let x = 3.6
    let yb = 2.4 * calc.sin(x + 2 * pi / 3)
    let yc = 2.4 * calc.sin(x + 4 * pi / 3)
    let ya = 2.4 * calc.sin(x)
    content((3.9, (yb + 0) / 2), text(size: 7pt)[$i_b$])
    content((3.9, (0 + yc) / 2), text(size: 7pt)[$i_c$])
    content((3.2, (ya + 0) / 2), text(size: 7pt)[$i_a$])
  })
}
