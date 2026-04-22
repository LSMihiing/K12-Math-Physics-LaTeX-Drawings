// 3.tex:346-359  两个不同频率正弦波 i₁/i₂ + φ₁/φ₂标注
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((-2, 0), (10, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((10.3, 0), text(size: 8pt)[$omega t$])
    line((0, -1.5), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1.5), text(size: 8pt)[$i$])
    // i₂: -cos(x+0.7)*0.7
    let pts2 = sine-points(0, 9, amp: -0.7, phase: 0.7 - calc.pi / 2)
    line(..pts2, stroke: 1.6pt + black)
    content((9.2, 0.7 * calc.cos(9 + 0.7)), text(size: 8pt)[$i_2$])
    let pts2d = sine-points(-1, 0, amp: -0.7, phase: 0.7 - calc.pi / 2, samples: 20)
    line(..pts2d, stroke: (paint: black, thickness: 1.6pt, dash: "dashed"))
    // i₁: sin(x+1)
    let pts1 = sine-points(0, 8.5, amp: 1, phase: 1)
    line(..pts1, stroke: 1.6pt + black)
    content((8.7, calc.sin(8.5 + 1) - 0.2), text(size: 8pt)[$i_1$])
    let pts1d = sine-points(-1, 0, amp: 1, phase: 1, samples: 20)
    line(..pts1d, stroke: (paint: black, thickness: 1.6pt, dash: "dashed"))
    content((-0.25, -0.25), text(size: 8pt)[$O$])
    // φ 标注
    let pi = calc.pi
    line((-1, 0), (-1, -1.5), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((pi / 2 - 0.7, 0), (pi / 2 - 0.7, -1.5), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, -1), (-1, -1), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((-0.5, -1.2), text(size: 7pt)[$phi_1$])
    line((0, -1), (pi / 2 - 0.7, -1), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content(((pi / 2 - 0.7) / 2, -1.2), text(size: 7pt)[$phi_2$])
  })
}
