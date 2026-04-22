// 3.tex:1875-1890  感应电动机 三相电流+时间标注
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 1.6cm, {
    import cetz.draw: *
    line((0, -1.3), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.2, 1.5), text(size: 8pt)[$i$])
    line((0, 0), (7, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((7.2, 0), text(size: 8pt)[$t$])
    content((-0.2, 0), text(size: 7pt)[$O$])
    // 三相电流 very thick
    let pts-a = sine-points(0, 2 * pi, amp: 0.9)
    line(..pts-a, stroke: 1.2pt + black)
    let pts-b = sine-points(0, 2 * pi, amp: 0.9, phase: 2 * pi / 3)
    line(..pts-b, stroke: 1.2pt + black)
    let pts-c = sine-points(0, 2 * pi, amp: 0.9, phase: 4 * pi / 3)
    line(..pts-c, stroke: 1.2pt + black)
    // 标签
    content((pi / 2, 1.2), text(size: 7pt)[$i_(A X)$])
    content((pi / 2 + 2 * pi / 3, 1.2), text(size: 7pt)[$i_(B Y)$])
    content((pi / 2 + 4 * pi / 3, 1.2), text(size: 7pt)[$i_(C Z)$])
    // 竖直虚线 + 时间标注
    for (frac, label) in ((2.0/3, "1/3 T"), (4.0/3, "2/3 T"), (2, "T")) {
      let x = pi * frac
      line((x, -1), (x, 1), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
      content((x + 0.2, -0.2), text(size: 6pt)[#label])
    }
  })
}
