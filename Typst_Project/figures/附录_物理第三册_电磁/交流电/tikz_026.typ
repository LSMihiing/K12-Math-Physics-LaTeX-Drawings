// 3.tex:1285-1324  全波整流甲乙丙
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    for y-off in (0, -3, -6) {
      line((0, y-off + 2), (0, float(y-off)), (14, float(y-off)), stroke: 0.4pt + black,
        mark: (start: "stealth", end: "stealth", fill: black))
      content((-0.25, float(y-off) - 0.25), text(size: 7pt)[$O$])
    }
    for k in range(1, 5) {
      line((pi * float(k), 0), (pi * float(k), -6),
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    }
    // 甲：完整正弦波
    let pts0 = sine-points(0, 4 * pi, amp: 1.2)
    line(..pts0, stroke: 1.6pt + black)
    // 乙：全波整流 u_R — 正半周 + 负半周翻转
    let pts1a = sine-points(0, pi, amp: 1.2, offset-y: -3)
    line(..pts1a, stroke: 1.6pt + black)
    let pts1b = sine-points(2 * pi, 3 * pi, amp: 1.2, offset-y: -3)
    line(..pts1b, stroke: 1.6pt + black)
    // 负半周翻转
    let pts1c = sine-points(pi, 2 * pi, amp: -1.2, offset-y: -3)
    line(..pts1c, stroke: 1.6pt + black)
    let pts1d = sine-points(3 * pi, 4 * pi, amp: -1.2, offset-y: -3)
    line(..pts1d, stroke: 1.6pt + black)
    // 丙：全波整流 i_R
    let pts2a = sine-points(0, pi, amp: 0.8, offset-y: -6)
    line(..pts2a, stroke: 1.6pt + black)
    let pts2b = sine-points(2 * pi, 3 * pi, amp: 0.8, offset-y: -6)
    line(..pts2b, stroke: 1.6pt + black)
    let pts2c = sine-points(pi, 2 * pi, amp: -0.8, offset-y: -6)
    line(..pts2c, stroke: 1.6pt + black)
    let pts2d = sine-points(3 * pi, 4 * pi, amp: -0.8, offset-y: -6)
    line(..pts2d, stroke: 1.6pt + black)
    // 标签
    content((-0.25, 2), text(size: 8pt)[$u$])
    content((-0.45, -1), text(size: 8pt)[$u_R$])
    content((-0.45, -4), text(size: 8pt)[$i_R$])
    content((pi - 0.25, -0.5), text(size: 7pt)[$T/2$])
    content((2 * pi + 0.25, -0.25), text(size: 7pt)[$T$])
    content((3 * pi - 0.25, -0.5), text(size: 7pt)[$3T\/2$])
    content((4 * pi + 0.25, -0.25), text(size: 7pt)[$2T$])
    content((-1, 1.5), text(size: 8pt)[甲])
    content((-1, -1.5), text(size: 8pt)[乙])
    content((-1, -4.5), text(size: 8pt)[丙])
  })
}
