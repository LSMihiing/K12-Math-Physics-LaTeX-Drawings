// 3.tex:1602-1623  三相交流电波形 eA,eB,eC
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    set-style(stroke: 0.4pt + black)
    // yscale=2 通过调整振幅实现
    line((0, 3), (0, 0), (7, 0), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    content((7.3, 0), text(size: 8pt)[$t$])
    content((0.3, 3), text(size: 8pt)[$e$])
    line((0, 0), (0, -3), stroke: 0.4pt + black)
    // 虚线±1和竖线
    line((0, -2), (2 * pi, -2), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((0, 2), (2 * pi, 2), stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    for k in range(1, 7) {
      line((float(k) * pi / 3, -2), (float(k) * pi / 3, 2),
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    }
    // 三相正弦波(yscale=2 → amp=2)
    let pts-a = sine-points(0, 2 * pi, amp: 2)
    line(..pts-a, stroke: 1.6pt + black)
    let pts-b = sine-points(0, 2 * pi, amp: 2, phase: -2 * pi / 3)
    line(..pts-b, stroke: 1.6pt + black)
    let pts-c = sine-points(0, 2 * pi, amp: 2, phase: 2 * pi / 3)
    line(..pts-c, stroke: 1.6pt + black)
    // T/3 标注
    line((0, -2.6), (2 * pi / 3, -2.6), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((pi / 3 - 0.3, -2.85), (pi / 3 + 0.3, -2.35), fill: white, stroke: none)
    content((pi / 3, -2.6), text(size: 7pt)[$T\/3$])
    // 波名标签
    content((pi / 2, 2.3), text(size: 8pt)[$e_A$])
    content((pi / 2 + 2 * pi / 3, 2.3), text(size: 8pt)[$e_B$])
    content((pi / 2 + 4 * pi / 3, 2.3), text(size: 8pt)[$e_C$])
  })
}
