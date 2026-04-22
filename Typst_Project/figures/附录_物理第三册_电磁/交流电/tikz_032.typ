// 3.tex:1452-1458  全波整流+滤波后
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points, abs-sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 1.2cm, {
    import cetz.draw: *
    line((0, 2), (0, 0), (5.2, 0), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((0, 2.2), text(size: 8pt)[$U_R$])
    content((5.2, -0.2), text(size: 8pt)[$t$])
    let pts1 = abs-sine-points(0, 3 * pi / 2, amp: 1.5, freq: 2)
    line(..pts1, stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
    let pts2 = ()
    for i in range(0, 101) {
      let t = float(i) / 100 * 3 * pi / 2
      pts2.push((t, 0.2 * calc.cos(4.5 * t) + 1))
    }
    line(..pts2, stroke: 1.2pt + black)
    content((0, -0.2), text(size: 8pt)[$O$])
  })
}
