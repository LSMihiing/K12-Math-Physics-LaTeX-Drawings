// 来源：2.tex:188-204  楞次定律的应用 — 涡流环A（交替方向）
// scale=0.8  同心环+×符号中心
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 同心圆环（内环）
    circle((0, 0), radius: 1, stroke: 0.4pt + black)
    circle((0, 0), radius: 1.1, stroke: 0.4pt + black)
    // 同心圆环（外环）
    circle((0, 0), radius: 2, stroke: 0.4pt + black)
    circle((0, 0), radius: 2.1, stroke: 0.4pt + black)
    // 中心 × 符号阵列
    for x in (-0.5, 0, 0.5) {
      for y in (-0.35, 0.35) {
        content((x, y), text(size: 10pt)[$times$])
      }
    }
    // 电流方向弧箭头（交替方向）
    // 内环右侧：30°→-30°（顺时针）
    arc((0, 0), start: 30deg, stop: -30deg, radius: 1.3,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.3 * calc.cos(30deg), 1.3 * calc.sin(30deg) + 0.2),
      text(size: 9pt)[$A$])
    // 外环右侧：-30°→30°（逆时针）
    arc((0, 0), start: -30deg, stop: 30deg, radius: 2.3,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    // 内环左侧：210°→150°
    arc((0, 0), start: 210deg, stop: 150deg, radius: 1.3,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    // 外环左侧：150°→210°
    arc((0, 0), start: 150deg, stop: 210deg, radius: 2.3,
      anchor: "origin", stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((2.3 * calc.cos(210deg) - 0.1, 2.3 * calc.sin(210deg) - 0.2),
      text(size: 9pt)[$B$])
  })
}
