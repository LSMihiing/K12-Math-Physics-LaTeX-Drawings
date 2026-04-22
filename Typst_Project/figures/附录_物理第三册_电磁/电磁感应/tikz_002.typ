// 来源：2.tex:102-111  电磁感应现象 — ×磁场中矩形线圈+旋转轴
// scale=0.8
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // ×符号阵列 6×5 (-3到2, -2到2)
    for x in (-3, -2, -1, 0, 1, 2) {
      for y in (-2, -1, 0, 1, 2) {
        content((float(x), float(y)), text(size: 10pt)[$times$])
      }
    }
    // 旋转轴虚线
    line((-0.5, -2.5), (-0.5, 3),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    content((-0.5, -2.8), text(size: 9pt)[$O'$])
    content((-0.5, 3.25), text(size: 9pt)[$O$])
    // 矩形线圈 very thick
    rect((-1.5, -1.5), (0.5, 1.5), stroke: 1.2pt + black)
    // 旋转方向弧箭头
    arc((-0.25, 2.5), start: 10deg, stop: 360deg,
      radius: (0.25, 0.125), anchor: "origin",
      stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
  })
}
