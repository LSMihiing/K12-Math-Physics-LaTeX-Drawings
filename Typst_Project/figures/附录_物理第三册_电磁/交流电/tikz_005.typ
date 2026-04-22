// 3.tex:279-291  同相位反相正弦波 i₁/i₂
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    line((-2, 0), (6, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((6.3, 0), text(size: 8pt)[$omega t$])
    line((0, -1.5), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1.5), text(size: 8pt)[$i$])
    let pts1 = sine-points(0, 5.3, amp: 1, phase: 1)
    line(..pts1, stroke: 1.6pt + black)
    let pts1d = sine-points(-1, 0, amp: 1, phase: 1, samples: 20)
    line(..pts1d, stroke: (paint: black, thickness: 1.6pt, dash: "dashed"))
    content((2, 0.8), text(size: 8pt)[$i_1$])
    // i₂ 反相 -0.7*sin(x+1)
    let pts2 = sine-points(0, 5.3, amp: -0.7, phase: 1)
    line(..pts2, stroke: 1.2pt + black)
    let pts2d = sine-points(-1, 0, amp: -0.7, phase: 1, samples: 20)
    line(..pts2d, stroke: (paint: black, thickness: 1.2pt, dash: "dashed"))
    content((1, -0.55), text(size: 8pt)[$i_2$])
    line((-1, 0), (-1, -1.5), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, -1), (-1, -1), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((-0.5, -0.8), text(size: 8pt)[$phi_0$])
  })
}
