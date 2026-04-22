// 3.tex:674-692  电感对交流电相位影响 — u超前i π/2
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((-2, 0), (11, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((11.3, 0), text(size: 8pt)[$omega t$])
    line((0, -1.5), (0, 1.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1.5), text(size: 8pt)[$i, u$])
    let pts-u = sine-points(0, 3 * pi, amp: 1)
    line(..pts-u, stroke: 1.6pt + black)
    content((3 * pi + 0.3, calc.sin(3 * pi)), text(size: 8pt)[$u$])
    let pts-i = sine-points(0, 10, amp: 0.8, phase: -pi / 2)
    line(..pts-i, stroke: 1.2pt + black)
    content((10.3, 0.8 * calc.sin(10 - pi / 2) + 0.15), text(size: 8pt)[$i$])
    content((-0.25, -0.25), text(size: 8pt)[$O$])
    // 虚线
    for x in (1, 5) {
      line((float(x) * pi / 2, 0), (float(x) * pi / 2, 1),
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
      line((float(x) * pi / 2 + pi / 2, 0), (float(x) * pi / 2 + pi / 2, 0.8),
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    }
    line((3 * pi / 2, 0), (3 * pi / 2, -1),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((2 * pi, 0), (2 * pi, -0.8),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
  })
}
