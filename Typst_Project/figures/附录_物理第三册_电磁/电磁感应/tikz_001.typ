// 来源：2.tex:86-97  电磁感应现象 — 平行板穿过磁感线
// scale=0.8
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 竖直磁感线（向下，带箭头）
    for x in range(1, 6) {
      line((float(x), 5), (float(x), 0), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    // 白色填充平行四边形（导体板）
    line((1.8, 3), (4.8, 3), (4.2, 2), (1.2, 2), close: true,
      fill: white, stroke: 0.4pt + black)
    // 磁感线穿过板的上部（重画被板遮挡的部分）
    for x in (2, 3, 4) {
      line((float(x), 5), (float(x), 2.5), stroke: 0.4pt + black)
    }
  })
}
