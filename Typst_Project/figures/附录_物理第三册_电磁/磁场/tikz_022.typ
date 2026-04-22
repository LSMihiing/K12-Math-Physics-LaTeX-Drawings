// 来源：1.tex:1147-1161  回旋加速器 — 倾斜入射+×磁场+极板间距d
// scale=0.6
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    // 上极板（带缝隙）
    line((-4.5, 2), (-0.2, 2), stroke: 1.2pt + black)
    line((0.2, 2), (4.5, 2), stroke: 1.2pt + black)
    content((5, 2), text(size: 9pt)[$-$])
    // 下极板
    line((-4.5, -2), (4.5, -2), stroke: 1.2pt + black)
    content((5, -2), text(size: 9pt)[$+$])

    // 竖直虚线
    line((0, 2.5), (0, 0),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))

    // v0 倾斜箭头 (-60°方向，长度2.5)
    let vx = 2.5 * calc.cos(-60deg)
    let vy = 2.5 * calc.sin(-60deg)
    line((0, 2), (vx, 2 + vy), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((vx + 0.3, 2 + vy), text(size: 9pt)[$v_0$])

    // ×符号阵列
    for x-val in (0.8, -0.8, 2.4, -2.4, 4, -4) {
      for y-val in (1, -1) {
        content((x-val, float(y-val)), text(size: 10pt)[$times$])
      }
    }

    // 距离标注 |<->| d
    line((-5, 2), (-5, -2), stroke: 0.4pt + black,
      mark: (start: "straight", end: "straight", fill: black))
    rect((-5.35, -0.25), (-4.65, 0.25), fill: white, stroke: none)
    content((-5, 0), text(size: 9pt)[$d$])

    // 角度弧 θ
    arc((0, 1.5), start: -90deg, stop: -60deg, radius: 0.5,
      anchor: "origin", stroke: 0.4pt + black)
    content((0.35, 1.2), text(size: 8pt)[$theta$])
  })
}
