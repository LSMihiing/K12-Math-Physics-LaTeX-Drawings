// 3.tex:387-394  纯电阻电路 u/i 同相位正弦波
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    line((-0.5, 0), (8, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((8.3, 0), text(size: 8pt)[$omega t$])
    line((0, -1.5), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1.5), text(size: 8pt)[$i, u$])
    // u: sin(x) ultra thick
    let pts1 = sine-points(0, 2 * pi, amp: 1)
    line(..pts1, stroke: 1.6pt + black)
    content((1.7, 1.2), text(size: 8pt)[$u$])
    // i: 0.6*sin(x) very thick
    let pts2 = sine-points(0, 2 * pi, amp: 0.6)
    line(..pts2, stroke: 1.2pt + black)
    content((4.9, -0.4), text(size: 8pt)[$i$])
  })
}
