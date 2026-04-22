// 3.tex:1417-1425  滤波前后对比
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 1.2cm, {
    import cetz.draw: *
    line((0, 2), (0, 0), (5.2, 0), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((0, 2.2), text(size: 8pt)[$U_R$])
    content((5.2, -0.2), text(size: 8pt)[$t$])
    // 滤波前虚线半波
    let pts1 = sine-points(0, pi / 2, amp: 1.5, freq: 2)
    line(..pts1, stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    let pts2 = sine-points(pi, 3 * pi / 2, amp: 1.5, freq: 2)
    line(..pts2, stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    content((pi / 4, 1.75), text(size: 7pt)[滤波前])
    content((0, -0.2), text(size: 8pt)[$O$])
    // 滤波后折线
    let h1 = 1.5 * 0.866; let h2 = 1.5 / 1.414
    line((0, h1), (pi / 8, h2), (pi / 3, h1),
      (pi / 8 + pi, h2), (pi / 3 + pi, h1),
      stroke: 1.2pt + black)
    let last-x = pi / 3 + pi
    let last-y = h1
    line((last-x, last-y), (last-x + pi / 8, h2),
      stroke: 1.2pt + black)
    content((last-x + pi / 8 + 0.3, h2), text(size: 7pt)[滤波后])
  })
}
