// 3.tex:326-341  余弦电流波 cos(x) + 时间轴刻度
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    line((-0.5, 0), (8.5, 0), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((8.8, 0), text(size: 8pt)[$t$(s)])
    line((0, -1.5), (0, 2.5), stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((0.3, 2.5), text(size: 8pt)[$i$(A)])
    // cos(x) 波
    let pts = ()
    for i in range(0, 101) {
      let t = float(i) / 100 * pi * 2.5
      pts.push((t, calc.cos(t)))
    }
    line(..pts, stroke: 1.6pt + black)
    // 虚线±1
    line((0, 1), (2 * pi, 1), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, -1), (pi, -1), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    content((-0.5, 1), text(size: 8pt)[$+10$])
    content((-0.5, -1), text(size: 8pt)[$-10$])
    // 时间刻度
    for (val, label) in ((0.05, "0.05"), (0.1, "0.1"), (0.15, "0.15"), (0.2, "0.2"), (0.25, "0.25")) {
      let x = val * 31.416
      line((x, 0), (x, 0.1), stroke: 0.4pt + black)
      content((x, -0.25), text(size: 6pt)[#label])
    }
    content((-0.25, -0.25), text(size: 8pt)[$0$])
  })
}
