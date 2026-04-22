// 3.tex:297-311  不同初相的两个正弦波 i₁/i₂ + Δφ标注
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    line((-2, 0), (7, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((7.3, 0), text(size: 8pt)[$omega t$])
    line((0, -1.5), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1.5), text(size: 8pt)[$i$])
    // i₁ sin(x+1)
    let pts1 = sine-points(0, 5.3, amp: 1, phase: 1)
    line(..pts1, stroke: 1.6pt + black)
    let pts1d = sine-points(-1, 0, amp: 1, phase: 1, samples: 20)
    line(..pts1d, stroke: (paint: black, thickness: 1.6pt, dash: "dashed"))
    content((1, 1.2), text(size: 8pt)[$i_1$])
    // i₂ 0.7*sin(x+0.5)
    let pts2 = sine-points(0, 5.8, amp: 0.7, phase: 0.5)
    line(..pts2, stroke: 1.2pt + black)
    content((5.8 + 0.2, 0.7 * calc.sin(5.8 + 0.5) + 0.15), text(size: 8pt)[$i_2$])
    let pts2d = sine-points(-0.5, 0, amp: 0.7, phase: 0.5, samples: 20)
    line(..pts2d, stroke: (paint: black, thickness: 1.2pt, dash: "dashed"))
    // φ 标注
    line((-1, 0), (-1, -1.5), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((-0.5, 0), (-0.5, -1), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, -1.2), (-1, -1.2), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((-0.5, -1.4), text(size: 7pt)[$phi_1$])
    line((0, -0.65), (-0.5, -0.65), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((-0.25, -0.5), text(size: 7pt)[$phi_2$])
    line((-1, -0.75), (-0.5, -0.75), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((-0.75, -0.6), text(size: 7pt)[$Delta phi$])
  })
}
