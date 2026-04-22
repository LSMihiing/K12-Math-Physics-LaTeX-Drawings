// 4.tex:63-70  阻尼振荡
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((0, 0), (13, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((-0.3, 0), text(size: 8pt)[$O$])
    line((0, -1), (0, 1), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 1), text(size: 8pt)[$i$])
    let pts = ()
    for i in range(0, 201) {
      let t = float(i) / 200 * 4 * calc.pi
      pts.push((t, 0.5 * calc.exp(-0.2 * t) * calc.cos(4.5 * t)))
    }
    line(..pts, stroke: 1.2pt + black)
    content((6.5, -1.5), text(size: 8pt)[乙：阻尼振荡])
  })
}
