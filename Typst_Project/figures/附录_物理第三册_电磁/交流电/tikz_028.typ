// 3.tex:1378-1394  滤波甲乙丙
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    for y-off in (0, -3, -6) {
      line((0, y-off + 2), (0, float(y-off)), (14, float(y-off)), stroke: 0.4pt + black,
        mark: (start: "stealth", end: "stealth", fill: black))
      content((14.3, float(y-off)), text(size: 7pt)[$t$])
      content((-0.25, float(y-off) - 0.25), text(size: 7pt)[$O$])
    }
    content((0.2, 2), text(size: 7pt)[$i$])
    // 甲：sin(x)+1（偏移正弦波）
    let pts0 = sine-points(0, 4 * pi, amp: 1, offset-y: 1)
    line(..pts0, stroke: 1.6pt + black)
    // 乙：sin(x)-6（偏移正弦波）
    let pts1 = sine-points(0, 4 * pi, amp: 1, offset-y: -6)
    line(..pts1, stroke: 1.6pt + black)
    // 丙：水平线 y=-2
    line((0, -2), (4 * pi, -2), stroke: 1.6pt + black)
    content((-1, 1), text(size: 8pt)[甲])
    content((-1, -2), text(size: 8pt)[乙])
    content((-1, -5), text(size: 8pt)[丙])
  })
}
