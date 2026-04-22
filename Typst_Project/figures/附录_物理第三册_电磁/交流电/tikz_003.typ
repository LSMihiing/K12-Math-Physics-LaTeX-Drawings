// 来源：3.tex:189-205  交流电变化规律 — 含初相位φ₀的正弦波
// xscale=0.7
#import "@preview/cetz:0.4.2"
#import "_sine_utils.typ": sine-points
#let render() = {
  let pi = calc.pi
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    // 坐标轴
    line((-1, 0), (11, 0), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((11.3, 0), text(size: 8pt)[$omega t$])
    line((pi / 6, -1.5), (pi / 6, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((pi / 6 + 0.3, 2.5), text(size: 8pt)[$i, u$])
    // 刻度线
    for x in (pi * 7 / 6, pi * 13 / 6, pi * 19 / 6) {
      line((x, -0.1), (x, 0.1), stroke: 0.4pt + black)
    }
    // 正弦波 ultra thick
    let pts = sine-points(0, 3 * pi, amp: 1.5)
    line(..pts, stroke: 1.6pt + black)
    // 虚线（y轴向下延伸）
    line((0, -1), (0, 0),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    // φ₀ 标注
    content((pi / 12, -0.5), text(size: 8pt)[$phi_0$])
    content((pi / 12, -2), text(size: 7pt)[$phi_0 = pi / 6 = 30°$])
    // 距离标注箭头
    line((-0.5, -0.5), (0, -0.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    line((pi / 6 + 0.5, -0.5), (pi / 6, -0.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((pi / 6 + 0.25, 0.25), text(size: 8pt)[$O$])
  })
}
